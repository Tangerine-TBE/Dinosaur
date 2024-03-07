import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:test01/app/src/pages/test1/testBean/MsgBean.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/pages/test1/widget/host_edit_dialog.dart';
import 'package:flutter/services.dart';

class Test1Controller extends BaseController {
  final chatListId = 1;
  final String host = '127.0.0.1';
  final int listen = 8081;
  String sendHost = '';
  int sendPort = 0;
  final Rx<bool> sendInput = false.obs;

  RawDatagramSocket? rawDatagramSocket;
  late TextEditingController textEditingController;
  late ScrollController scrollController;

  final List<MsgBean> charData = <MsgBean>[];

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    scrollController = ScrollController();
  }

  void startUdp() async {
    var interfaces = await NetworkInterface.list();
    var addresses = interfaces[0].addresses;
    rawDatagramSocket = await RawDatagramSocket.bind(addresses[0].address, listen);
    rawDatagramSocket?.broadcastEnabled = true;
    rawDatagramSocket?.listen((event) {
      Datagram? dg = rawDatagramSocket?.receive();
      if (dg != null) {
        charData.insert(0, MsgBean.create(msg: String.fromCharCodes(dg.data), type: 1));
        update([chatListId]);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.minScrollExtent);
        });
      }
    });
    if (rawDatagramSocket != null) {
      sendInput.value = true;
    }
  }

  Future< List<InternetAddress> > _getIPAddress() async {
  var list = await InternetAddress.lookup('localhost',
        type: InternetAddressType.IPv4);
    return list;
  }

  void setting() {
    Get.dialog(
      HostEditDialog(
        onConfirm: (value) {
          Get.back();
          List<String> hostAndPort = value.split('/');
          sendHost = hostAndPort.first;
          sendPort = int.parse(hostAndPort.last);
          startUdp();
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }

  void udpWrite(String text) {
    if (rawDatagramSocket != null) {
      List<int> data = utf8.encode(text);
      rawDatagramSocket?.send(data,
          InternetAddress(sendHost), sendPort);
      textEditingController.clear();
      charData.insert(0, MsgBean.create(msg: text, type: 0));
      update([chatListId]);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      });
    }
  }
}
