import 'dart:async';

import 'package:common/base/mvvm/vm/base_view_model.dart';
import 'package:common/common/network/status_code.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

/** 这是为蓝牙定制的控制器 在binding的使用的时候必须是Get.put 不能采用lazy模式*/

abstract class BaseBleController extends BaseViewModel {
  //扫描状态监听器
  late StreamSubscription<BluetoothAdapterState> adapterStateStateSubscription;
  //扫描结果监听器
  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  //扫描状态监听器
  late StreamSubscription<bool> isScanningSubscription;
  late BluetoothConnectionState bluetoothConnectionState = BluetoothConnectionState.disconnected;
  //正在连接的设备
  BluetoothDevice? _mDevice;

  //正在连接设备的可写入通道
  BluetoothCharacteristic? _writeChar;

  setWriteChar(BluetoothCharacteristic writeChar) {
    this._writeChar = writeChar;
  }

  //连接监听器
  late StreamSubscription<BluetoothConnectionState> connectionStateSubscription;

  @override
  void handleUnAuthorizedError(String? message) {}

  @override
  void onHidden() {}

  @override
  void showEmpty() {}

  @override
  void showError(String? message) {}

  //当蓝牙状态发生改变时
  void onAdapterStateChanged(BluetoothAdapterState state);

  void onScanStateChanged(bool state);

  void onScanResultChanged(List<ScanResult> resultList);

  void onDeviceConnected(BluetoothDevice? device);

  void onDeviceDisconnected();

  void onDeviceUnKnowError(BluetoothConnectionState state);

  bool getDeviceStatus() {
    if (_mDevice != null) {
      return _mDevice?.isConnected == true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    //初始化控制器内部的监听
    adapterStateStateSubscription = FlutterBluePlus.adapterState.listen(
      (state) {
        onAdapterStateChanged(state);
      },
    );
    isScanningSubscription = FlutterBluePlus.isScanning.listen(
          (state) {
        onScanStateChanged(state);
      },
    );
    scanResultsSubscription = FlutterBluePlus.onScanResults.listen(
          (event) {
        onScanResultChanged(event);
      },
    );
  }

  stopScan()  {
    scanResultsSubscription.cancel();
    isScanningSubscription.pause();
     FlutterBluePlus.stopScan();
  }

  void startScan({required int timeout}) {
    scanResultsSubscription = FlutterBluePlus.onScanResults.listen(
          (event) {
        onScanResultChanged(event);
      },
    );
    isScanningSubscription.resume();
    FlutterBluePlus.startScan(timeout: const Duration(seconds: timeOut),);
  }

  Future<void> connect(BluetoothDevice device, int time) async {
    _mDevice = device;
    //为这个设备注册一个连接监听器
    bluetoothConnectionState = BluetoothConnectionState.connecting;
    connectionStateSubscription = device.connectionState.listen((state)  {
      if (state == BluetoothConnectionState.disconnected) {
        if(bluetoothConnectionState != BluetoothConnectionState.connecting){
          bluetoothConnectionState = state;
          onDeviceDisconnected();
          _writeChar = null;
          _mDevice = null;
        }else{
          //状态混乱中，Android bug处理
        }
      } else if (state == BluetoothConnectionState.connected) {
        bluetoothConnectionState = state;
        onDeviceConnected(_mDevice);
      } else {
        _writeChar = null;
        _mDevice = null;
        bluetoothConnectionState = state;
        onDeviceUnKnowError(state);
      }
    });
    await device.connect(timeout: Duration(seconds: time));
  }

  void write(List<int> cmd) {
    _writeChar?.write(cmd);
  }

  @override
  void onClose() {
    adapterStateStateSubscription.cancel();
    scanResultsSubscription.cancel();
    isScanningSubscription.cancel();
    connectionStateSubscription.cancel();
    super.onClose();
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
extension State on BluetoothConnectionState{
}

