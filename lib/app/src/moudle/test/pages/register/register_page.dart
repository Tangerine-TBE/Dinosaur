import 'dart:io';
import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        actions: [
          Obx(
            () => Visibility(
              visible: controller.currentIndex.value != 0,
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                ),
                child: InkWell(
                  onTap: () {
                    controller.pageController
                        .jumpToPage(controller.currentIndex.value - 1);
                    controller.onLastStep();
                  },
                  child: Text(
                    '返回上一步',
                    style: TextStyle(
                      color: MyColors.themeTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) => _buildTitleBarItem(index)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildInputEmailPage(),
                  _buildInputAuthCodePage(),
                  _buildUserBirthPage(context),
                  _buildNickNamePage(),
                  _buildSelectPhotoPage(),
                  _buildInputPassword(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  _buildTitleBarItem(int index) {
    return Row(
      children: [
        Obx(
          () => controller.currentIndex.value == index
              ? Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.themeTextColor),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.themeTextColor,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
        ),
        if (index < 5)
          Container(
            width: 10,
            height: 1,
            color: Colors.black,
          ),
      ],
    );
  }

  _buildInputPassword(){
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Obx(() =>

            TextField(
              controller: controller.passwordController,
              autofocus: true,
              enabled: true,
              minLines: 1,
              focusNode: controller.passwordFocusNode,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.start,
              inputFormatters: [LengthLimitingTextInputFormatter(16),],
              obscureText: controller.visibility.value,
              keyboardType: TextInputType.emailAddress,
              cursorColor: MyColors.themeTextColor,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10, left: 14),
                hintStyle: TextStyle(
                  color: MyColors.textGreyColor.withAlpha(120),
                  fontSize: 16,
                ),
                errorText: controller.passwordErrorText.value == ''
                    ? null
                    : controller.passwordErrorText.value,
                labelText: '密码',
                labelStyle: const TextStyle(
                  color: Colors.indigoAccent,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    controller.visibility.value =
                    !controller.visibility.value;
                  },
                  child: controller.visibility.value ? const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: MyColors.themeTextColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: MyColors.textGreyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: MyColors.themeTextColor),
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),

        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            controller.onIndex5PageNextStep();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              MyColors.themeTextColor,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 50,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              MyColors.iconSelectedColor,
            ),
          ),
          child: const Text(
            '完成',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );

  }
  _buildSelectPhotoPage() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            controller.showImagePickerBottomSheet(controller.selectedImagesObx);
          },
          child: Obx(
                () => ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 100,
                height: 100,
                color: MyColors.textGreyColor,
                child: controller.selectedImagesObx.value.isEmpty
                    ? const Icon(
                  Icons.add,
                  color: Colors.white,
                )
                    : Image.file(
                  fit: BoxFit.cover,
                  File(controller.selectedImagesObx.value),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('性别:'),
            const SizedBox(width: 20,),
            const Text('男'),
            Obx(
                  () => Radio(
                value: '男',
                groupValue: controller.sex.value,
                activeColor: MyColors.themeTextColor,
                onChanged: (value) {
                  if (value != null) {
                    controller.sex.value = value;
                  }
                },
              ),
            ),
            const Text('女'),
            Obx(
                  () => Radio(
                value: '女',
                groupValue: controller.sex.value,
                activeColor: MyColors.themeTextColor,
                onChanged: (value) {
                  if (value != null) {
                    controller.sex.value = value;
                  }
                },
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            controller.onIndex4PageNextStep();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              MyColors.themeTextColor,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 50,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              MyColors.iconSelectedColor,
            ),
          ),
          child: const Text(
            '下一步',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _buildNickNamePage() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: controller.nickNameController,
          autofocus: true,
          enabled: true,
          minLines: 1,
          focusNode: controller.nickNameFocusNode,
          textInputAction: TextInputAction.done,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.emailAddress,
          cursorColor: MyColors.themeTextColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 10, left: 14),
            hintStyle: TextStyle(
              color: MyColors.textGreyColor.withAlpha(120),
              fontSize: 16,
            ),
            errorText: controller.nickNameErrorText.value == ''
                ? null
                : controller.nickNameErrorText.value,
            labelText: '昵称',
            labelStyle: const TextStyle(
              color: Colors.indigoAccent,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.themeTextColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: MyColors.textGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: MyColors.themeTextColor),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            controller.onIndex3PageNextStep();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              MyColors.themeTextColor,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 50,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              MyColors.iconSelectedColor,
            ),
          ),
          child: const Text(
            '下一步',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _buildUserBirthPage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            controller.onIndex2PageShowBirDialog(context);
          },
          child: IgnorePointer(
            ignoring: true,
            child: Obx(
              () => TextField(
                controller: controller.birthController,
                autofocus: false,
                enabled: true,
                readOnly: true,
                minLines: 1,
                focusNode: controller.birthFocusNode,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.emailAddress,
                cursorColor: MyColors.themeTextColor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 10, left: 14),
                  hintStyle: TextStyle(
                    color: MyColors.textGreyColor.withAlpha(120),
                    fontSize: 16,
                  ),
                  labelText: '出生日期（${controller.birDayTime.value}岁）',
                  labelStyle: const TextStyle(
                    color: Colors.indigoAccent,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColors.themeTextColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: MyColors.textGreyColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: MyColors.themeTextColor),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            controller.onIndex2PageNextStep();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              MyColors.themeTextColor,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 50,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              MyColors.iconSelectedColor,
            ),
          ),
          child: const Text(
            '下一步',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _buildInputAuthCodePage() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => TextField(
            controller: controller.authCodeController,
            autofocus: true,
            minLines: 1,
            focusNode: controller.authCodeFocusNode,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.emailAddress,
            cursorColor: MyColors.themeTextColor,
            decoration: InputDecoration(
              hintText: '请输入邮箱验证码',
              errorText: controller.authCodeErrorText.value == ''
                  ? null
                  : controller.authCodeErrorText.value,
              contentPadding: const EdgeInsets.only(top: 10),
              hintStyle: TextStyle(
                color: MyColors.textGreyColor.withAlpha(120),
                fontSize: 16,
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
              fontSize: 16,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            controller.onIndex1PageNextStep();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              MyColors.themeTextColor,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 50,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              MyColors.iconSelectedColor,
            ),
          ),
          child: const Text(
            '下一步',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _buildInputEmailPage() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => TextField(
            controller: controller.emailController,
            autofocus: true,
            minLines: 1,
            focusNode: controller.emailFocusNode,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
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
                fontSize: 16,
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
              fontSize: 16,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            controller.onIndex0PageNextStep();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              MyColors.themeTextColor,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 50,
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              MyColors.iconSelectedColor,
            ),
          ),
          child: const Text(
            '下一步',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
