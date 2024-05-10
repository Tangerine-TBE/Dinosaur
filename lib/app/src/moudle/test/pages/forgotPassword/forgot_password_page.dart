import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordPage extends BaseEmptyPage<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '忘记密码',
          style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.titleTextDefaultSize,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Obx(
                () => TextField(
                  controller: controller.emailController,
                  enabled: controller.emailTextInput.value,
                  autofocus: true,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: MyColors.themeTextColor,
                  decoration: InputDecoration(
                    hintText: '请输入邮箱',
                    suffix: TextButton(
                      onPressed: () {
                        controller.releaseTimer();
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Obx(
                        () => Text(
                          controller.seconds.value == 60
                              ? '获取验证码'
                              : '${controller.seconds.value} s',
                          style: const TextStyle(
                            color: MyColors.sliderActiveTrackColor,
                          ),
                        ),
                      ),
                    ),
                    errorText: controller.emailErrorText.value == ''
                        ? null
                        : controller.emailErrorText.value,
                    contentPadding: const EdgeInsets.only(top: 10),
                    hintStyle: TextStyle(
                      color: MyColors.textGreyColor.withAlpha(120),
                      fontSize: 14,
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Obx(
                () => TextField(
                  enabled: true,
                  autofocus: true,
                  minLines: 1,
                  controller: controller.authCodeController,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: MyColors.themeTextColor,
                  decoration: InputDecoration(
                    errorText: controller.authCodeErrorText.value == ''
                        ? null
                        : controller.authCodeErrorText.value,
                    hintText: '请输入邮箱验证码',
                    contentPadding: const EdgeInsets.only(top: 10),

                    hintStyle: TextStyle(
                      color: MyColors.textGreyColor.withAlpha(120),
                      fontSize: 14,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Obx(
                () => TextField(
                  enabled: true,
                  autofocus: true,
                  controller: controller.newPasswordController,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: MyColors.themeTextColor,
                  decoration: InputDecoration(
                    hintText: '请输入新的密码',
                    errorText: controller.newPasswordErrorText.value == ''
                        ? null
                        : controller.newPasswordErrorText.value,
                    contentPadding: const EdgeInsets.only(top: 10),
                    hintStyle: TextStyle(
                      color: MyColors.textGreyColor.withAlpha(120),
                      fontSize: 14,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Obx(
                () => TextField(
                  controller: controller.againPasswordController,
                  enabled: true,
                  autofocus: true,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: MyColors.themeTextColor,
                  decoration: InputDecoration(
                    hintText: '请再次确认密码',
                    contentPadding: const EdgeInsets.only(top: 10),
                    errorText: controller.againPassWordErrorText.value == ''
                        ? null
                        : controller.againPassWordErrorText.value,
                    hintStyle: TextStyle(
                      color: MyColors.textGreyColor.withAlpha(120),
                      fontSize: 14,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.themeTextColor),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MyColors.sliderActiveTrackColor),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 60),
                  ),
                  overlayColor:
                      MaterialStateProperty.all(MyColors.iconSelectedColor),
                ),
                onPressed: controller.onConfirmButton,
                child: const Text(
                  '确认',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
