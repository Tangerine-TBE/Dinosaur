import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/pass_world_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class PassWorldPage extends BaseEmptyPage<PassWorldController> {
  const PassWorldPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(top: 20),
      textStyle: TextStyle(
          fontSize: 20,
          color: MyColors.textBlackColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MyColors.textGreyColor,
          ),
        ),
      ),
    );
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight * 3,
            ),
            Text(
              '开启小萌宠',
              style: TextStyle(
                color: MyColors.themeTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '跨越山海，随时陪伴，专属于你的亲密朋友!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.themeTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Pinput(
                mainAxisAlignment: MainAxisAlignment.center,
                length: 4,
                onCompleted: (value) {
                  controller.onCompleted(value);
                },
                defaultPinTheme: defaultPinTheme,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Obx(
              () => ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: controller.countDown.value
                      ? MaterialStateProperty.all(MyColors.textGreyColor)
                      : MaterialStateProperty.all(MyColors.bgLinearShapeColor1),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: controller.countDown.value?null:(){
                  controller.onReCallAuth();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 160,
                  height: 50,
                  child: Text(
                    controller.countDownText.value,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
