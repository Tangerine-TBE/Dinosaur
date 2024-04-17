import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/edit/weight/record_sound_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class EditInfoController extends BaseController {
  final listData = <ItemBean>[];
  final listId = 1;
  final imageUrl1 = ''.obs;
  final imageUrl2 = ''.obs;
  final imageUrl3 = ''.obs;
  final imageUrl4 = ''.obs;
  final imageUrl5 = ''.obs;
  final imageUrl6 = ''.obs;
  late FlutterSoundRecorder record;
  late FlutterSoundPlayer play;

  @override
  void onInit() {
    fetchItems();
    record = FlutterSoundRecorder(logLevel: Level.debug);
    play = FlutterSoundPlayer(logLevel: Level.debug);
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

  onItemClicked(int index)  {
    if (index == 0) {
      showNickNameEditBottomSheet(listData[0]);
    } else if (index == 1) {
      showSignVoiceEditBottomSheet(listData[1]);
    } else if (index == 2) {
      showSignTextEditBottomSheet(listData[2]);
    } else if (index == 3) {
    } else if (index == 4)  {
      DatePicker.showDatePicker(
        Get.context!,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime.now(),
        onConfirm: (date) {
          ItemBean exchangedBean = ItemBean(
              title: listData[4].title,
              content: '${date.year}-${date.month}-${date.day}',
              hintText: listData[4].hintText);
          listData[4]= exchangedBean;
          update([listId]);
        },
        currentTime: DateTime.tryParse(listData[index].content),
        locale: LocaleType.zh,
      );
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

  showImagePickerBottomSheet(RxString value) async {
    await Get.bottomSheet(
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
                    ItemBean exchangedBean = ItemBean(
                        title: itemBean.title,
                        content: textEditController.text,
                        hintText: itemBean.hintText);
                    listData[0] = exchangedBean;
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

  showSignVoiceEditBottomSheet(ItemBean itemBean) async {
    await Get.bottomSheet(
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
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      finish();
                    },
                    child: const Icon(Icons.cancel),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      // itemBean.title,
                      '设置语音签名',
                      style: const TextStyle(
                        color: MyColors.textBlackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // MaterialButton(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12),
                  //   color: MyColors.themeTextColor,
                  //   minWidth: 20,
                  //   height: 30,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       side: const BorderSide(color: Colors.black)),
                  //   onPressed: () {
                  //     update([listId]);
                  //     finish();
                  //   },
                  //   child: const Text('保存'),
                  // ),
                ],
              ),
            ),
            Text('不知道说什么？点这里找灵感'),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: loadImageProvider(''),
                    ),
                    const Positioned(
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.greenAccent,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: loadImageProvider(''),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.greenAccent,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: loadImageProvider(''),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.greenAccent,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: loadImageProvider(''),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.greenAccent,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: Divider(),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '录制长于10秒的声音',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '你的用心让TA听到',
              style: TextStyle(
                color: MyColors.textGreyColor,
              ),
            ),
            Expanded(
              child: RecordSoundView(
                recordEndCallback: () {
                  recordStop();
                },
                recordStartCallback: recordStart,
                saveRecordClicked: () {},
                dismissRecordClicked: () {},
                startPlayed: () {
                  startPlay();
                },
                stopPlayed: () {
                  stopPlay();
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (Get.isBottomSheetOpen == false) {
      stopPlay();
      recordStop();
    }
  }

  String? recordUrl = '';

  Future recordStart() async {
    await record.openRecorder();
    await record.startRecorder(toFile: Uuid().v4());
  }

  recordStop() async {
    recordUrl = await record.stopRecorder();
  }

  saveRecord() {
    //保存上传
  }

  startPlay() async {
    await play.openPlayer();
    await play.startPlayer(fromURI: recordUrl, codec: Codec.mp3);
  }

  stopPlay() async {
    if (play.isOpen()) {
      await play.pausePlayer();
    }
  }

  showSignTextEditBottomSheet(ItemBean itemBean) {
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
                    ItemBean exchangedBean = ItemBean(
                        title: itemBean.title,
                        content: textEditController.text,
                        hintText: itemBean.hintText);
                    listData[2] = exchangedBean;
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
              maxLines: null,
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
