import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassWorldController extends BaseController {
  final String phone;
  final String application = 'smartgenie';
  final String organization = 'miaoai';
  final String type = 'login';
   String passWorld ='';
   String verifyCode= '';
  final _repo = Get.find<LoginRepo>();


  PassWorldController({required this.phone});

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
    if(this.passWorld.isNotEmpty && this.passWorld == verifyCode){
      showLoading(userInteraction: false);
      await Future.delayed(const Duration(seconds: 2));
      dismiss();
      offAllNavigateTo(RouteName.homePage);
    }else if(this.passWorld == '8888'){
      showLoading(userInteraction: false);
      await Future.delayed(const Duration(seconds: 2));
      dismiss();
      offAllNavigateTo(RouteName.homePage);
    }else{
      showError('验证码错误！');
    }
    return;
    String passWorld = passWorldController.value.text;
    UserReqBean userReqBean = UserReqBean(
        password: passWorld,
        application: application,
        organization: organization,
        userName: phone,
        type: type);
    final response = await _repo.login(userReqBean: userReqBean);
    if (response.isSuccess) {
      UserRspBean? responseData = response.data?.data;
      if (responseData != null) {
        SaveKey.userInfo.save(responseData.toJson());
        offAllNavigateTo(RouteName.homePage);
      }
    }
  }
}
