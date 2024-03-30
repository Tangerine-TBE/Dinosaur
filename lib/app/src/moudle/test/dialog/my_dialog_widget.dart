import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogWidget extends StatelessWidget {
  const MyDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    this.leftButtonTitle = "取消",
    this.rightButtonTitle = "确认",
    this.leftButtonAction,
    this.rightButtonAction,
  }) : super(key: key);
  final String title;
  final String content;
  final String leftButtonTitle;
  final String rightButtonTitle;
  final VoidCallback? leftButtonAction;
  final VoidCallback? rightButtonAction;

  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      title: title,
      info: Text(
        content,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.blue,
        ),
      ),
      leftButton: FilledButton(
        onPressed: () {
          Get.back();
          leftButtonAction?.call();
        },
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.pinkAccent),
          foregroundColor: Colors.pink,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        child: Text(leftButtonTitle),
      ),
      rightButton: FilledButton(
        onPressed: () {
          Get.back();
          rightButtonAction?.call();
        },
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.pinkAccent),
          foregroundColor: Colors.pink,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        child: Text(rightButtonTitle),
      ),
    );
  }
}


class BaseDialogWidget extends StatelessWidget {
  const BaseDialogWidget({
    required this.title,
    this.titleStyle,
    this.info,
    this.leftButton,
    this.rightButton,
    Key? key,
  }) : super(key: key);
  final String title;
  final TextStyle? titleStyle;
  final Widget? info;
  final Widget? leftButton;
  final Widget? rightButton;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style:  TextStyle(
                      fontSize: 18.sp,
                      color: Colors.pink,
                    ) ??
                    titleStyle,
              ),
               SizedBox(height: 8.h),
              info ?? const SizedBox(),
               SizedBox(height: 8.h),
              Row(
                children: [
                  leftButton != null
                      ? Expanded(
                          child: leftButton ?? const SizedBox(),
                        )
                      : const SizedBox(),
                   SizedBox(width: 8.w),
                  rightButton != null
                      ? Expanded(
                          child: rightButton ?? const SizedBox(),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
