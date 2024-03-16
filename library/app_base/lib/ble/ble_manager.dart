import 'dart:async';
import 'package:app_base/ble/event/ble_event.dart';
import 'package:app_base/exports.dart';
import 'package:common/common/network/status_code.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:event_bus/event_bus.dart';

class BleManager {
  late StreamSubscription<BluetoothAdapterState> adapterStateStateSubscription;

  //扫描结果监听器
  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  BluetoothConnectionState bluetoothConnectionState =
      BluetoothConnectionState.disconnected;
  BluetoothAdapterState bluetoothAdapterState = BluetoothAdapterState.off;

  //连接监听器
  static StreamSubscription<BluetoothConnectionState>?
      connectionStateSubscription;

  //正在连接的设备
  BluetoothDevice? mDevice;

  EventBus? eventBus;

  //正在连接设备的可写入通道
  BluetoothCharacteristic? wwriteChar;

  setWriteChar(BluetoothCharacteristic? writeChar) {
    logE("writeChar$writeChar}");
    wwriteChar = writeChar;
  }

  checkRuntimeBleEnable() {
    if (mDevice == null) {
      return false;
    }
    if (wwriteChar == null) {
      return false;
    }
    if (mDevice!.isDisconnected) {
      return false;
    }
    return true;
  }

  factory BleManager() => _getInstance();
  static BleManager? _instance;

  static BleManager get instance => _getInstance();

  static BleManager _getInstance() {
    _instance ??= BleManager._create();
    return _instance!;
  }

  BleManager._create() {
    eventBus = EventBus();
    FlutterBluePlus.setLogLevel(LogLevel.none);
    adapterStateStateSubscription = FlutterBluePlus.adapterState.listen(
      (state) {
        bluetoothAdapterState = state;
        eventBus?.fire(AdapterStateChangedEvent(state));
      },
    );

  }

  isScanning() {
    return FlutterBluePlus.isScanningNow;
  }

  bool getDeviceStatus() {
    if (mDevice != null) {
      return mDevice?.isConnected == true;
    } else {
      return false;
    }
  }

  Timer? timer;

  stopScan() {
    scanResultsSubscription.cancel();
    timer = Timer(const Duration(seconds: 10), () {
      FlutterBluePlus.stopScan();
    });
  }

  startScan({required int timeout}) {
    if (timer != null) {
      timer?.cancel();
    }
    scanResultsSubscription = FlutterBluePlus.onScanResults.listen(
          (event) {
        logE('有结果');
        eventBus?.fire(ScanResultChangedEvent(event));
      },
    );
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: timeOut),
    );
  }

  void write(List<int> cmd) {
    wwriteChar?.write(cmd);
  }


  connect(BluetoothDevice device, int time) async {
    mDevice = device;
    //为这个设备注册一个连接监听器
    bluetoothConnectionState = BluetoothConnectionState.connecting;
    connectionStateSubscription = device.connectionState.listen((state) {
      if (state == BluetoothConnectionState.disconnected) {
        if (bluetoothConnectionState != BluetoothConnectionState.connecting) {
          if (bluetoothConnectionState !=
              BluetoothConnectionState.disconnected) {
            logE('断开连接');
            bluetoothConnectionState = state;
            connectionStateSubscription?.cancel();
            eventBus?.fire(DeviceDisconnectedEvent());
            setWriteChar(null);
            mDevice = null;
            showToast('蓝牙已断开');
          }
        } else {
          //状态混乱中，Android bug处理，扫描出来了但是连接失败
          logE('状态发生混乱');
          if (device.disconnectReason != null) {
            var disconnectReason = device.disconnectReason;
            int? code = disconnectReason?.code;
            if (code != null) {
              logE('混乱代码为：$code');
              if (code == 62 || code == 23789258 || code == 19) {
                bluetoothConnectionState =
                    BluetoothConnectionState.disconnected;
                connectionStateSubscription?.cancel();
                eventBus?.fire(DeviceDisconnectedEvent());
                setWriteChar(null);
                mDevice = null;
              }
            }
          }
        }
      } else if (state == BluetoothConnectionState.connected) {
        if (bluetoothConnectionState != BluetoothConnectionState.connected) {
          logE('连接中');
          bluetoothConnectionState = state;
          eventBus?.fire(DeviceConnectedEvent(mDevice!));
        }
      } else {
        logE('未知的连接状态');
        setWriteChar(null);
        mDevice = null;
        bluetoothConnectionState = state;
        eventBus?.fire(DeviceUnknownErrorEvent(state));
      }
    });
    await device.connect(timeout: Duration(seconds: time));
    bluetoothConnectionState = BluetoothConnectionState.connected;
  }
}

extension IntToBytes on int {
  List<int> toBytes() {
    return <int>[
      this & 0xFF,
      (this >> 8) & 0xFF,
      (this >> 16) & 0xFF,
      (this >> 24) & 0xFF
    ];
  }
}
