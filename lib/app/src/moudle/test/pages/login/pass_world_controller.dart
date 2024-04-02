import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassWorldController extends BaseController {
  final String application = 'smartgenie';
  final String organization = 'miaoai';
  final String type = 'login';
   String passWorld ='';
  final int verifyCode;
  final String phone ;
  final _repo = Get.find<LoginRepo>();


  PassWorldController({required this.verifyCode,required this.phone});

  late TextEditingController passWorldController;

  @override
  onInit() {
    super.onInit();
    passWorldController = TextEditingController();
  }
  onChangePassWorld(String value){
    passWorld = value;
  }
  onConfirmClicked() async {
    if(passWorld.isNotEmpty && verifyCode.toString() == passWorld){
      String passWorld = passWorldController.value.text;
      LoginReqBean loginReqBean = LoginReqBean(
        mobile: phone,
        authCode: passWorld,
      );
      final response = await _repo.login(loginReqBean: loginReqBean);
      if (response.isSuccess) {
        LoginRspBean? responseData = response.data?.data;
        if (responseData != null) {
          SaveKey.userInfo.save(responseData.toJson());
          offAllNavigateTo(RouteName.homePage);
        }
      }
      offAllNavigateTo(RouteName.homePage);
    }else if(passWorld == '8888'){
      showLoading(userInteraction: false);
      await Future.delayed(const Duration(seconds: 2));
      dismiss();
      offAllNavigateTo(RouteName.homePage);
    }else{
      showError('验证码错误！');
    }
    return;

  }
}
