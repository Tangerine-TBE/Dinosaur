import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginController extends BaseController{
    late TextEditingController phoneController ;
    final name = ''.obs;
    @override
    onInit() async {
      super.onInit();
      phoneController = TextEditingController();
       PackageInfo packageInfo = await PackageInfo.fromPlatform();
       name.value  = packageInfo.version;
    }

    onConfirmClicked(){
      var phone = phoneController.value.text;
      if(phone.length != 11){
        showError('需输入正确的手机号');
        return;
      }else{
        //切换至密码或验证码
        navigateTo(RouteName.passWorld,args: phone);
      }
    }
}