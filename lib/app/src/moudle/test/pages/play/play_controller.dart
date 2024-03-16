import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_ble_controller.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class PlayController extends BaseBleController {
   List<TopPicCenterBean> dataList =[];
  final dataListId = 1;

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 5));
    fetchTopCenterList();
    update([dataListId]);
  }
   Future loaMoreList() async {
     await Future.delayed(const Duration(seconds: 1)); //await API Response
     dataList.addAll(List.generate(20, (index) => TopPicCenterBean.mock()));
     update([dataListId]);
   }
  Future fetchTopCenterList()async{
    await Future.delayed(const Duration(seconds: 1)); //await API Response
    dataList = List.generate(20, (index) => TopPicCenterBean.mock());
    update([dataListId]);
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
  void onAdapterStateChanged(BluetoothAdapterState state) {
  }

  @override
  void onDeviceConnected(BluetoothDevice device) {
  }

  @override
  void onDeviceDisconnect() {
  }

  @override
  void onDeviceUnKnownError() {
  }

  @override
  void onScanResultChanged(List<ScanResult> result) {
  }
}
