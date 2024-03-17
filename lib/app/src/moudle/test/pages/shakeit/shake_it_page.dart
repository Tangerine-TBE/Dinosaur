import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/shakeit/shake_it_controller.dart';
import 'package:test01/app/src/moudle/test/pages/shakeit/weight/fill_icon_clipper.dart';

class ShakeItPage extends BaseEmptyPage<ShakeItController> {
  const ShakeItPage({super.key});

  @override
  // TODO: implement background
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          '摇一摇',
          style: TextStyle(
            fontSize: 16.sp,
            color: MyColors.textBlackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: MyColors.shakeCardBgColor,
                borderRadius: BorderRadius.circular(11.w)),
            margin: EdgeInsets.only(right: 26.w, left: 26.w, top: 26.w),
            height: 144.h,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '试着用手晃动手机,体验不同的震感快乐',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: LayoutBuilder(
                      builder: (context, c) {
                        return Stack(
                          children: [
                            Row(
                              children: List.generate(
                                  8,
                                  (index) => Image.asset(
                                        ResName.iconFill1,
                                        width: 35.w,
                                        height: 27.h,
                                      )),
                            ),
                            Obx(
                              () => TweenAnimationBuilder<double>(
                                tween: Tween(end: controller.threshold.value),
                                duration: const Duration(milliseconds: 500),
                                builder: (BuildContext context, double value,
                                    Widget? child) {
                                  //
                                  controller.onShakeIt(value);
                                  return ClipRect(
                                    clipper:
                                        FillIconClipper(offsetValue: value,vector:controller.vector),
                                    child: Row(
                                      children: List.generate(
                                        8,
                                        (index) => Image.asset(
                                          ResName.iconFill,
                                          width: 35.w,
                                          height: 27.h,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 43.h,
          ),
          Image.asset(
            ResName.imgYao,
            width: 253.w,
            height: 253.w,
          )
        ],
      ),
    );
  }
}
