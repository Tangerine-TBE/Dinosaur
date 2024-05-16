import 'dart:convert';

import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/home_bean.dart';
import 'package:app_base/mvvm/repository/edit_info_repo.dart';
import 'package:app_base/mvvm/repository/upload_repo.dart';
import 'package:app_base/network/utils/upload_utils.dart';
import 'package:app_base/util/image.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:dinosaur/app/src/moudle/test/device/country.dart';
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
import 'package:city_pickers/city_pickers.dart';

class EditInfoController extends BaseController {
  final _repo = Get.find<EditInfoRepo>();
  final _upLoadRepo = Get.find<UpLoadRepo>();
  final listData = <ItemBean>[];
  final listId = 1;
  final imagesObxAvator = ''.obs;
  final imagesObxValue1 = ''.obs;
  final imagesObxValue2 = ''.obs;
  final imagesObxValue3 = ''.obs;
  final imagesObxValue4 = ''.obs;
  final imagesObxValue5 = ''.obs;
  late FlutterSoundRecorder record;
  late FlutterSoundPlayer play;
  HomeRsp? homeRsp = User.loginUserInfo;
  final playVoice = false.obs;
  final voiceFile = ''.obs;

  @override
  void onInit() {
    fetchItems();
    record = FlutterSoundRecorder(logLevel: Level.debug);
    play = FlutterSoundPlayer(logLevel: Level.debug);
    if (homeRsp != null) {
      voiceFile.value = homeRsp!.voiceSign;
      imagesObxAvator.value = homeRsp!.avator;
      imagesObxValue1.value = homeRsp!.image1;
      imagesObxValue2.value = homeRsp!.image2;
      imagesObxValue3.value = homeRsp!.image3;
      imagesObxValue4.value = homeRsp!.image4;
      imagesObxValue5.value = homeRsp!.image5;
    }
    super.onInit();
  }

  fetchItems() {
    listData.add(
      ItemBean(
          title: '昵称', content: User.getUserNickName(), hintText: '还未设置昵称哦'),
    );
    listData.add(
      ItemBean(
          title: '语音签名',
          content: User.getUserVoiceSign(),
          hintText: '还未设置语音签名哦'),
    );
    listData.add(
      ItemBean(title: '签名', content: User.getUserSign(), hintText: '还未设置签名信息哦'),
    );
    listData.add(
      ItemBean(
          title: '来自', content: User.getUserAddress(), hintText: '还未设置地区信息'),
    );
    listData.add(
      ItemBean(title: '生日', content: User.getBirthday(), hintText: '还未设置生日信息呢'),
    );
    update([listId]);
  }

  _editUserInfo(String path, Map<String, dynamic> map) {
    _repo.editUserInfo(
      path: path,
      map: map,
    );
  }

