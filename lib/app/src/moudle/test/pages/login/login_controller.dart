import 'package:app_base/config/route_name.dart';
import 'package:app_base/config/translations/msg_cn.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_controller.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../dialog/my_dialog_widget.dart';

class LoginController extends BaseController {
  late TextEditingController phoneController;
  final _repo = Get.find<LoginRepo>();
  bool isChecked = false;
  final name = ''.obs;

  @override
  onInit() async {
    super.onInit();
    phoneController = TextEditingController();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    name.value = packageInfo.version;
  }

  onConfirmClicked() async  {
    var phone = phoneController.value.text;
    if (phone.length != 11) {
      showError('需输入正确的手机号');
      return;
    }
    if (!isChecked) {
      showError('请阅读并勾选用户协议与隐私政策');
      return;
    }
    final AuthCReqBean authCReqBean = AuthCReqBean(mobile: phone);
    final response = await _repo.authCode(authCReqBean: authCReqBean);
    if(response.isSuccess){
      if(response.data?.data == null){
        showError('验证信息请求失败!');
      }else{
        final AuthCRspBean authCRspBean = response.data!.data!;
        Map<String ,dynamic > args= {'phone':phone,'expiresIn':authCRspBean.expiresIn};
        navigateTo(RouteName.passWorld, args: args);
      }
    }
  }
  onTapPrivacy(){
    _showPrivacyDialog();
  }
  onTapAgreement(){
    _showProtocolDialog();
  }
  void _showProtocolDialog() {
    Get.dialog(MyDialogWidget(
      title: '用户协议',
      content: MsgCopy.privacyContent,
      leftButtonTitle: '确定',
      rightButtonTitle: '取消',
      leftButtonAction: () {

      },
      rightButtonAction: () {

      },
    ));
  }

  void _showPrivacyDialog(){
    Get.dialog(MyDialogWidget(
      title: '隐私政策',
      content: MsgCopy.agreeContent,
      leftButtonTitle: '确定',
      rightButtonTitle: '取消',
      leftButtonAction: () {

      },
      rightButtonAction: () {

      },
    ));

  }
}
