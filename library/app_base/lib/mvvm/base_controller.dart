import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:common/base/mvvm/vm/base_view_model.dart';
import 'package:common/common/widget/loading/g_loading.dart';

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
