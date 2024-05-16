import 'dart:async';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/network/response/center_response.dart';
import 'package:app_base/widget/listview/smart_load_more_listview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app_base/mvvm/model/share_device_bean.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';

class PlaySelfContentManager {
  final Function update;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  PlaySelfContentManager({required this.update});

  List<TopicList> dataList = [];
  final _repo = Get.find<PlayRepo>();
  final dataListId = 1;
  bool refreshing = true;
  double offset = 0;
  bool isInit = false;
  final pageBucket = PageStorageBucket();
  setRefreshController(RefreshController refreshController){
    this.refreshController = refreshController;
  }
  init() async {
    if(!isInit){
     isInit = true;
      refreshController.requestRefresh();
    }
  }

  Future loaMoreList() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  fetchTopCenterList() async {
    final response = await _repo.callTopCenter(
      topicCenterReq: TopicCenterReq(orderBy: 'createTime desc'),
    );
    if (response.isSuccess) {
      CenterResponse? centerResponse = response.data;
      if (centerResponse != null && !centerResponse.isEmpty()) {
        dataList = centerResponse.data!.topicList;
        update([dataListId]);
        refreshController.refreshCompleted();
      }else{
        refreshController.refreshToIdle();
      }
    }else{
      refreshController.refreshFailed();
    }
  }

}

class RemoteControlContentManager {
  final Function update;
  var shareData = <ShareDeviceBean>[];
  bool refreshing = true;
  final shareWorldsId = 2;
  late StreamSubscription<List<ConnectivityResult>> subscription;

  RemoteControlContentManager({required this.update}) {
    _init();
  }

  _init() {
    // 1.监听网络变化
        subscription = Connectivity().onConnectivityChanged.listen((event) {
      if (event[0] == ConnectivityResult.none) {
        logE('网络不可用');
      } else {
        logE('网络可用');
      }
    });
  }

  _close() {
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
class PlayController extends BaseController {
  late PlaySelfContentManager playSelfContentManager;
  late RemoteControlContentManager remoteControlContentManager;
  int index = 0;
  @override
  void onInit() async {
    playSelfContentManager = PlaySelfContentManager(update: update);
    remoteControlContentManager = RemoteControlContentManager(update: update);
    super.onInit();
  }
  @override
  void onReady() {
    remoteControlContentManager._fetchShareWorld();
    playSelfContentManager.init();
    super.onReady();
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
}
