import 'package:app_base/exports.dart';
import 'package:common/base/mvvm/vm/base_view_model.dart';
import 'package:common/common/widget/loading/g_loading.dart';
import 'package:get/get.dart';
import 'package:common/base/helper/navigation_helper.dart';

class BaseController extends BaseViewModel {
  @override
  void handleUnAuthorizedError(String? message) {
    showToast('請重新登陸');
  }

  @override
  void showEmpty() {}

  ///通用的obx轉換
  void setObsValue(Map<String, dynamic> value) {}

  dynamic getObsValue(String key) {
    return "";
  }

  @override
  void showError(String? message) {
    EasyLoadingImpl().showError(message);
  }

  @override
  void onHidden() {}
}
extension Navi on NavigationHelper{
  void offAllNavigateTo(String rout, {dynamic args}) {
    Get.offAllNamed(rout, arguments: args);
  }
}
