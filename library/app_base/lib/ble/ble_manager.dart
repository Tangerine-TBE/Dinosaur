import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:common/common/network/status_code.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

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
   final Rx<BluetoothDevice?> mDevice = Rx(null);
  BlueToothInterface interface;

  //正在连接设备的可写入通道
  BluetoothCharacteristic? wwriteChar;

  setWriteChar(BluetoothCharacteristic writeChar) {
    wwriteChar = writeChar;
  }

  setInterface(BlueToothInterface interface) {
    this.interface = interface;
  }

  isScanning() {
    return FlutterBluePlus.isScanningNow;
  }

  bool getDeviceStatus() {
    if (mDevice != null) {
      return mDevice.value?.isConnected == true;
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
    adapterStateStateSubscription.pause();
    scanResultsSubscription.pause();
    timer = Timer(const Duration(seconds: 10), () {
      FlutterBluePlus.stopScan();
    });
  }

  startScan({required int timeout}) {
    if(timer != null){
      timer?.cancel();
    }
    if(scanResultsSubscription.isPaused){
      scanResultsSubscription.resume();
    }
    if(adapterStateStateSubscription.isPaused){
      adapterStateStateSubscription.resume();
    }
    if(!FlutterBluePlus.isScanningNow){
      FlutterBluePlus.startScan(
        timeout: const Duration(seconds: timeOut),
      );
    }
  }

  void write(List<int> cmd) {
    wwriteChar?.write(cmd);
  }

  void onClose() {
    adapterStateStateSubscription.cancel();
    scanResultsSubscription.cancel();
  }

  connect(BluetoothDevice device, int time) async {
    mDevice.value = device;
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
            wwriteChar = null;
            mDevice.value = null;
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
                interface.onDeviceDisconnected();
                wwriteChar = null;
                mDevice.value = null;
              }
            }
          }
        }
      } else if (state == BluetoothConnectionState.connected) {
        if (bluetoothConnectionState != BluetoothConnectionState.connected) {
          logE('连接中');
          bluetoothConnectionState = state;
          interface.onDeviceConnected(mDevice.value);
        }
      } else {
        logE('未知的连接状态');
        wwriteChar = null;
        mDevice.value = null;
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
