import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:common/common/network/status_code.dart';
import 'package:dinosaur/app/src/moudle/test/device/base_ble_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/scan/scan_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/shakeit/shake_it_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/sideIt/side_it_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../pages/home/home_controller.dart';

class BleManager {
  late StreamSubscription<BluetoothAdapterState> adapterStateStateSubscription;

  //扫描结果监听器
  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  BluetoothConnectionState bluetoothConnectionState =
      BluetoothConnectionState.disconnected;
  BluetoothAdapterState bluetoothAdapterState = BluetoothAdapterState.off;
  //连接监听器
  late StreamSubscription<BluetoothConnectionState>
      connectionStateSubscription;

  factory BleManager() => _getInstance();
  static BleManager? _instance;

  static BleManager get instance => _getInstance();

  static BleManager _getInstance() {
    _instance ??= BleManager._create();
    return _instance!;
  }

  BleManager._create() {
    FlutterBluePlus.setLogLevel(LogLevel.none);
    adapterStateStateSubscription = FlutterBluePlus.adapterState.listen(
      (state) {
        bluetoothAdapterState = state;
        logE('state');
        getController().onAdapterStateChanged(state);
      },
    );

  }

  getController(){
    BaseBleController controller;
    switch(Get.routing.current){
      case RouteName.scanPage:
        controller=   Get.find<ScanController>();
        break;
      case RouteName.homePage:
        controller=   Get.find<HomeController>();
        break;
      case RouteName.sidePage:
        controller=   Get.find<SideItController>();

        break;
      case RouteName.shakePage:
        controller=   Get.find<ShakeItController>();
        break;
      default:
        controller=   Get.find<HomeController>();
        break;
    }
    logE(controller.toString());
    return controller;
  }


  isScanning() {
    return FlutterBluePlus.isScanningNow;
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
        logE('scanResult');
        getController().onScanResultChanged(event);
      },
    );
    FlutterBluePlus.startScan(
      timeout: const Duration(seconds: timeOut),
    );
  }

  connect(BluetoothDevice device, int time) async {
    //为这个设备注册一个连接监听器
    try{
      await device.connect(timeout: Duration(seconds: time),autoConnect: false);
      connectionStateSubscription = device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          if (bluetoothConnectionState !=
              BluetoothConnectionState.disconnected) {
            bluetoothConnectionState = state;
            logE('disconnect');
            getController().onDeviceDisconnect();
            showToast('蓝牙已断开');
          }
        } else if (state == BluetoothConnectionState.connected) {
          if (bluetoothConnectionState != BluetoothConnectionState.connected) {
            bluetoothConnectionState = state;
            logE('connect');
            getController().onDeviceConnected(device);
          }
        } else {
          logE('未知的连接状态');
          bluetoothConnectionState = state;
          logE('unknown');
          getController().onDeviceUnKnownError();
        }
      });
    }catch(e){
      getController().onDeviceDisconnect();
    }


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
