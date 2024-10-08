import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/oss_auth_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/mvvm/repository/model_repo.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';
import 'package:app_base/mvvm/repository/push_repo.dart';
import 'package:app_base/mvvm/repository/upload_repo.dart';
import 'package:app_base/util/image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/push/weight/long_press_pre_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import '../chart/weight/awesome_chart.dart';
import 'package:uuid/uuid.dart';

class PushMsgController extends BaseController {
  final _playRepo = Get.find<PlayRepo>();
  final _pushRepo = Get.find<PushRepo>();
  final _modelRepo = Get.find<ModelRepo>();
  final _uploadRepo = Get.find<UpLoadRepo>();
  final tagList = <TopicList>[];
  final waveList = <ModeList>[];
  final tagListId = 1;
  final imagesListId = 2;
  final waveListId = 3;
  final selectedWave = <int>[].obs;
  final selectedTag = ''.obs;
  var selectedImagesObx = <String>[];
  var selectedImagesWidth = <int>[];
  var selectedImagesHeight = <int>[];
  late TextEditingController editingController;

  @override
  onInit() {
    _fetchList();
    editingController = TextEditingController();
    super.onInit();
  }

  imagePreView(List<int>width,List<int>height,
      List<String> images, BuildContext context, double size, int parentIndex) {
    if (images.isNotEmpty) {
      double reSizeHeight;

      if (images.length <= 3) {
        reSizeHeight = size / 3;
      } else if (images.length > 3 && images.length <= 6) {
        reSizeHeight = size / 3 * 2;
      } else {
        reSizeHeight = size / 3 * 3;
      }
      var reSizeWidth = size;
      return SizedBox(
        width: reSizeWidth,
        height: reSizeHeight,
        child: LongPressPreView(
          images: images,
          height: selectedImagesHeight,
          width: selectedImagesWidth,
          size: double.infinity,
          parentIndex:parentIndex,
          onOrderUpdateCallBack: (value) {
            selectedImagesObx = value;
            update([imagesListId]);
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  onDeleteWave() {
    selectedWave.value = <int>[];
  }

  _fetchList() async {
    final response = await _playRepo.callTopCenter(
        topicCenterReq: TopicCenterReq(orderBy: "createTime desc"));
    if (response.isSuccess) {
      if (response.data?.data != null) {
        tagList.addAll(response.data!.data!.topicList);
        update([tagListId]);
      }
    }
    final waveResponse = await _modelRepo.getModel(
        recordReq: ModelReq(
      orderBy: "createTime desc",
      userId: User.loginRspBean!.userId,
    ));
    if (waveResponse.isSuccess) {
      if (waveResponse.data?.data != null) {
        waveList.addAll(waveResponse.data!.data!.modeList);
        update([waveListId]);
      }
    }
  }

  onPushClicked() async {
    var textValue = editingController.text.toString();
    if (textValue.isEmpty && selectedImagesObx.isEmpty) {
      showError('不能发布空信息哦');
      return;
    }
    showLoading(userInteraction: false);
    var imageUrls = <String>[];
    if (selectedImagesObx.isNotEmpty) {
      final response = await _uploadRepo.getUploadAuth();
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
          for (var i in selectedImagesObx) {
            final bytes = await compressFile(File(i));
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
            imageUrls.add(
                "https://cxw-user.oss-cn-hangzhou.aliyuncs.com/$targetPath");
          }
        }
      }
    }

    PushCreateReq pushCreateReq = PushCreateReq(
        waves: <Wave>[waveConverter(selectedWave)],
        topicId: findTopicId(
            selectedTag.value.isNullOrEmpty ? '' : selectedTag.value),
        topicTitle: selectedTag.value.isNullOrEmpty ? '' : selectedTag.value,
        images: await imagesConverter(imageUrls),
        userId: User.loginRspBean!.userId,
        content: editingController.text.toString());
    final response = await _pushRepo.pushMsg(pushCreateReq);
    if (response.isSuccess) {
      EasyLoading.showSuccess('上传成功');
      if (response.data?.data != null) {
        var data = response.data!.data!;
        setResult(data);
        finish();
      }
    }
    dismiss();
  }

  waveConverter(List<int> selectedWave) {
    String jsonWave = jsonEncode(selectedWave);
    Wave wave = Wave(id: '', actions: jsonWave);
    return wave;
  }

  onPicSelectClicked() {
    _showImagePickerBottomSheet();
  }

  imagesConverter(List<String> images) async {
    if (images.isEmpty) {
      return <ImageString>[];
    }
    final urlImages = <ImageString>[];
    for (var i in images) {
      ui.Image image = await loadImageWithUrl(i, Get.context!);
      urlImages.add(
        ImageString(
          imageBase64: '',
          imageUrl: i,
          width: image.width,
          height: image.height,
        ),
      );
    }
    return urlImages;
  }

  findTopicId(String tag) {
    for (var i in tagList) {
      if (i.title == tag) {
        return i.id;
      }
    }
    return '';
  }

  _showImagePickerBottomSheet() {
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
                    selectedImagesObx.add(path!);
                  var image =   await loadImageWithPath(path, Get.context!);
                    selectedImagesHeight.add(image.height);
                    selectedImagesWidth.add(image.width);
                    update([imagesListId]);
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
                    selectedImagesObx.add(path!);
                    update([imagesListId]);
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

  buildTagSheetItem(TopicList item, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black),
            child: const Icon(
              Icons.tag,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 14,
              color: MyColors.textBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  buildWaveSheetItem(ModeList item, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                //Todo
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150/0000F1/808080?Text=Image1'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 40,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '我的',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.peopleRobbery,
                              size: 12,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '1',
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: 12,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '0',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              AwesomeChartView(
                animatedInfoKey: 'push_controller_page_chart$index',

                dataList: <List<int>>[item.actions.record],
                width: double.infinity,
                height: 138,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${item.kcal}kcal",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  onBottomSheetTagItemClicked(TopicList item) {
    selectedTag.value = item.title;
  }

  onBottomSheetWaveItemClicked(ModeList item) {
    selectedWave.value = item.actions.record;
  }

  buildWaveBottomSheet(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => Container(
          padding: EdgeInsets.only(
            top: 20,
          ),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButton(),
                  Text(
                    '选择插入的波形',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: MyColors.textBlackColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: GetBuilder<PushMsgController>(
                    builder: (controller) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                onBottomSheetWaveItemClicked(waveList[index]);
                                finish();
                              },
                              child: buildWaveSheetItem(waveList[index], index),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: MyColors.textGreyColor.withOpacity(0.3),
                            );
                          },
                          itemCount: waveList.length);
                    },
                    id: waveListId,
                  ),
                ),
              )
            ],
          ),
        ),
      );

  buildTagsBottomSheet(
    BuildContext context,
  ) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => Container(
          padding: EdgeInsets.only(
            top: 20,
          ),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButton(),
                  Text(
                    '选择一个话题',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: MyColors.textBlackColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            onBottomSheetTagItemClicked(tagList[index]);
                            finish();
                          },
                          child: buildTagSheetItem(tagList[index], index),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 36),
                          child: Divider(
                            color: MyColors.textGreyColor.withOpacity(0.3),
                          ),
                        );
                      },
                      itemCount: tagList.length),
                ),
              )
            ],
          ),
        ),
      );

  onPushMsg() {}
}
