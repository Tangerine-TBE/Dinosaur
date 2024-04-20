import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:flutter/cupertino.dart';
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
  final Function onButtonClick;
  const TipsDialogWidget({super.key,required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        SizedBox(
          height: 475,
          width: 277,
          child: Stack(
            children: [
              Positioned(
                left: 13,
                right: 13,
                top: 40,
                child: Stack(
                  children: [
                    Image.asset(
                      ResName.pet2,
                      width: 251,
                      height: 77,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      top: 9,
                      left: 16,
                      child: Image.asset(
                        ResName.pet1,
                        width: 88,
                        height: 20,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 77,
                child: Stack(
                  children: [
                    Image.asset(
                      ResName.pet3,
                      width: 277,
                      height: 398,
                    ),
                    Positioned(
                      top: 22,
                      left: 22,
                      child: Container(
                        width: 109,
                        height: 26,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 3),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffE96573),
                              Color(0xffEC8A6D),
                            ],
                          ),
                        ),
                        child: const Text(
                          '有爱且文明',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 52,
                      left: 22,
                      right: 22,
                      child: Image.asset(
                        ResName.pet5,
                        width: 237,
                        height: 41,
                      ),
                    ),
                    Positioned(
                      left: 65,
                      right: 65,
                      top: 100,
                      child: Image.asset(
                        ResName.pet4,
                        width: 147,
                        height: 140,
                      ),
                    ),
                    const Positioned(
                      left: 39,
                      right: 39,
                      top: 250,
                      child: Text(
                        style: TextStyle(
                            fontSize: 10,
                            color: MyColors.textGreyColor,
                            fontWeight: FontWeight.w400),
                        maxLines: null,
                        '对于发布反动/色情/暴力/骚扰等违规内容的用户， 社群管理员有权进行删帖、禁言、封号等处理， 违规情节严重者，将可能被举报至有关部门',
                      ),
                    ),
                    Positioned(
                      left: 41,
                      right: 41,
                      bottom:20 ,
                      child: MaterialButton(
                        onPressed: (){
                          Get.back();
                          onButtonClick.call();
                        },
                        height: 42,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21,),),
                        color: const Color(0xffFF5E65),
                        child: const Text('遵守约定',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 7,
                left: 161,
                top: 24,
                child: Image.asset(
                  ResName.iconImg,
                  width: 109,
                  height: 135,
                ),
              )
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
