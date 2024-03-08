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
          Get.back();
          List<String> hostAndPort = value.split('/');
          serverHost = hostAndPort.first;
          serverPort = int.parse(hostAndPort.last);
          SaveKey.sendPort.save(serverPort);
          SaveKey.sendHost.save(serverHost);
          targetIp = target;
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
        await Future.delayed(const Duration(seconds: 2));
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
          sendInput.value = true;
          _udpStartCommand('3:$dataString');
        } else if (needReply.startsWith(askForKeptAlive)) {
          var data = StringUtils.bytesToDecimalString(dg.data).split('.');
          if (data.isNotEmpty) {
            if (data.length == 8) {
              if (int.parse(data[4]) == 0 &&
                  int.parse(data[5]) == 0 &&
                  int.parse(data[6]) == 0 &&
                  int.parse(data[7]) == 0) {
                sendInput.value = false;
                _udpStartCommand('1');
              } else {
                _udpStartCommand('2:${needReply.split(':')[1]}');
              }
            }
          }
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
        } else if (needReply.startsWith(askFoContent)) {}
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
        data.addAll(StringUtils.stringToByteList(text));
        rawDatagramSocket?.send(data, InternetAddress(serverHost), serverPort);
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
      sendInput.value = false;
      await Future.delayed(const Duration(seconds: 2));
      rawDatagramSocket?.send(data, InternetAddress(serverHost), serverPort);
      timer = Timer(const Duration(seconds: 5), () {
        if (needReply.isNotEmpty) {
          _udpStartCommand(needReply);
        }
      });
      // textEditingController.clear();
      // charData.insert(
      //     0, MsgBean.create(msg: text, type: 0, size: charData.length));
      // update([chatListId]);
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   scrollController.jumpTo(scrollController.position.minScrollExtent);
      // });
    }
  }
}
