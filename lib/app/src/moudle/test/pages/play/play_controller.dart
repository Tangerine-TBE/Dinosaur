import 'dart:async';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/network/response/center_response.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app_base/mvvm/model/share_device_bean.dart';
import 'package:get/get.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';

class PlaySelfContentManager {
  final Function update;

  PlaySelfContentManager({required this.update});

  List<TopicList> dataList = [];
  final _repo = Get.find<PlayRepo>();
  final dataListId = 1;
  bool refreshing = true;

  _Create() async {
    for (int i = 0; i < 10; i++) {
      await _createTopCenter(
          subtitle: '小标题$i',
          imgUrl: 'https://via.placeholder.com/150/0000F$i/808080?Text=Image$i',
          content: '这是内容$i',
          title: '大标题$i');
    }
  }

  Future loaMoreList() async {}

  _fetchTopCenterList() async {
    final response = await _repo.callTopCenter(
      topicCenterReq: TopicCenterReq(orderBy: 'createTime desc'),
    );
    if (response.isSuccess) {
      CenterResponse? centerResponse = response.data;
      if (centerResponse != null && !centerResponse.isEmpty()) {
        dataList = centerResponse.data!.topicList;
      }
    }
    refreshing = false;
    update([dataListId]);
  }

  _createTopCenter(
      {required String subtitle,
      required String imgUrl,
      required String content,
      required String title}) async {
    await _repo.createTopCenter(
        topiCenterCreateReq: TopiCenterCreateReq(
            subtitle: subtitle, icon: imgUrl, title: title, content: content));
  }
}

class RemoteControlContentManager {
  final Function update;
  var shareData = <ShareDeviceBean>[];
  bool refreshing = true;
  final shareWorldsId = 2;
  late StreamSubscription<ConnectivityResult> subscription;

  RemoteControlContentManager({required this.update}) {
    _init();
  }

  _init() {
    // 1.监听网络变化
    subscription =
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        logE('网络不可用');
      }else {
        logE('网络可用');
      }
    });
  }

  _close() {
    // subscription.cancel();
  }

  _fetchShareWorld() {
    shareData.add(ShareDeviceBean(assetName: ResName.pic33, text: '我准备好了~'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic42, text: '停一会儿~'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic43, text: '喜欢~'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic59, text: '有感觉了~'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic61, text: '太强啦~'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic66, text: '还没玩够~'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic79, text: '就要这个不要停~'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic84, text: '换一个试试~'));
    update([shareWorldsId]);
  }
}

class PlayController extends BaseBleController {
  late PlaySelfContentManager playSelfContentManager;
  late RemoteControlContentManager remoteControlContentManager;

  @override
  void onInit() async {
    super.onInit();
    playSelfContentManager = PlaySelfContentManager(update: update);
    remoteControlContentManager = RemoteControlContentManager(update: update);
    remoteControlContentManager._fetchShareWorld();
    playSelfContentManager._fetchTopCenterList();
  }

  @override
  void onClose() {
    remoteControlContentManager._close();
    super.onClose();
  }

  void onScanClicked() {
    navigateTo(RouteName.scanPage);
  }

  void onSideItClicked() {
    navigateTo(RouteName.sidePage);
  }

  void onShakeItClicked() {
    navigateTo(RouteName.shakePage);
  }

  void onModelClicked() {
    navigateTo(RouteName.modelPage);
  }

  onCenterDetailsIndexTap(TopicList bean) {
    navigateTo(RouteName.centerDetailsPage, args: bean);
  }

  @override
  void onAdapterStateChanged(BluetoothAdapterState state) {}

  @override
  void onDeviceConnected(BluetoothDevice device) {}

  @override
  void onDeviceDisconnect() {}

  @override
  void onDeviceUnKnownError() {}

  @override
  void onScanResultChanged(List<ScanResult> result) {}
}
