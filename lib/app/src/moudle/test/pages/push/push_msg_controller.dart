import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';
import 'package:app_base/mvvm/repository/push_repo.dart';
import 'package:app_base/util/file_utils.dart';
import 'package:dinosaur/app/src/moudle/test/pages/push/weight/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../pet/weight/image_preview.dart';
import '../pet/weight/image_preview_single.dart';

class PushMsgController extends BaseController {
  final _playRepo = Get.find<PlayRepo>();
  final tagList = <TopicList>[];
  final tagListId = 1;
  final selectedTag = ''.obs;
  final selectedImages = <String>[].obs;

  @override
  onInit() {
    _fetchTag();
    super.onInit();
  }
  imagePreView(List<String> images, BuildContext context, double size,
      int parentIndex) {
    ///每一张预期图片都是一个正方形
    if (images.isNotEmpty) {
        var reSizeHeight = size;
        var reSizeWidth = size;
        var crossAxisCount = 3;
        return SizedBox(
          width: reSizeWidth,
          height: reSizeHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 2.w,
              crossAxisSpacing: 2.w,
            ),
            itemBuilder: ((context, index) {
              var tag = '$parentIndex${index.toString()}';
              return LongPressDraggable(
                feedback: Container(width: 50.w,height: 50.w,color: Colors.pink,),
                child: DragTarget<String>(
                  builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                    return InkWell(
                      onTap: () {
                        final homeController = Get.find<HomeController>();
                        homeController.toImageView(images[index], tag);
                      },
                      child: ImagePreView(
                        url: images[index],
                        size: size,
                      ),
                    );
                  },
                ),
              );
            }),
            itemCount: images.length,
          ),
        );

    } else {
      return const SizedBox();
    }
  }
  _fetchTag() async {
    final response = await _playRepo.callTopCenter(
        topicCenterReq: TopicCenterReq(orderBy: "createTime desc"));
    if (response.isSuccess) {
      if (response.data?.data != null) {
        tagList.addAll(response.data!.data!.topicList);
        update([tagListId]);
      }
    }
  }

  onPicSelectClicked() {
    _showImagePickerBottomSheet();
  }

  _showImagePickerBottomSheet() {
    Get.bottomSheet(
      Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  Get.back();
                  String? path = await AImagePicker.instance().pickCamera();
                  if ((path?.length ?? 0) > 0) {
                    selectedImages.add(path!);
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
                    selectedImages.add(path!);
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

  buildSheetItem(TopicList item, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black),
            child: Icon(
              Icons.tag,
              color: Colors.white,
              size: 16.w,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.textBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  onBottomSheetItemClicked(TopicList item) {
    selectedTag.value = item.title;
  }

  buildBottomSheet(
    BuildContext context,
  ) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => Container(
          padding: EdgeInsets.only(
            top: 20.w,
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
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: MyColors.textBlackColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            onBottomSheetItemClicked(tagList[index]);
                            finish();
                          },
                          child: buildSheetItem(tagList[index], index),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 36.w),
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

  onOpenTheBottomSheet() {}

  onPushMsg() {}
}
