import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_base/exports.dart';
import 'package:app_base/util/StringUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:test01/app/src/pages/test1/testBean/MsgBean.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/pages/test1/widget/host_edit_dialog.dart';

class Test1Controller extends BaseController {
  final chatListId = 1;
  static const String askForAddress = '1';
  static const String askForKeptAlive = '2';
  static const String askForCheckAvailable = '3';
  static const String askFoContent = '4';
  final int listen = 8081;
  String serverHost = '';
  int serverPort = 0;
  String targetIp = '';
  final originIp = ''.obs;
  final Rx<bool> sendInput = false.obs;
  RawDatagramSocket? rawDatagramSocket;
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  String needReply = '';
  Timer? timer;
  final List<MsgBean> charData = <MsgBean>[];
  setTargetIp(String targetIp){
    this.targetIp = targetIp;
    sendInput.value = true;
  }
  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    serverHost = SaveKey.sendHost.read ?? '';
    serverPort = SaveKey.sendPort.read ?? 0;

    if (serverHost.isNotEmpty) {
      startUdp();
    }
  }

  void setting() {
    Get.dialog(
      HostEditDialog(
        onConfirm: (value, target) {
          rawDatagramSocket?.close();
          Get.back();
          List<String> hostAndPort = value.split('/');
          serverHost = hostAndPort.first;
          serverPort = int.parse(hostAndPort.last);
          SaveKey.sendPort.save(serverPort);
          SaveKey.sendHost.save(serverHost);
          targetIp = target;
          if (targetIp.isNotEmpty) {
            sendInput.value = true;
          }
          startUdp();
        },
        onCancel: () {
          Get.back();
        },
        host: serverHost,
        port: serverPort.toString(),
      ),
    );
  }

  @override
  void onResumed() {
    super.onResumed();
    //Todo
  }

  @override
  void onPaused() {
    super.onPaused();
    //Todo
  }

  void startUdp() async {
    rawDatagramSocket =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, listen);
    rawDatagramSocket?.broadcastEnabled = true;
    rawDatagramSocket?.listen((event) async {
      Datagram? dg = rawDatagramSocket?.receive();
      if (dg != null) {
        timer?.cancel();
        if (needReply.startsWith(askForAddress)) {
          var data = StringUtils.bytesToDecimalString(dg.data).split('.');
          data.removeRange(4, 8);
          var dataString = '';
          for (int i = 0; i < data.length; i++) {
            dataString += data[i];
            if (i < data.length - 1) {
              dataString += '.';
            }
          }
          originIp.value = dataString;
          _udpStartCommand('3:$dataString');
        } else if (needReply.startsWith(askForKeptAlive)) {
          if (dg.data.length > 8) {
            //收到消息
            logE(StringUtils.bytesToDecimalString(dg.data));
            targetIp = StringUtils.bytesToDecimalString(dg.data.sublist(4,8));
            setTargetIp(targetIp);
            logE(targetIp);
            charData.insert(
                0,
                MsgBean.create(
                    msg: StringUtils.decodeString(dg.data.sublist(10)),
                    type: 1,
                    size: charData.length + 1));
            update([chatListId]);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController
                  .jumpTo(scrollController.position.minScrollExtent);
            });
          } else {
            var data = StringUtils.bytesToDecimalString(dg.data).split('.');
            if (data.isNotEmpty) {
              if (data.length == 8) {
                if (int.parse(data[0]) == int.parse(originIp.split('.')[0]) &&
                    int.parse(data[1]) == int.parse(originIp.split('.')[1]) &&
                    int.parse(data[2]) == int.parse(originIp.split('.')[2]) &&
                    int.parse(data[3]) == int.parse(originIp.split('.')[3]) &&
                    int.parse(data[4]) == 0 &&
                    int.parse(data[5]) == 0 &&
                    int.parse(data[6]) == 0 &&
                    int.parse(data[7]) == 0) {
                  //云端错误响应（终端地址失效）
                  _udpStartCommand('1');
                  logE('云端错误响应（终端地址失效）');
                } else if (targetIp.isNotEmpty && int.parse(data[0]) ==
                        int.parse(targetIp.split('.')[0]) &&
                    int.parse(data[1]) == int.parse(targetIp.split('.')[1]) &&
                    int.parse(data[2]) == int.parse(targetIp.split('.')[2]) &&
                    int.parse(data[3]) == int.parse(targetIp.split('.')[3]) &&
                    int.parse(data[4]) == 0 &&
                    int.parse(data[5]) == 0 &&
                    int.parse(data[6]) == 0 &&
                    int.parse(data[7]) == 0) {
                  //云端错误响应（目标地址失效）

                  logE('云端错误响应（目标地址失效）');
                } else if (int.parse(data[0]) == 0 &&
                    int.parse(data[1]) == 0 &&
                    int.parse(data[2]) == 0 &&
                    int.parse(data[3]) == 0 &&
                    int.parse(data[4]) == int.parse(originIp.split('.')[0]) &&
                    int.parse(data[5]) == int.parse(originIp.split('.')[1]) &&
                    int.parse(data[6]) == int.parse(originIp.split('.')[2]) &&
                    int.parse(data[7]) == int.parse(originIp.split('.')[3])) {
                  //云端错误响应（源地址非自身）：

                  logE('云端错误响应（源地址非自身）');
                } else if (targetIp.isNotEmpty && int.parse(data[0]) ==
                        int.parse(targetIp.split('.')[0]) &&
                    int.parse(data[1]) == int.parse(targetIp.split('.')[1]) &&
                    int.parse(data[2]) == int.parse(targetIp.split('.')[2]) &&
                    int.parse(data[3]) == int.parse(targetIp.split('.')[3]) &&
                    int.parse(data[4]) == int.parse(originIp.split('.')[0]) &&
                    int.parse(data[5]) == int.parse(originIp.split('.')[1]) &&
                    int.parse(data[6]) == int.parse(originIp.split('.')[2]) &&
                    int.parse(data[7]) == int.parse(originIp.split('.')[3])) {
                  //发送成功（目标终端将接收到包）：

                  logE('发送成功（目标终端将接收到包）');
                } else if (int.parse(data[0]) ==
                        int.parse(originIp.split('.')[0]) &&
                    int.parse(data[1]) == int.parse(originIp.split('.')[1]) &&
                    int.parse(data[2]) == int.parse(originIp.split('.')[2]) &&
                    int.parse(data[3]) == int.parse(originIp.split('.')[3]) &&
                    int.parse(data[4]) == int.parse(originIp.split('.')[0]) &&
                    int.parse(data[5]) == int.parse(originIp.split('.')[1]) &&
                    int.parse(data[6]) == int.parse(originIp.split('.')[2]) &&
                    int.parse(data[7]) == int.parse(originIp.split('.')[3])) {
                  //心跳成功
                  _udpStartCommand('2:${needReply.split(':')[1]}');
                }else{
                  logE(StringUtils.decodeString(dg.data));
                }
                return;
              }
            }
          }
          _udpStartCommand('1');
        } else if (needReply.startsWith(askForCheckAvailable)) {
          var data = StringUtils.bytesToDecimalString(dg.data).split('.');
          if (data.isNotEmpty) {
            if (data.length == 8) {
              if (int.parse(data[4]) == 0 &&
                  int.parse(data[5]) == 0 &&
                  int.parse(data[6]) == 0 &&
                  int.parse(data[7]) == 0) {
              } else {
                _udpStartCommand('2:${needReply.split(':')[1]}');
              }
            }
          }
        }
      }
    });
    //开启自动询答模式
    //1.请求有效地址
    _udpStartCommand('1');
  }

  void udpWriteContent(String text) {
    List<int> data = <int>[];
    //1.需要目标地址
    var target = targetIp.split('.');
    if (target.isNotEmpty) {
      for (var e in target) {
        var num = int.parse(e);
        data.add(num);
      }
      var origin = originIp.split('.');
      if (origin.isNotEmpty) {
        for (var e in origin) {
          var num = int.parse(e);
          data.add(num);
        }
        data.addAll([0xff, 0xff]);
        data.addAll(StringUtils.stringToByteList(text));
        rawDatagramSocket?.send(data, InternetAddress(serverHost), serverPort);
        textEditingController.clear();
        charData.insert(
            0, MsgBean.create(msg: text, type: 0, size: charData.length + 1));
        update([chatListId]);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.minScrollExtent);
        });
      }
    }
  }

  void _udpStartCommand(String text) async {
    List<int> data = <int>[];
    needReply = text;
    if (text.startsWith(askForAddress)) {
      data.addAll(List.generate(8, (index) => 00));
    } else if (text.startsWith(askForCheckAvailable)) {
      var splitData = text.trim().split(':');
      if (splitData.isNotEmpty && splitData.length == 2) {
        var ipData = splitData[1].split('.');
        if (ipData.isNotEmpty) {
          for (var e in ipData) {
            var num = int.parse(e);
            data.add(num);
          }
        }
        if (data.length == 4) {
          var cacheData = <int>[...data];
          for (var g in cacheData) {
            data.add(g);
          }
        }
      }
    } else if (text.startsWith(askForKeptAlive)) {
      //2:ip
      var splitData = text.trim().split(':');
      if (splitData.isNotEmpty && splitData.length == 2) {
        var ipData = splitData[1].split('.');
        if (ipData.isNotEmpty) {
          data.addAll(List.generate(8, (index) => 00));
          for (int i = 0; i < ipData.length; i++) {
            var e = ipData[i];
            var num = int.parse(e);
            data[i + 4] = num;
          }
        }
      }
    }
    if (rawDatagramSocket != null) {
      rawDatagramSocket?.send(data, InternetAddress(serverHost), serverPort);
      timer = Timer(const Duration(seconds: 5), () {
        if (needReply.isNotEmpty) {
          _udpStartCommand(needReply);
        }
      });
    }
  }
}
