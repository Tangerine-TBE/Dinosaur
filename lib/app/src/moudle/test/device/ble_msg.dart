import 'dart:typed_data';

import 'package:dinosaur/app/src/moudle/test/device/play_device.dart';
import 'package:dinosaur/app/src/moudle/test/device/run_time.dart';

class BleMSg {
  static const List<int> headHex = [0x03, 0x12];
  static const String notifyUUID = '0000ff11-0000-1000-8000-00805f9b34fb';
  static const String writeUUID = '0000ff12-0000-1000-8000-00805f9b34fb';
  static const String readUUID = '0000ff12-0000-1000-8000-00805f9b34fb';
  static const String deviceInfoUUID = '00002A50-0000-1000-8000-00805F9B34FB';
  final List<int> _mCustomHeader = [0x03, 0x12, 0xf3];
  final List<int> _mCustomSilentHeader = [0x03, 0x12, 0xf5];
  final List<int> _mCustomModelPlayHeader = [0x03, 0x12, 0xF1];
  final List<int> _mUnQueueHeader = [0x03, 0x12, 0xf0];
  final List<int> _mModel = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];

  List<int> initData() {
    return List.generate(17, (index) => 00);
  }

  /*自动播放*/
  List<int> generateAutoPlay() {
    //streamFirst表示通道一设置
    List<int> streamFirst = List.generate(8, (index) => 00);
    //streamSecond表示通道二设置
    List<int> streamSecond = List.generate(8, (index) => 00);
    streamFirst[0] = 0xff;
    streamFirst[1] = 0xff;
    streamFirst[2] = 0xff;
    streamFirst[3] = 0xff;
    streamFirst[4] = 0xff;
    streamFirst[5] = 0xff;
    streamFirst[6] = 0xff;
    streamFirst[7] = 0xff;
    streamSecond[0] = 0x00;
    streamSecond[1] = 0x00;
    streamSecond[2] = 0x00;
    streamSecond[3] = 0x00;
    streamSecond[4] = 0x00;
    streamSecond[5] = 0x00;
    streamSecond[6] = 0x00;
    streamSecond[7] = 0x00;
    List<int> data = initData();
    data.replaceRange(0, 8, streamFirst);
    data.replaceRange(8, 17, streamSecond);
    var cmdData = <int>[];
    cmdData.addAll(_mCustomModelPlayHeader);
    cmdData.addAll(data);
    cmdData.add(0);
    return cmdData;
  }

  List<int> generateStopData() {
    List<int> data = initData();
    data[0] = 0;
    var cmdData = <int>[];
    cmdData.addAll(headHex);
    cmdData.addAll(data);
    cmdData.add(0);
    return cmdData;
  }

  List<int> generateScale2Cmd({required double strengthValue,double? subControlValue ,double? hotControlValue}){
    if(Runtime.deviceInfo.value!.type == '019' && subControlValue != null){
     return generate019DStrengthDouble(strengthValue.toInt() << 6 | 60, subControlValue / 1023);
    }else if(hotControlValue != null){
      return setStrengthAddHot(hotControlValue.toInt() << 6 | 60, strengthValue.toInt() << 6 | 60);
    }else if(subControlValue != null){
      return setStrengthDouble(strengthValue.toInt() << 6 | 60,subControlValue.toInt() << 6 | 60);
    }else{
      return setStrengthDouble(strengthValue.toInt() << 6 | 60,strengthValue.toInt() << 6 | 60);
    }
  }
  /*强度变更*/
  List<int> generateStrengthSilentData({
    int streamFirstValue = 0,
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
    int streamFirstResult = 0;
    int streamSecondResult = 0;
    if (streamFirstValue != 0) {
      streamFirstResult = streamFirstValue << 6 | streamFirstKeepTime;
      List<int> streamFirstResults = streamFirstResult.toBytes();
      streamFirstResults.removeWhere((element) => element == 00);
      if (streamFirstResults.length == 1) {
        streamFirstResults.add(0);
      }
      streamFirst.replaceRange(6, 8, streamFirstResults);
    }
    if (streamSecondValue != 0) {
      streamSecondResult = streamSecondValue << 6 | streamSecondKeepTime;
      List<int> streamSecondResults = streamSecondResult.toBytes();
      streamSecondResults.removeWhere((element) => element == 00);
      if (streamSecondResults.length == 1) {
        streamSecondResults.add(0);
      }
      streamSecond.replaceRange(6, 8, streamSecondResults);
    }
    List<int> data = initData();
    data.replaceRange(0, 8, streamFirst);
    data.replaceRange(8, 17, streamSecond);
    var cmdData = <int>[];
    cmdData.addAll(_mCustomSilentHeader);
    cmdData.addAll(data);
    cmdData.add(0);
    return cmdData;
  }

  /*模式变更*/
  List<int> generateModelData(int i) {
    List<int> data = initData();
    data[0] = _mModel[i];
    var cmdData = <int>[];
    cmdData.addAll(headHex);
    cmdData.addAll(data);
    cmdData.add(0);
    return cmdData;
  }
  List<int> setStrengthAddHot(int addHotValue, int strengValue) {
    var array = Uint8List(20);
    var dataView = ByteData.view(array.buffer);
    array[0] = 0x03;
    array[1] = 0x12;
    array[2] = 0xF3;
    dataView.setUint16(3, addHotValue, Endian.little);
    dataView.setUint16(11, 1008 << 6, Endian.little);
    dataView.setUint16(13, 1016 << 6, Endian.little);
    dataView.setUint16(15, 5 << 6, Endian.little);
    dataView.setUint16(17, strengValue, Endian.little);
    return array.buffer.asUint8List();
  }
  List<int> generate019DStrengthDouble(int strengthValue, double subControlValue) {
    var array = Uint8List(20);
    var dataView = ByteData.view(array.buffer);

    array[0] = 0x03;
    array[1] = 0x12;
    array[2] = 0xF3;

    dataView.setUint16(3, 1008 << 6, Endian.little);
    dataView.setUint16(5, 1 << 6, Endian.little);
    dataView.setUint16(7, strengthValue, Endian.little);

    dataView.setUint16(11, 1001 << 6, Endian.little);
    dataView.setUint16(13, 1016 << 6, Endian.little);

    if (subControlValue == 0) {
      dataView.setUint16(15, 100 << 6, Endian.little);
      dataView.setUint16(17, 0 | 63, Endian.little);
    } else {
      var frequency = ((subControlValue * 4 + 9) * 10).toInt();
      var dutyCycle = ((0.1 * (1 - subControlValue) + 0.4) * 1023).toInt();
      dataView.setUint16(15, frequency << 6, Endian.little);
      dataView.setUint16(17, dutyCycle << 6 | 63, Endian.little);
    }

    return array.buffer.asUint8List();
  }


  Uint8List setStrengthDouble(int value1, int value2) {
    var array = Uint8List(20);
    var dataView = ByteData.view(array.buffer);

    array[0] = 0x03;
    array[1] = 0x12;
    array[2] = 0xF3;

    dataView.setUint16(3, 1008 << 6, Endian.little);
    dataView.setUint16(5, 1016 << 6, Endian.little);
    dataView.setUint16(7, 5 << 6, Endian.little);
    dataView.setUint16(9, value1, Endian.little);
    dataView.setUint16(11, 1008 << 6, Endian.little);
    dataView.setUint16(13, 1016 << 6, Endian.little);
    dataView.setUint16(15, 5 << 6, Endian.little);
    dataView.setUint16(17, value2, Endian.little);

    return array.buffer.asUint8List();
  }

  /*无队列*/
  List<int> unQueue() {
    List<int> data = initData();
    data[0] = 0x07;
    var cmdData = <int>[];
    cmdData.addAll(_mUnQueueHeader);
    cmdData.addAll(data);
    return cmdData;
  }

  List<int> clearQueue() {
    List<int> data = initData();
    data[0] = 0x03;
    var cmdData = <int>[];
    cmdData.addAll(_mUnQueueHeader);
    cmdData.addAll(data);
    return cmdData;
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
