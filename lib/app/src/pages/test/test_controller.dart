import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_base/exports.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app_base/ble/ble_msg.dart';

class TestController extends BaseController {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  List<ScanResult> _scanResults = [];
  ValueNotifier<double> valueNotifier = ValueNotifier<double>(0);
  late StreamSubscription<bool> _isScanningSubscription;
  bool _isScanning = false;
  String deviceName = 'XHTKJ';
  Timer? dataSendTimer;
  //connect
  int? _rssi;
  int? _mtuSize;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  List<BluetoothService> _services = [];
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  bool _isDisconnecting = false;
  bool queenSend = false;
  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;
  late BluetoothDevice connectedDevice;
  late List<int> mData;
  List<int> mCustomHeader = [0x03, 0x12,0xf3];
  List<int> mClearHeader = [0x03,0x12,0xf0];
  List<int> mModel = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
  late BluetoothCharacteristic writeChar;
  var lastTime = DateTime.now();
  @override
  void onInit() async {
    valueNotifier.addListener(() {
      logE('${valueNotifier.value}');
    });

    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (_adapterState == BluetoothAdapterState.off) {
        Get.snackbar('tips', 'open the bluetooth connection');
      }
    });
    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
    });
    _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
      (results) async {
        _scanResults = results;
        for (int i = 0; i < _scanResults.length; i++) {
          var bleDevice = _scanResults[i].device;
          if (bleDevice.platformName == deviceName) {
            stop();
            connectedDevice = bleDevice;
            _connectionStateSubscription =
                bleDevice.connectionState.listen((state) async {
              _connectionState = state;
              if (state == BluetoothConnectionState.connected) {
                _services = []; // must rediscover services
              }
              if (state == BluetoothConnectionState.connected &&
                  _rssi == null) {
                _rssi = await bleDevice.readRssi();
              }
            });
            _mtuSubscription = bleDevice.mtu.listen((value) {
              _mtuSize = value;
            });
            try {
              await connectedDevice.connect(
                  timeout: const Duration(seconds: 20));
            } catch (e) {
              logE(e.toString());
            }
            if (connectedDevice.isConnected) {
              List<BluetoothService> services =
                  await connectedDevice.discoverServices();
              services.forEach((service) async {
                var characteristics = service.characteristics;
                for (BluetoothCharacteristic c in characteristics) {
                  if (c.characteristicUuid ==
                      Guid.fromString(BleMSg.notifyUUID)) {
                    List<int> msg = await c.read();
                    logE('the notify msg is $msg');
                  } else if (c.characteristicUuid ==
                      Guid.fromString(BleMSg.writeUUID)) {
                    writeChar = c;
                  }
                }
              });
            }
            break;
          }
        }
      },
      onError: (e) {
        Get.snackbar('tips', e);
      },
    );
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
  }

  void stop() {
    FlutterBluePlus.stopScan();
  }

  void buttonClicked(int model) {
    if (connectedDevice.isConnected) {
      writeChar.write(generateModelData(model));
    }
  }

  List<int> generateModelData(int i) {
    mData.replaceRange(0, 2, mCustomHeader);
    mData[2] = mModel[i];
    return mData;
  }

  /// 强度值为 0 - 1023
  ///   时间为 1-63

  List<int> generateStrengthData(
      {int streamFirstValue = 0,
    int streamSecondValue = 0,
    int streamFirstHz = 0,
    int streamFirstTime = 0,
    int streamSecondHz = 0,
    int streamSecondTime = 0,
    int streamFirstKeepTime = 50,
    int streamSecondKeepTime = 50,
  }) {
    //streamFirst表示通道一设置
    List<int> streamFirst = List.generate(8, (index) => 00);
    //streamSecond表示通道二设置
    List<int> streamSecond = List.generate(8, (index) => 00);
    //streamFirst配置设置 --频率单位设置



    //streamFirst强度值设置
    if(streamFirstValue !=0){
      int streamFirstResult = streamFirstValue << 6 | streamFirstKeepTime;
      List<int> streamFirstResults = streamFirstResult.toBytes();
      streamFirstResults.removeWhere((element) => element == 00);
      streamFirst.replaceRange(6,  8, streamFirstResults);
      logE('通道一的数据为 ==$streamFirst ');
    }
    mData = initData();
    mData.replaceRange(0, 8, streamFirst);
    mData.replaceRange(8, 17, streamSecond);
    var cmdData = <int>[];
    cmdData.addAll(mCustomHeader);
    cmdData.addAll(mData);
    cmdData.add(0);
    logE('发送的数据为 ==$cmdData ===size ==${cmdData.length}');
    return cmdData;
  }
  List<int> clear(){
    mData = initData();
    mData[0] = 0x03;
    var cmdData = <int>[];
    cmdData.addAll(mClearHeader);
    cmdData.addAll(mData);
    logE('发送的数据为 ==$cmdData ===size ==${cmdData.length}');

    return cmdData;
  }
  List<int> noQueen(){
    mData = initData();
    mData[0] = 0x07;
    var cmdData = <int>[];
    cmdData.addAll(mClearHeader);
    cmdData.addAll(mData);
    logE('发送的数据为 ==$cmdData ===size ==${cmdData.length}');
    return cmdData;
  }

  @override
  void onClose() {
    _adapterStateStateSubscription.cancel();
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
  }

  List<int> initData() {
    return List.generate(17, (index) => 00);
  }
  void writeData(int v){
    var currentTime = DateTime.now();
    if(currentTime.millisecondsSinceEpoch - lastTime.millisecondsSinceEpoch >=500){
      lastTime = currentTime;
      int value = (1023/100 * v) .toInt();
      writeChar.write(generateStrengthData(streamFirstValue: value,streamFirstKeepTime: 50));
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
