
class BleMSg {
  static const  List<int> headHex =[0x03,0x12];
  static const String notifyUUID = '0000ff11-0000-1000-8000-00805f9b34fb';
  static const String writeUUID = '0000ff12-0000-1000-8000-00805f9b34fb';
  static const String readUUID = '0000ff12-0000-1000-8000-00805f9b34fb';
  final List<int> _mCustomHeader = [0x03, 0x12, 0xf3];
  final List<int> _mCustomSilentHeader = [0x03,0x12,0xf5];
  final List<int> _mCustomModelPlayHeader = [0x03,0x12,0xF1];
  final List<int> _mUnQueueHeader = [0x03, 0x12, 0xf0];
  final List<int> _mModel = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12];
  List<int> initData() {
    return List.generate(17, (index) => 00);
  }
  /*自动播放*/
  List<int> generateAutoPlay(){
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
  }){
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
    data.replaceRange(0, 2, _mCustomHeader);
    data[2] = _mModel[i];
    return data;
  }
  List<int> generateStrengthData({
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
    cmdData.addAll(_mCustomHeader);
    cmdData.addAll(data);
    cmdData.add(0);
    return cmdData;
  }

  /*队列清除*/
  List<int> unQueue() {
    List<int> data = initData();
    data[0] = 0x07;
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

