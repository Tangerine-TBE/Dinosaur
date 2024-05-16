import 'package:app_base/config/route_name.dart';
import 'package:app_base/config/size.dart';
import 'package:app_base/config/translations/msg_cn.dart';
import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_controller.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:app_base/util/md5_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
class LoginController extends BaseController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final visibility = false.obs;
  final _repo = Get.find<LoginRepo>();
  final isChecked = false.obs;
  final name = ''.obs;
  final switchType = 1.obs;

  @override
  onInit()  {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();


  }
  @override
  onReady() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    name.value = packageInfo.version;
  }
  switchLoginType() {
    switchType.value = 2;
  }

  onConfirmClicked() async {
    if (!isChecked.value) {
      showError('请阅读并勾选用户协议与隐私政策');
      return;
    }
    if (switchType.value == 1) {
      var phone = emailController.value.text;
      if (!phone.isEmail) {
        showError('需输入正确邮箱');
        return;
      }
      emailFocus.unfocus();
      final AuthCReqEmailBean authCReqBean =
          AuthCReqEmailBean(mail: phone, type: 'login');
      final response =
          await _repo.authCodeEmail(authCReqEmailBean: authCReqBean);
      if (response.isSuccess) {
        if (response.data?.data == null) {
          showError('验证信息请求失败!');
        } else {
          final AuthCRspEmailBean authCRspBean = response.data!.data!;
          Map<String, dynamic> args = {
            'phone': phone,
            'expiresIn': authCRspBean.expiresIn
          };
          navigateTo(RouteName.passWorld, args: args);
        }
      } else {
        showError(response.message);
      }
    } else {
      var account = emailController.value.text;
      var passWord = passwordController.value.text;
      if (account.isEmpty) {
        showError('请输入账号!');
        return;
      }
      if (passWord.isEmpty) {
        showError('请输入密码!');
        return;
      }
      passwordFocus.unfocus();
      emailFocus.unfocus();
      final LoginReqBean loginReqBean = LoginReqBean(
        application: 'cutepet',
        organization: 'miaoai',
        userName: account,
        password: Md5Utils.generateMD5(passWord),
        type: 'password',
      );
      final response =
          await _repo.loginWithPassword(loginReqBean: loginReqBean);
      if (response.isSuccess) {
        if (response.data?.data == null) {
          showError('请求失败!');
        } else {
          final LoginWithCodeRspBean loginWithCodeRspBean = response.data!.data!;
          SaveKey.loginUserBaseInfo.save(loginWithCodeRspBean.toJson());
          User.loginRspBean = loginWithCodeRspBean;
          offAllNavigateTo(RouteName.homePage);
        }
      } else {
        showError(response.message);
      }
    }
  }

  onTapPrivacy() {
    _showPrivacyDialog();
  }

  onTapAgreement() {
    _showProtocolDialog();
  }

  void _showProtocolDialog() async {
    var selectedConfirm = false;
    await Get.bottomSheet(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    '《小萌宠用户协议》',
                    style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(MsgCopy.privacyContent)),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          finish();
                        },
                        height: 40,
                        color: Colors.red,
                        child: const Text('取消'),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          selectedConfirm = true;
                          finish();
                        },
                        height: 40,
                        color: Colors.green,
                        child: Text('确定'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    if (selectedConfirm && SaveKey.readPrivacy.read != null) {
      if (SaveKey.readPrivacy.read) {
        isChecked.value = true;
      }
    }
    SaveKey.readUserProtected.save(selectedConfirm);
  }

  void _showPrivacyDialog() async {
    var selectedConfirm = false;
    await Get.bottomSheet(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    '《小萌宠隐私保护政策》',
                    style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(MsgCopy.agreeContent)),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          finish();
                        },
                        height: 40,
                        color: Colors.red,
                        child: const Text('取消'),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          selectedConfirm = true;
                          finish();
                        },
                        height: 40,
                        color: Colors.green,
                        child: Text('确定'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    if (selectedConfirm && SaveKey.readUserProtected.read != null) {
      if (SaveKey.readUserProtected.read) {
        //打勾
        isChecked.value = true;
      }
    }
    SaveKey.readPrivacy.save(selectedConfirm);
  }
}