  onItemClicked(int index) async {
    if (index == 0) {
      showNickNameEditBottomSheet(listData[0]);
    } else if (index == 1) {
      showSignVoiceEditBottomSheet(listData[1]);
    } else if (index == 2) {
      showSignTextEditBottomSheet(listData[2]);
    } else if (index == 3) {
      Result? result = await CityPickers.showCityPicker(
        showType: ShowType.p,
        locationCode: '719',
        height: 380,
        confirmWidget: Text(
          '确定',
          style: TextStyle(
            color: MyColors.themeTextColor,
          ),
        ),
        itemExtent: 50,
        cancelWidget: Text(
          '取消',
          style: TextStyle(
            color: MyColors.themeTextColor,
          ),
        ),
        itemBuilder: (value, list, index) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          );
        },
        provincesData: countriesData,
        context: Get.context!,
      );
      if (result != null) {
        ItemBean exchangedBean = ItemBean(
            title: listData[3].title,
            content: result.provinceName!,
            hintText: listData[3].hintText);
        listData[3] = exchangedBean;
        _editUserInfo(User.getUserId(),
            {'address': result.provinceName!});
        if(homeRsp != null){
          homeRsp!.address = result.provinceName!;
        }
        update([listId]);

      }
    } else if (index == 4) {
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
          listData[4] = exchangedBean;
          _editUserInfo(User.getUserId(),
              {'sign': '${date.year}-${date.month}-${date.day}'});
          HomeRsp? homeRsp = User.loginUserInfo;
          if (homeRsp != null) {
            homeRsp.birthday = '${date.year}-${date.month}-${date.day}';
          }
          update([listId]);
        },
        currentTime: DateTime.tryParse(listData[index].content),
        locale: LocaleType.zh,
      );
    }
  }

  onImage1Clicked() {
    showImagePickerBottomSheet(imagesObxAvator, 0);
  }

  onImage2Clicked() {
    showImagePickerBottomSheet(imagesObxValue1, 1);
  }

  onImage3Clicked() {
    showImagePickerBottomSheet(imagesObxValue2, 2);
  }

  onImage4Clicked() {
    showImagePickerBottomSheet(imagesObxValue3, 3);
  }

  onImage5Clicked() {
    showImagePickerBottomSheet(imagesObxValue4, 4);
  }

  onImage6Clicked() {
    showImagePickerBottomSheet(imagesObxValue5, 5);
  }

  showImagePickerBottomSheet(
    RxString obxValue,
    int index,
  ) async {
    await Get.bottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
      SafeArea(
        child: Container(
          height: obxValue.value.isNotEmpty ? 200 : 150,
          decoration: const BoxDecoration(
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
                        obxValue.value = croppedFile.path;
                        if (index == 0) {
                          UploadUtils.upLoadFile(
                              _upLoadRepo,
                              '.jpeg',
                              croppedFile.path,
                              (path) => _editUserInfo(
                                  User.getUserId(), {'avator': path}));
                          if (homeRsp != null) {
                            homeRsp!.avator = obxValue.value;
                          }
                        } else {
                          UploadUtils.upLoadFile(
                            _upLoadRepo,
                            '.jpeg',
                            obxValue.value,
                            (path) {
                              _editUserInfo(
                                User.getUserId(),
                                {
                                  'image$index': path,
                                },
                              );
                            },
                          );
                          switch (index) {
                            case 1:
                              homeRsp!.image1 = obxValue.value;
                              break;
                            case 2:
                              homeRsp!.image2 = obxValue.value;
                              break;
                            case 3:
                              homeRsp!.image3 = obxValue.value;
                              break;
                            case 4:
                              homeRsp!.image4 = obxValue.value;
                              break;
                            case 5:
                              homeRsp!.image5 = obxValue.value;
                              break;
                            default:
                              break;
                          }
                        }
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
                        aspectRatio:
                            const CropAspectRatio(ratioX: 1, ratioY: 1),
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
                        obxValue.value = croppedFile.path;
                        if (index == 0) {
                          UploadUtils.upLoadFile(
                              _upLoadRepo,
                              '.jpeg',
                              croppedFile.path,
                              (path) => _editUserInfo(
                                  User.getUserId(), {'avator': path}));
                          if (homeRsp != null) {
                            homeRsp!.avator = obxValue.value;
                          }
                        } else {
                          UploadUtils.upLoadFile(
                            _upLoadRepo,
                            '.jpeg',
                            obxValue.value,
                            (path) {
                              _editUserInfo(
                                User.getUserId(),
                                {
                                  'image$index': path,
                                },
                              );
                            },
                          );
                          if (index == 1) {}
                          switch (index) {
                            case 1:
                              homeRsp!.image1 = obxValue.value;
                              break;
                            case 2:
                              homeRsp!.image2 = obxValue.value;
                              break;
                            case 3:
                              homeRsp!.image3 = obxValue.value;
                              break;
                            case 4:
                              homeRsp!.image4 = obxValue.value;
                              break;
                            case 5:
                              homeRsp!.image5 = obxValue.value;
                              break;
                            default:
                              break;
                          }
                        }
                      }
                    }
                  },
                  child: const Text(
                    '相册',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                if (obxValue.value.isNotEmpty)
                  const Divider(
                    height: 1,
                    color: Colors.pink,
                  ),
                if (obxValue.value.isNotEmpty)
                  MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      obxValue.value = '';
                      if (index == 1) {
                        _editUserInfo(User.getUserId(), {'avator': ''});
                      } else {
                        _editUserInfo(
                          User.getUserId(),
                          {
                            'image$index': '',
                          },
                        );
                      }
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
                    _editUserInfo(User.getUserId(),
                        {'nickName': textEditController.text});
                    if (homeRsp != null) {
                      homeRsp!.nickName = textEditController.text;
                    }
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
      backgroundColor: Colors.white,
      elevation: 0,
      SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
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
                    const Expanded(
                      child: Text(
                        // itemBean.title,
                        '设置语音签名',
                        style: TextStyle(
                          color: MyColors.textBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text('不知道说什么？点这里找灵感'),
              const SizedBox(
                height: 10,
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
                  const SizedBox(
                    width: 20,
                  ),
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
                  const SizedBox(
                    width: 20,
                  ),
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
                  const SizedBox(
                    width: 20,
                  ),
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
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 34),
                child: Divider(),
              ),
              Obx(
                () => voiceFile.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          margin: const EdgeInsets.only(right: 34),
                          constraints:
                              BoxConstraints.loose(const Size(200, 60)),
                          decoration: BoxDecoration(
                            color: MyColors.themeTextColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.record_voice_over),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Obx(
                                  () => InkWell(
                                    onTap: () {
                                      if (!playVoice.value) {
                                        startPlay(1);
                                      } else {
                                        stopPlay(1);
                                      }
                                    },
                                    child: playVoice.value
                                        ? AudioWave(
                                            height: 20,
                                            width: 90,
                                            spacing: 2.5,
                                            animation: true,
                                            bars: [
                                              AudioWaveBar(
                                                  heightFactor: 0.2,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.3,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.4,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.4,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.1,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.9,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.2,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.3,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.2,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.4,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.8,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.4,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.3,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.2,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 1.0,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.5,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.6,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.7,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.3,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.2,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.4,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.4,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 0.7,
                                                  color: Colors.black),
                                              AudioWaveBar(
                                                  heightFactor: 1.0,
                                                  color: Colors.black),
                                            ],
                                          )
                                        : const Icon(Icons.play_arrow_sharp),
                                  ),
                                ),
                              ),
                              const Text('29\'\''),
                              InkWell(
                                onTap: () {
                                  //delete
                                  _editUserInfo(
                                      User.getUserId(), {'voiceSign': ''});
                                  if (homeRsp != null) {
                                    homeRsp!.voiceSign = '';
                                  }
                                  if (play.isPlaying) {
                                    stopPlay(1);
                                  }
                                  voiceFile.value = '';
                                },
                                child: const Icon(Icons.cancel_outlined),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '录制长于10秒的声音',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                '你的用心让TA听到',
                style: TextStyle(
                  color: MyColors.textGreyColor,
                ),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: RecordSoundView(
                    recordEndCallback: () {
                      recordStop();
                    },
                    recordStartCallback: recordStart,
                    saveRecordClicked: () {
                      if (recordUrl != null) {
                        UploadUtils.upLoadFile(
                          _upLoadRepo,
                          "",
                          recordUrl!,
                          (path) => _repo.editUserInfo(
                            path: User.getUserId(),
                            map: {
                              'voiceSign': path,
                            },
                          ),
                        );
                        if (homeRsp != null) {
                          homeRsp!.voiceSign = recordUrl!;
                        }
                        voiceFile.value = recordUrl!;
                        playVoice.value = false;
                      }
                    },
                    dismissRecordClicked: () {},
                    startPlayed: () {
                      startPlay();
                    },
                    stopPlayed: () {
                      stopPlay();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (Get.isBottomSheetOpen == false) {
      stopPlay();
    }
  }

  String? recordUrl = User.getUserVoiceSign();

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

  startPlay([int type = 0]) async {
    await play.openPlayer();
    await play.startPlayer(
        fromURI: recordUrl,
        codec: Codec.mp3,
        whenFinished: () {
          if (type == 1) {
            playVoice.value = false;
          }
        });
    if (type == 1) {
      playVoice.value = true;
    }
  }

  stopPlay([int type = 0]) async {
    if (play.isPlaying) {
      playVoice.value = false;
      await play.closePlayer();
    }
    if (type == 1) {
      playVoice.value = false;
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
                    _editUserInfo(
                        User.getUserId(), {'sign': textEditController.text});
                    if (homeRsp != null) {
                      homeRsp!.sign = textEditController.text;
                    }
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

  showBirDayEditBottomSheet() {}
}

class ItemBean {
  final String title;
  final String content;
  final String hintText;

  ItemBean(
      {required this.title, required this.content, required this.hintText});
}
