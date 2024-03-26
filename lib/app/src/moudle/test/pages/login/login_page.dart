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
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight * 3,
          ),
          Obx(
            () => Text(
              '开启小萌宠v${controller.name.value}',
              style: TextStyle(
                  color: MyColors.themeTextColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '跨越山海，随时陪伴，专属于你的亲密朋友!',
            style: TextStyle(
                color: MyColors.themeTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 60.h,
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
              contentPadding: EdgeInsets.only(top: 10.h),
              constraints: BoxConstraints(maxHeight: 50.h, minHeight: 50.h),
              prefixIcon: Container(
                width: 70.w,
                height: 50.h,
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
            style: TextStyle(
              fontSize: 18.sp,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          PrivacyCheckboxWidget(
            onChanged: (checked) {
              controller.isChecked = checked;
            },
            onTapPrivacy: (){},
            // onTapPrivacy: _showProtocolDialog,
            controller: controller,
          ),
          SizedBox(
            height: 20.h,
          ),
          MaterialButton(
            onPressed: () {
              controller.onConfirmClicked();
            },
            padding: EdgeInsets.only(
                top: 14.h, bottom: 14.h, left: 50.h, right: 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.w),
            ),
            color: MyColors.bgLinearShapeColor1,
            child: Text(
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
