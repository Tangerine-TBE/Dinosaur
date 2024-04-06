import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';
import 'package:app_base/mvvm/repository/push_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushMsgController extends BaseController {
  final _playRepo = Get.find<PlayRepo>();
  final tagList = <TopicList>[];
  final tagListId = 1;
  final selectedTag = ''.obs;

  @override
  onInit() {
    _fetchTag();
    super.onInit();
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

  onBottomSheetItemClicked(TopicList item) {}

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
