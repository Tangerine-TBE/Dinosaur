import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class EditInfoController extends BaseController {
  final listData = <ItemBean>[];
  final listId = 1;
  final imageUrl1 = ''.obs;
  final imageUrl2 = ''.obs;
  final imageUrl3 = ''.obs;
  final imageUrl4 = ''.obs;
  final imageUrl5 = ''.obs;
  final imageUrl6 = ''.obs;

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  fetchItems() {
    listData.add(
      ItemBean(title: '昵称', content: 'bennitfy', hintText: ''),
    );
    listData.add(
      ItemBean(title: '语音签名', content: '呀！我好喜欢。', hintText: '还未设置语音签名哦'),
    );
    listData.add(
      ItemBean(title: '签名', content: '呀！我好喜欢。', hintText: ''),
    );
    listData.add(
      ItemBean(title: '来自', content: '中国 * 大陆', hintText: ''),
    );
    listData.add(
      ItemBean(title: '生日', content: '1997-12-16', hintText: ''),
    );
    update([listId]);
  }

  onItemClicked(int index) {
    if (index == 0) {
      showNickNameEditBottomSheet(listData[0]);
    }
  }

  onImage1Clicked() {
    showImagePickerBottomSheet(imageUrl1);
  }

  onImage2Clicked() {
    logE('2');

    showImagePickerBottomSheet(imageUrl2);
  }

  onImage3Clicked() {
    logE('3');

    showImagePickerBottomSheet(imageUrl3);
  }

  onImage4Clicked() {
    logE('4');
    showImagePickerBottomSheet(imageUrl4);
  }

  onImage5Clicked() {
    logE('5');
    showImagePickerBottomSheet(imageUrl5);
  }

  onImage6Clicked() {
    logE('6');
    showImagePickerBottomSheet(imageUrl6);
  }

  showImagePickerBottomSheet(RxString value) {
    Get.bottomSheet(
      Container(
        height: value.value.isNotEmpty ? 200 : 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              MaterialButton(
                minWidth: 50,
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
                minWidth: 50,
                onPressed: () async {
                  Get.back();
                  String? path = await AImagePicker.instance().pickGallery();
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
                  minWidth: 50,
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
                minWidth: 50,
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
    );
  }

  showNickNameEditBottomSheet(ItemBean itemBean) {
    final textEditController = TextEditingController(text: itemBean.content);
    Get.bottomSheet(

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    finish();
                  },
                  child: const Icon(Icons.cancel),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    itemBean.title,
                    style: const TextStyle(
                      color: MyColors.textBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: MyColors.themeTextColor,
                  minWidth: 20,
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black)),
                  onPressed: () {
                    update([listId]);
                    finish();
                  },
                  child: const Text('保存'),
                ),
              ],
            ),
            TextField(
              controller: textEditController,
              cursorColor: MyColors.textBlackColor,
              autofocus: true,
              maxLength: 16,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.themeTextColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.themeTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSignVoiceEditBottomSheet(RxString value) {


  }

  showSignTextEditBottomSheet(RxString value) {}

  showComeFromEditBottomSheet(RxString value) {}

  showBirDayEditBottomSheet(RxString value) {}
}

class ItemBean {
  final String title;
  final String content;
  final String hintText;

  ItemBean(
      {required this.title, required this.content, required this.hintText});
}
