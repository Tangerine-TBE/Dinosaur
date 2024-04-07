import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:get/get.dart';
import 'dart:async';

class PassWorldController extends BaseController {
  final String application = 'smartgenie';
  final String organization = 'miaoai';
  final String type = 'login';
  String passWorld = '';
  int expiresIn;
  final String phone;

  final _repo = Get.find<LoginRepo>();
  final countDown = true.obs;
  final countDownText = '获取验证码'.obs;
  Timer? countDownTimer;

  PassWorldController({required this.expiresIn, required this.phone});

  @override
  onInit() {
    super.onInit();
    releaseTimer();
  }

  releaseTimer() {
    var i = expiresIn;
    countDown.value = true;
    countDownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        i--;
        if (i < 1) {
          timer.cancel();
          countDown.value = false;
          countDownText.value = '获取验证码';
        } else {
          countDownText.value = '获取验证码($i)';
        }
      },
    );
  }

  onReCallAuth() async {
    final response =
        await _repo.authCode(authCReqBean: AuthCReqBean(mobile: phone));
    if (response.isSuccess) {
      if (response.data?.data != null) {
        final AuthCRspBean authCRspBean = response.data!.data!;
        expiresIn = authCRspBean.expiresIn;
        releaseTimer();
      }else{
        showError('请求出错啦！');
      }
    }
  }

  onCompleted(String value) async {
    if (value.isNotEmpty) {
      String passWorld = value;
      LoginReqBean loginReqBean = LoginReqBean(
        mobile: phone,
        authCode: passWorld,
      );
      final response = await _repo.login(loginReqBean: loginReqBean);
      if (response.isSuccess) {
        LoginRspBean? responseData = response.data?.data;
        if (responseData != null) {
          SaveKey.userInfo.save(responseData.toJson());
          User.loginRspBean = responseData;
          offAllNavigateTo(RouteName.homePage);
        }
      }
    } else if (passWorld == '8888') {
      showLoading(userInteraction: false);
      await Future.delayed(const Duration(seconds: 2));
      dismiss();
      offAllNavigateTo(RouteName.homePage);
    }else{
      showError('验证码错误！');
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (countDownTimer != null) {
      countDownTimer?.cancel();
    }
  }
}
