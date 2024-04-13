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

class TipsDialogWidget extends StatelessWidget {
  const TipsDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        Container(
          height: 475,
          width: 277,
          child: Stack(
            children: [
              Positioned(
                left: 13,
                right: 13,
                top: 40,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFFFFFE),
                        Color(0xffFF5E65),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  width: 251,
                  height: 77,
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color(0xffFAE5EA),
                      Color(0xffFFFFFE),
                    ],
                  )),
                ),
              ),
            ],
          ),
        )
      ],
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
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                      fontSize: 18,
                      color: Colors.pink,
                    ) ??
                    titleStyle,
              ),
              SizedBox(height: 8),
              info ?? const SizedBox(),
              SizedBox(height: 8),
              Row(
                children: [
                  leftButton != null
                      ? Expanded(
                          child: leftButton ?? const SizedBox(),
                        )
                      : const SizedBox(),
                  SizedBox(width: 8),
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
