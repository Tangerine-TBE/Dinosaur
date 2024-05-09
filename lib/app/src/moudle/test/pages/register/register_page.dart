import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/register/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterPage extends BaseEmptyPage<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '注册界面',
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.titleTextDefaultSize,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: kToolbarHeight * 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  alignment: Alignment.center,
                  height: 24,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.themeTextColor),
                  child: const Text('1'),
                ),
                Container(width: 10,height: 1,color: Colors.black,),
                Container(
                  width: 24,
                  alignment: Alignment.center,
                  height: 24,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.themeTextColor),
                  child: const Text('1'),

                ),
                Container(width: 10,height: 1,color: Colors.black,),
                Container(
                  width: 24,
                  alignment: Alignment.center,
                  height: 24,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.themeTextColor),
                  child: Text('1'),

                ),
                Container(width: 10,height: 1,color: Colors.black,),
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.themeTextColor),
                  child: Text('1'),

                ),
              ],
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildInputPage(),
                  Center(child: Text('2'),),
                  Center(child: Text('3'),),
                  Center(child: Text('4'),),
                ],
              ),
            )),
          ],
        ));
  }
  _buildInputPage(){
    return Column(children: [
      Obx(
            () => TextField(
          controller: controller.emailController,
          autofocus: true,
          minLines: 1,
          textInputAction: TextInputAction.done,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.emailAddress,
          cursorColor: MyColors.themeTextColor,
          decoration: InputDecoration(
            hintText: '请输入邮箱',
            errorText: controller.emailErrorText.value == ''
                ? null
                : controller.emailErrorText.value,
            contentPadding: const EdgeInsets.only(top: 10),
            hintStyle: TextStyle(
              color: MyColors.textGreyColor.withAlpha(120),
              fontSize: 14,
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.themeTextColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.themeTextColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyColors.themeTextColor),
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
      ),


    ],);
  }
}
