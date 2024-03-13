import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:common/common/network/status_code.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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
  BluetoothDevice? _mDevice;
  BlueToothInterface interface;

  //正在连接设备的可写入通道
  BluetoothCharacteristic? _writeChar;

  setWriteChar(BluetoothCharacteristic writeChar) {
    _writeChar = writeChar;
  }

  setInterface(BlueToothInterface interface) {
    this.interface = interface;
  }

  isScanning() {
    return FlutterBluePlus.isScanningNow;
  }

  bool getDeviceStatus() {
    if (_mDevice != null) {
      return _mDevice?.isConnected == true;
    } else {
      return false;
    }
  }

  Timer? timer;

  BleManager.create(this.interface) {
    FlutterBluePlus.setLogLevel(LogLevel.none);
    adapterStateStateSubscription = FlutterBluePlus.adapterState.listen(
      (state) {
        bluetoothAdapterState = state;
        interface.onAdapterStateChanged(state);
      },
    );
    scanResultsSubscription = FlutterBluePlus.onScanResults.listen(
      (event) {
        interface.onScanResultChanged(event);
      },
    );
  }

  stopScan() {
    scanResultsSubscription.pause();
    timer = Timer(const Duration(seconds: 10), () {
      FlutterBluePlus.stopScan();
    });
  }

  startScan({required int timeout}) {
    timer?.cancel();
    scanResultsSubscription.resume();
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: timeOut),
    );
  }

  void write(List<int> cmd) {
    _writeChar?.write(cmd);
  }

  void onClose() {
    adapterStateStateSubscription.cancel();
    scanResultsSubscription.cancel();
  }

  connect(BluetoothDevice device, int time) async {
    _mDevice = device;
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
            interface.onDeviceDisconnected();
            _writeChar = null;
            _mDevice = null;
          }
        } else {
          //状态混乱中，Android bug处理
          logE('状态发生混乱');
          if (device.disconnectReason != null) {
            var disconnectReason = device.disconnectReason;
            int? code = disconnectReason?.code;
            if (code != null) {
              logE('混乱代码为：$code');
              if (code == 62) {
                bluetoothConnectionState =
                    BluetoothConnectionState.disconnected;
                connectionStateSubscription?.cancel();
                interface.onDeviceDisconnected();
                _writeChar = null;
                _mDevice = null;
              }
            }
          }
        }
      } else if (state == BluetoothConnectionState.connected) {
        if (bluetoothConnectionState != BluetoothConnectionState.connected) {
          logE('连接中');
          bluetoothConnectionState = state;
          stopScan();
          interface.onDeviceConnected(_mDevice);
        }
      } else {
        logE('未知的连接状态');
        _writeChar = null;
        _mDevice = null;
        bluetoothConnectionState = state;
        interface.onDeviceUnKnowError(state);
      }
    });
    await device.connect(timeout: Duration(seconds: time));
    bluetoothConnectionState = BluetoothConnectionState.connected;
  }
}

abstract class BlueToothInterface {
  onDeviceUnKnowError(BluetoothConnectionState state);

  onDeviceConnected(BluetoothDevice? device);

  onDeviceDisconnected();

  onScanResultChanged(List<ScanResult> result);

  onAdapterStateChanged(BluetoothAdapterState state);
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
