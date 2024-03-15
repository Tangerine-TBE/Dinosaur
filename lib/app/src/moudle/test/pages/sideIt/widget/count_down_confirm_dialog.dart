import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CountDownConfirmDialog extends StatelessWidget {
  final Function onCancelCallBack;
  final Function onConfirmCallBack;
  const CountDownConfirmDialog({super.key,required this.onCancelCallBack,required this.onConfirmCallBack});

  @override
  Widget build(BuildContext context) {
    return  SimpleDialog(
      contentPadding: EdgeInsets.zero,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.only(top: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Text('请录制十秒内的操作'),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                        onPressed: () {
                          onCancelCallBack.call();
                          Get.back();
                        },
                        child: Text(
                          '取消',
                          style: TextStyle(
                              color: MyColors.textBlackColor,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                  Expanded(
                      child: TextButton(
                        onPressed: () {
                          onConfirmCallBack.call();
                          Get.back();
                        },
                        child: Text('确认',
                            style: TextStyle(
                                color: Colors.pink, fontWeight: FontWeight.w400)),
                      )),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
