import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';

class PlayController extends BaseController {
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
    // Get.toNamed(RouteName.sidePage);
  }

  void onShakeItClicked() {
    // Get.toNamed(RouteName.shakePage);
  }

  void onModelClicked() {
    // Get.toNamed(RouteName.modelPage);
  }
}
