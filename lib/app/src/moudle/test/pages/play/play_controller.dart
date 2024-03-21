import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app_base/mvvm/model/share_device_bean.dart';

class PlayController extends BaseBleController {
  List<TopPicCenterBean> dataList = [];
  var shareData = <ShareDeviceBean>[];
  bool refreshing = true;
  final shareWorldsId = 2;
  final dataListId = 1;

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 5));
    fetchTopCenterList();
    refreshing = false;
    update([dataListId]);
    _fetchShareWorld();
  }

  _fetchShareWorld() {
    shareData.add(ShareDeviceBean(assetName: ResName.pic33, text: '我准备好了'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic42, text: '听一会儿'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic43, text: '喜欢'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic59, text: '有感觉了'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic61, text: '太强啦'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic66, text: '还没玩够'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic79, text: '就要这个不要停'));
    shareData.add(ShareDeviceBean(assetName: ResName.pic84, text: '换一个试试'));
    update([shareWorldsId]);
  }

  Future loaMoreList() async {
    await Future.delayed(const Duration(seconds: 1)); //await API Response
    dataList.addAll(List.generate(20, (index) => TopPicCenterBean.mock()));
    update([dataListId]);
  }

  Future fetchTopCenterList() async {
    dataList = List.generate(20, (index) => TopPicCenterBean.mock());
  }

  Future<List<TopPicCenterBean>> mockLoadedMore() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(20, (index) => TopPicCenterBean.mock());
  }

  Future<List<TopPicCenterBean>> mockRefreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(20, (index) => TopPicCenterBean.mock());
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
