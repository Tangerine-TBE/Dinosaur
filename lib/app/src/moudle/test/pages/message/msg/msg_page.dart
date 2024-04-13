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
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  messageController.msgPageManager.onFvkClicked();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
                splashColor: MyColors.pageBgColor.withAlpha(30),
                child: const Text('搭讪'),
              ),
              MaterialButton(
                onPressed: () {
                  messageController.msgPageManager.onWeekClicked();
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
                splashColor: MyColors.pageBgColor.withAlpha(30),
                child: const Text('评论'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '聊天',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
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
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 6,
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
