import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginController extends BaseController {
  late TextEditingController phoneController;

  bool isChecked = false;
  final name = ''.obs;

  @override
  onInit() async {
    super.onInit();
    phoneController = TextEditingController();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    name.value = packageInfo.version;
  }

  onConfirmClicked() {
    var phone = phoneController.value.text;
    if (phone.length != 11) {
      showError('需输入正确的手机号');
      return;
    }
    if (!isChecked) {
      showError('请阅读并勾选用户协议与隐私政策');
      return;
    }
    navigateTo(RouteName.passWorld, args: phone);
  }
}
