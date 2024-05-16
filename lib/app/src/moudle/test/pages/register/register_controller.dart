import 'dart:async';
import 'dart:io';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/oss_auth_bean.dart';
import 'package:app_base/mvvm/model/register_bean.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:app_base/mvvm/repository/upload_repo.dart';
import 'package:app_base/util/md5_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:app_base/util/image.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends BaseController {
  final _repo = Get.find<LoginRepo>();
  final _uploadRepo = Get.find<UpLoadRepo>();
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
  final nickNameErrorText = ''.obs;
  final passwordErrorText = ''.obs;
  final countDownText = '获取验证码'.obs;
  final countDown = true.obs;
  var expiresIn = 0;
  final currentIndex = 0.obs;
  final birDayTime = 0.obs;
  final selectedImagesObx = ''.obs;
  final sex = ''.obs;
  final visibility = true.obs;
  Timer? countDownTimer ;
  onLastStep() {
    if (birthFocusNode.hasFocus) {
      birthFocusNode.unfocus();
    }
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
    if (authCodeFocusNode.hasFocus) {
      authCodeFocusNode.unfocus();
    }
    if (nickNameFocusNode.hasFocus) {
      nickNameFocusNode.unfocus();
    }
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    }
  }

  @override
  onInit() {
    super.onInit();
    birthController.setText(DateTime.now().toString().split(' ')[0]);
    emailController.addListener(
      () {
        if (emailController.text.isNotEmpty &&
            emailErrorText.value.isNotEmpty) {
          emailErrorText.value = '';
        }
      },
    );
    authCodeController.addListener(() {
      if (authCodeController.text.isNotEmpty &&
          authCodeErrorText.value.isNotEmpty) {
        authCodeErrorText.value = '';
      }
    });
    nickNameController.addListener(() {
      if (nickNameController.text.isNotEmpty &&
          nickNameErrorText.value.isNotEmpty) {
        nickNameErrorText.value = '';
      }
    });
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty &&
          passwordErrorText.value.isNotEmpty) {
        passwordErrorText.value = '';
      }
    });

    pageController.addListener(() {
      if (pageController.page != null) {
        currentIndex.value = pageController.page!.toInt();
      }
    });
  }

  onIndex2PageNextStep() {
    pageController.jumpToPage(1);
  }

  onIndex3PageNextStep() {
    if (nickNameController.text.isEmpty) {
      nickNameErrorText.value = '请输入昵称';
      return;
    }
    nickNameFocusNode.unfocus();
    pageController.jumpToPage(2);
  }

  onIndex4PageNextStep() {
    if (sex.value.isEmpty) {
      showToast('请选择对应的性别');
      return;
    }
    pageController.jumpToPage(3);
  }
  releaseTimer() {
    var i = expiresIn;
    countDown.value = true;
    countDownTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        i--;
        if (i < 1) {
          timer.cancel();
          countDown.value = false;
          countDownText.value = '获取验证码';
        } else {
          countDownText.value = '获取验证码($i)';
        }
      },
    );
  }
  onIndex5PageNextStep() {
    if (passwordController.text.isEmpty) {
      passwordErrorText.value = '请输入您的密码';
      return;
    }
    if (passwordController.text.length < 6) {
      passwordErrorText.value = '输入的密码必须大于等于6位数';
      return;
    }
    passwordFocusNode.unfocus();

    pageController.jumpToPage(4);
  }

  onIndex0PageNextStep() async {
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
    AuthCReqEmailBean authCReqEmailBean =
        AuthCReqEmailBean(mail: emailController.text, type: 'register');
    final response =
        await _repo.authCodeEmail(authCReqEmailBean: authCReqEmailBean);
    if (response.isSuccess) {
      if (response.data?.data == null) {
        showError('验证信息请求失败!');
      } else {
        final AuthCRspEmailBean authCRspBean = response.data!.data!;
        expiresIn =  authCRspBean.expiresIn;
        releaseTimer();
        pageController.jumpToPage(5);
      }
    } else {
      showError(response.message);
    }
  }

  onIndex1PageNextStep(String value) async {
    //先上传头像
    showLoading();
    final response = await _uploadRepo.getUploadAuth();
    var imageUrls = '';
    if (response.isSuccess) {
      if (response.data?.data != null) {
        OssAuthBean ossAuthBean = response.data!.data!;
        final auth = Auth(
          accessKey: ossAuthBean.accessKeyId,
          accessSecret: ossAuthBean.accessKeySecret,
          secureToken: ossAuthBean.securityToken,
          expire: ossAuthBean.expiration,
        );
        Client.init(
            ossEndpoint: "oss-cn-hangzhou.aliyuncs.com",
            bucketName: "cxw-user",
            authGetter: () => auth);
        if (selectedImagesObx.value.isNotEmpty) {
          final bytes = await compressFile(File(selectedImagesObx.value));
          final udid = const Uuid().v4();
          final targetPath = "src/pet/${udid.replaceAll("-", "")}.jpeg";
          await Client().putObject(
            bytes,
            targetPath,
            option: PutRequestOption(
              onSendProgress: (count, total) {},
              override: true,
              aclModel: AclMode.inherited,
              storageType: StorageType.ia,
              headers: {"cache-control": "no-cache"},
            ),
          );
          imageUrls =
              "https://cxw-user.oss-cn-hangzhou.aliyuncs.com/$targetPath";
        }
      }
    }

    //
    final RegisterReqBean registerReqBean = RegisterReqBean(
      password: Md5Utils.generateMD5(passwordController.text),
      application: 'cutepet',
      nickName: nickNameController.text,
      organization: 'miaoai',
      userName: emailController.text,
      authCode: value,
      gender: sex.value == '男' ? 'male' : 'female',
      birthday: birthController.text,
      avator: imageUrls,
    );
    final registerResponse =
        await _repo.register(registerReqBean: registerReqBean);
    if (registerResponse.isSuccess) {
      showToast('注册成功');
      Get.back();
    } else {
      showError('注册失败');
    }
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
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
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
                        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                        uiSettings: [
                          AndroidUiSettings(
                            toolbarTitle: '裁剪',
                            toolbarColor: MyColors.themeTextColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.square,
                            lockAspectRatio: true,
                          ),
                          IOSUiSettings(
                            title: '裁剪',
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
  onClose() {
    emailController.dispose();
    authCodeController.dispose();
    birthController.dispose();
    nickNameController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    authCodeFocusNode.dispose();
    birthFocusNode.dispose();
    nickNameFocusNode.dispose();
    passwordFocusNode.dispose();
    countDownTimer?.cancel();
    super.onClose();
  }

  onIndex2PageShowBirDialog(BuildContext context) async {
    birthFocusNode.requestFocus();
    DateTime? dateTime = await showDatePicker(
        context: context,
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now());
    birthFocusNode.unfocus();
    if (dateTime != null) {
      birthController.setText(dateTime.toString().split(' ')[0]);
      birDayTime.value = calculateAge(dateTime);
    }
  }

  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
