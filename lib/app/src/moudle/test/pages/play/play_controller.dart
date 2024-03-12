import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';

class PlayController extends BaseController{
  late List<TopPicCenterBean> data;
  @override
  void onInit() {
    super.onInit();
    data = List.generate(20, (index) => TopPicCenterBean.mock());
  }
}