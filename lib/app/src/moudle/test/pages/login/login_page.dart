import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/login_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/weight/login_privacy_check_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends BaseEmptyPage<LoginController> {
  const LoginPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight * 3,
          ),
          Obx(
            () => Text(
              '开启小萌宠v${controller.name.value}',
              style: TextStyle(
                  color: MyColors.themeTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '跨越山海，随时陪伴，专属于你的亲密朋友!',
            style: TextStyle(
                color: MyColors.themeTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 60,
          ),
          TextField(
            controller: controller.phoneController,
            enabled: true,
            autofocus: true,
            minLines: 1,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            cursorColor: MyColors.themeTextColor,
            decoration: InputDecoration(
              hintText: '请输入手机号码',
              contentPadding: const EdgeInsets.only(top: 10),
              constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
              prefixIcon: Container(
                width: 70,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '手机号码',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.themeTextColor,
                  ),
                ),
              ),
              hintStyle: TextStyle(
                color: MyColors.textGreyColor.withAlpha(120),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.themeTextColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.themeTextColor),
              ),
            ),
            style: const TextStyle(
              fontSize: 18,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => PrivacyCheckboxWidget(
              onChanged: (checked) {
                controller.isChecked.value = checked;
              },
              onTapPrivacy: () {
                controller.onTapPrivacy();
              },
              onTapAgreement: () {
                controller.onTapAgreement();
              },
              // onTapPrivacy: _showProtocolDialog,
              checked: controller.isChecked.value,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              controller.onConfirmClicked();
            },
            padding:
                const EdgeInsets.only(top: 14, bottom: 14, left: 50, right: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: MyColors.bgLinearShapeColor1,
            child: const Text(
              '确定',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
