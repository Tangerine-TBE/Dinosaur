import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/pass_world_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';

class PassWorldPage extends BaseEmptyPage<PassWorldController> {
  const PassWorldPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.w,
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.only(top: 20.h),
      textStyle: TextStyle(
          fontSize: 20.sp,
          color: MyColors.textBlackColor,
          fontWeight: FontWeight.w600),
      decoration:  BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.textGreyColor,),),
      ),
    );
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight * 3,
            ),
            Text(
              '开启小萌宠',
              style: TextStyle(
                color: MyColors.themeTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '你的超时空亲密玩伴',
              style: TextStyle(
                color: MyColors.themeTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Pinput(
                mainAxisAlignment: MainAxisAlignment.center,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                onChanged: (value){
                  controller.onChangePassWorld(value);
                },
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            MaterialButton(
              onPressed: () {
                controller.onConfirmClicked();
              },
              padding: EdgeInsets.only(top:14.h,bottom: 14.h,left: 50.h,right: 50.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w),),
              color: MyColors.bgLinearShapeColor1,
              child: Text('确定',style: TextStyle(color:Colors.white),textAlign: TextAlign.center,),
            )

          ],
        ),
      ),
    );
  }
}
