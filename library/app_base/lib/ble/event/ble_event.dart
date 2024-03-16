import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceUnknownErrorEvent {
  BluetoothConnectionState state;
  DeviceUnknownErrorEvent(this.state);
}

class DeviceConnectedEvent {
  BluetoothDevice device;
  DeviceConnectedEvent(this.device);
}

class DeviceDisconnectedEvent {
  DeviceDisconnectedEvent();
}

class ScanResultChangedEvent {
  List<ScanResult> result;
  ScanResultChangedEvent(this.result);
}

class AdapterStateChangedEvent {
  BluetoothAdapterState state;
  AdapterStateChangedEvent(this.state);
}
