import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
                      color: Colors.white,
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
