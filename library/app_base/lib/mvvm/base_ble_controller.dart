import 'dart:async';

import 'package:common/base/mvvm/vm/base_view_model.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../ble/ble_manager.dart';
import '../ble/event/ble_event.dart';
import 'package:event_bus/event_bus.dart';

/** 这是为蓝牙定制的控制器 在binding的使用的时候必须是Get.put 不能采用lazy模式*/

abstract class BaseBleController extends BaseViewModel {
  late EventBus eventBus;
  bool listen = true;
  late BleManager manager;
  late StreamSubscription<AdapterStateChangedEvent> adapterStateChangedEvent;
  late StreamSubscription<DeviceConnectedEvent> deviceConnectedEvent;
  late StreamSubscription<DeviceDisconnectedEvent> deviceDisconnectedEvent;
  late StreamSubscription<DeviceUnknownErrorEvent> deviceUnknownErrorEvent;
  late StreamSubscription<ScanResultChangedEvent> scanResultChangedEvent;
   setListen(bool state){
     listen = state;
  }
  void onAdapterStateChanged(BluetoothAdapterState state);

  void onDeviceConnected(BluetoothDevice device);

  void onDeviceDisconnect();

  void onDeviceUnKnownError();

  void onScanResultChanged(List<ScanResult> result);

  @override
  void handleUnAuthorizedError(String? message) {}

  @override
  void onHidden() {}

  @override
  void showEmpty() {}

  @override
  void showError(String? message) {}

  @override
  void onInit() {
    super.onInit();
    manager = BleManager();
    eventBus = manager.eventBus!;
    adapterStateChangedEvent =
        eventBus.on<AdapterStateChangedEvent>().listen((event) {
          if(listen){
            onAdapterStateChanged(event.state);
          }
    });
    deviceConnectedEvent =
        eventBus.on<DeviceConnectedEvent>().listen((event) async {
          if(listen){
            onDeviceConnected(event.device);
          }
    });
    deviceDisconnectedEvent =
        eventBus.on<DeviceDisconnectedEvent>().listen((event) async {
          if(listen){
            onDeviceDisconnect();
          }
    });
    deviceUnknownErrorEvent =
        eventBus.on<DeviceUnknownErrorEvent>().listen((event) {
          if(listen){
            onDeviceUnKnownError();
          }
    });
    scanResultChangedEvent =
        eventBus.on<ScanResultChangedEvent>().listen((event) {
          if(listen){
            onScanResultChanged(event.result);
          }
    });
  }

  @override
  void onClose() {
    adapterStateChangedEvent.cancel();
    deviceConnectedEvent.cancel();
    deviceDisconnectedEvent.cancel();
    deviceUnknownErrorEvent.cancel();
    scanResultChangedEvent.cancel();
    super.onClose();
  }
}
