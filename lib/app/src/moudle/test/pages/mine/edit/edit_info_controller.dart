import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
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
  void onInit(){
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
  onImage1Clicked(){
    logE('1');

    showImagePickerBottomSheet(imageUrl1);

  }
  onImage2Clicked(){
    logE('2');

    showImagePickerBottomSheet(imageUrl2);

  }
  onImage3Clicked(){
    logE('3');

    showImagePickerBottomSheet(imageUrl3);

  }
  onImage4Clicked(){
    logE('4');
    showImagePickerBottomSheet(imageUrl4);

  }
  onImage5Clicked(){
    logE('5');
    showImagePickerBottomSheet(imageUrl5);

  }
  onImage6Clicked(){
    logE('6');
    showImagePickerBottomSheet(imageUrl6);
  }


  showImagePickerBottomSheet(RxString value) {
    Get.bottomSheet(
      Container(
        height: 200,
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
              TextButton(
                onPressed: () async {
                  Get.back();
                  String? path = await AImagePicker.instance().pickCamera();
                  if ((path?.length ?? 0) > 0) {


                    // CroppedFile croppedFile = await ImageCropper().cropImage(
                    //   sourcePath: imageFile.path,
                    //   aspectRatioPresets: [
                    //     CropAspectRatioPreset.square,
                    //     CropAspectRatioPreset.ratio3x2,
                    //     CropAspectRatioPreset.original,
                    //     CropAspectRatioPreset.ratio4x3,
                    //     CropAspectRatioPreset.ratio16x9
                    //   ],
                    //   uiSettings: [
                    //     AndroidUiSettings(
                    //         toolbarTitle: 'Cropper',
                    //         toolbarColor: Colors.deepOrange,
                    //         toolbarWidgetColor: Colors.white,
                    //         initAspectRatio: CropAspectRatioPreset.original,
                    //         lockAspectRatio: false),
                    //     IOSUiSettings(
                    //       title: 'Cropper',
                    //     ),
                    //     WebUiSettings(
                    //       context: context,
                    //     ),
                    //   ],
                    // );

                    value.value = path!;
                  }
                },
                child: const Text(
                  '相机',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Divider(
                color: Colors.pink,
              ),
              TextButton(
                onPressed: () async {
                  Get.back();
                  String? path = await AImagePicker.instance().pickGallery();
                  if ((path?.length ?? 0) > 0) {
                    value.value = path!;
                  }
                },
                child: const Text(
                  '相册',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                color: MyColors.textGreyColor.withOpacity(0.3),
                thickness: 5,
              ),
              TextButton(
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

}

class ItemBean {
  final String title;
  final String content;
  final String hintText;

  ItemBean(
      {required this.title, required this.content, required this.hintText});
}
