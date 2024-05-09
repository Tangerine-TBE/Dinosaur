import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:app_base/util/StringUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class ForgotPasswordController extends BaseController{
  Timer? periodTimer;
  final seconds = 60.obs;
  final emailErrorText =''.obs;
  final authCodeErrorText = ''.obs;
  final newPasswordErrorText =''.obs;
  final againPassWordErrorText = ''.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController authCodeController = TextEditingController();
  final TextEditingController newPasswordController =TextEditingController();
  final TextEditingController againPasswordController = TextEditingController();
  final emailTextInput = true.obs;
  @override
  onInit(){
    super.onInit();
    emailController.addListener(() {
      if(emailController.text.isNotEmpty && emailErrorText.value.isNotEmpty){
        emailErrorText.value = '';
      }
    });
    authCodeController.addListener(() {
      if(authCodeController.text.isNotEmpty && authCodeErrorText.value.isNotEmpty){
        authCodeErrorText.value ='';
      }
    });
    newPasswordController.addListener(() {
      if(newPasswordController.text.isNotEmpty && newPasswordErrorText.value.isNotEmpty){
        newPasswordErrorText.value ='';
      }
    });
    againPasswordController.addListener(() {
      if(againPasswordController.text.isNotEmpty && againPassWordErrorText.value.isNotEmpty){
        againPassWordErrorText.value ='';
      }
    });
  }
  releaseTimer(){
    if(emailController.text.isEmpty){
      emailErrorText.value = '请输入邮箱!';
      return;
    }
    if(!StringUtils.isEmail(emailController.text)){
      emailErrorText.value = '请输入正确的邮箱!';
      return;
    }
    periodTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(seconds.value == 1){
        timer.cancel();
        seconds.value = 60;
        if(!emailTextInput.value){
          emailTextInput.value = true;
        }
      }else{
        if(emailTextInput.value){
          emailTextInput.value = false;
        }
        seconds.value = seconds.value - 1;
      }
    });
  }

  onConfirmButton(){
    if(emailController.text.isEmpty){
      emailErrorText.value = '请输入邮箱!';
      return;
    }
    if(!emailController.text.isEmail){
      emailErrorText.value = '请入正确的邮箱!';
      return;
    }
    if(authCodeController.text.isEmpty){
      authCodeErrorText.value='请输入验证码!';
      return;
    }
    if(newPasswordController.text.isEmpty){
      newPasswordErrorText.value ='请输入新的密码!';
      return;
    }
    if(againPasswordController.text.isEmpty){
      againPassWordErrorText.value = '请再次输入新的密码!';
      return;
    }
    if(againPasswordController.text != newPasswordController.text){
      againPassWordErrorText.value = '两次密码输入不一致!';
      newPasswordErrorText.value ='两次密码输入不一致!';
      return;
    }
    //Todo
  }

}