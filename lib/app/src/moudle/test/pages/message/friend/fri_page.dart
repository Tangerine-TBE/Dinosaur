import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../message_controller.dart';

class FriPage extends StatelessWidget {
  final MessageController messageController;

  const FriPage({super.key, required this.messageController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  messageController.msgPageManager.onFvkClicked();
                },
                child: Text('粉丝'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w)),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 7.h),
                splashColor: MyColors.pageBgColor.withAlpha(30),
              ),
              MaterialButton(
                onPressed: () {
                  messageController.msgPageManager.onWeekClicked();
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w)),
                child: Text('已关注'),
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 7.h),
                splashColor: MyColors.pageBgColor.withAlpha(30),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Obx(
              () => Text(
                '我的好友（${messageController.friendPageManager.dataSize.value}）',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              GetBuilder<MessageController>(
                builder: (controller) {
                  return messageController.msgPageManager.data.isNotEmpty
                      ? SliverList.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return _buildMsgItem();
                          },
                          itemCount:
                              messageController.msgPageManager.data.length,
                        )
                      : SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '你还没有好友',
                                  style: TextStyle(
                                      color: MyColors.textBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                },
                id: messageController.friendPageManager.msgDataListId,
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildMsgItem() {
    return Container(
      height: 20,
      width: 20,
    );
  }
}
