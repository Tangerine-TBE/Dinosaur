import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pinput/pinput.dart';

class RegisterController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController authCodeController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final PageController pageController = PageController();
  final birthFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final authCodeFocusNode = FocusNode();
  final nickNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final emailErrorText = ''.obs;
  final authCodeErrorText = ''.obs;
  final nickNameErrorText =''.obs;
  final passwordErrorText = ''.obs;

  final currentIndex = 0.obs;
  final birDayTime = 0.obs;
  final selectedImagesObx = ''.obs;
  final sex = ''.obs;
  final visibility = true.obs;

  @override
  onInit() {
    super.onInit();
    birthController.setText(DateTime.now().toString().split(' ')[0]);
    emailController.addListener(
      () {
        if (emailController.text.isNotEmpty && emailErrorText.value.isNotEmpty) {
          emailErrorText.value = '';
        }
      },
    );
    authCodeController.addListener(() {
      if (authCodeController.text.isNotEmpty && authCodeErrorText.value.isNotEmpty) {
        authCodeErrorText.value = '';
      }
    });
    nickNameController.addListener(() {
      if(nickNameController.text.isNotEmpty && nickNameErrorText.value.isNotEmpty){
        nickNameErrorText.value = '';
      }
    });
    passwordController.addListener(() {
      if(passwordController.text.isNotEmpty && passwordErrorText.value.isNotEmpty){
        passwordErrorText.value = '';
      }
    });

    pageController.addListener(() {
      if(pageController.page != null){
        currentIndex.value = pageController.page!.toInt();
      }
    });
  }

  onIndex0PageNextStep() {
    if (emailController.text.isEmpty) {
      emailErrorText.value = '请输入邮箱地址!';
      return;
    }
    if (!emailController.text.isEmail) {
      emailErrorText.value = '请输入正确的邮箱地址';
      return;
    }
    //Todo  清除焦点并隐藏软键盘 发起注册请求成功后跳转
    emailFocusNode.unfocus();
    pageController.jumpToPage(1);

  }
  onIndex1PageNextStep() {
    if (authCodeController.text.isEmpty) {
      authCodeErrorText.value = '请输入邮箱验证码';
      return;
    }
    //Todo 校验验证码
    authCodeFocusNode.unfocus();
    pageController.jumpToPage(2);
  }
  onIndex2PageNextStep(){
    pageController.jumpToPage(3);
  }
  onIndex3PageNextStep(){
    if (nickNameController.text.isEmpty) {
      nickNameErrorText.value = '请输入昵称';
      return;
    }
    nickNameFocusNode.unfocus();
    pageController.jumpToPage(4);
  }
  onIndex4PageNextStep(){
    if(sex.value.isEmpty){
      showToast('请选择对应的性别');
      return;
    }
    pageController.jumpToPage(5);
  }
  onIndex5PageNextStep(){
    if(passwordController.text.isEmpty){
      passwordErrorText.value ='请输入您的密码';
      return;
    }
    if(passwordController.text.length < 6){
      passwordErrorText.value ='输入的密码必须大于等于6位数';
      return;
    }
    passwordFocusNode.unfocus();
    //Todo finish
  }
  showImagePickerBottomSheet(RxString value) async {
    await Get.bottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
      SafeArea(
        child: Container(
          height: value.value.isNotEmpty ? 200 : 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () async {
                    Get.back();
                    String? path = await AImagePicker.instance().pickCamera();
                    if ((path?.length ?? 0) > 0) {
                      CroppedFile? croppedFile = await ImageCropper().cropImage(
                        sourcePath: path!,
                        aspectRatioPresets: [CropAspectRatioPreset.square],
                        uiSettings: [
                          AndroidUiSettings(
                            toolbarTitle: '裁剪',
                            toolbarColor: MyColors.themeTextColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.square,
                            lockAspectRatio: true,
                          ),
                          IOSUiSettings(title: '裁剪')
                        ],
                      );
                      if (croppedFile != null) {
                        value.value = croppedFile.path;
                      }
                    }
                  },
                  child: const Text(
                    '相机',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.pink,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () async {
                    Get.back();
                    String? path = await AImagePicker.instance().pickGallery();
                    if ((path?.length ?? 0) > 0) {
                      CroppedFile? croppedFile = await ImageCropper().cropImage(
                        sourcePath: path!,
                        compressQuality: 100,
                        maxHeight: 700,
                        maxWidth: 700,
                        aspectRatio: CropAspectRatio(ratioX: 1,ratioY: 1),
                        uiSettings: [
                          AndroidUiSettings(
                            toolbarTitle: '裁剪',
                            toolbarColor: MyColors.themeTextColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.square,
                            lockAspectRatio: true,
                          ),
                          IOSUiSettings(title: '裁剪',
                            aspectRatioLockEnabled: true,
                            resetAspectRatioEnabled: false,
                          )
                        ],
                      );
                      if (croppedFile != null) {
                        value.value = croppedFile.path;
                      }
                    }
                  },
                  child: const Text(
                    '相册',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                if (value.value.isNotEmpty)
                  const Divider(
                    height: 1,
                    color: Colors.pink,
                  ),
                if (value.value.isNotEmpty)
                  MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      value.value = '';
                      Get.back();
                    },
                    child: const Text(
                      '删除',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                Divider(
                  height: 1,
                  color: MyColors.textGreyColor.withOpacity(0.3),
                  thickness: 5,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    '取消',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  onClose(){
    super.onClose();
    emailController.dispose();
    authCodeController.dispose();
    birthController.dispose();
    nickNameController.dispose();
    passwordController.dispose();
  }

  onIndex2PageShowBirDialog(BuildContext context) async {
    birthFocusNode.requestFocus();
    DateTime? dateTime = await showDatePicker(context: context , firstDate: DateTime(1900,1,1), lastDate: DateTime.now());
    birthFocusNode.unfocus();
    if(dateTime != null){
      birthController.setText(dateTime.toString().split(' ')[0]);
      birDayTime .value = calculateAge(dateTime);
    }
  }
  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
