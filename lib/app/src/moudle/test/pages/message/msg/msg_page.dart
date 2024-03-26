import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MsgPage extends StatelessWidget {
  final MessageController messageController;

  const MsgPage({super.key, required this.messageController});

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
                onPressed: () {},
                child: Text('搭讪'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w)),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 7.h),
                splashColor: MyColors.pageBgColor.withAlpha(30),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w)),
                child: Text('评论'),
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
              child: Text(
                '聊天',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              )),
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
                                  '暂无聊天记录',
                                  style: TextStyle(
                                      color: MyColors.textBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                const Text(
                                  '互相关注后即可畅快聊天，快去社区看看和有趣的人打个\r\n招呼吧～',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(color: MyColors.textGreyColor),
                                )
                              ],
                            ),
                          ),
                        );
                },
                id: messageController.msgPageManager.msgDataListId,
              )
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
