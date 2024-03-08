
import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/pages/test1/test1Controller.dart';

class test1 extends BaseEmptyPage<Test1Controller> {
  const test1({super.key});

  @override
  AppBar? buildAppBar() {
    return AppBar(
      backgroundColor: MyColors.pageBgColor,
      centerTitle: true,
      title:const Text(
          'udp指令测试'
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10.h),
          child: PopupMenuButton(
            // shape: const TooltipShape(),
            offset: Offset(0, 55.h),
            color: Colors.amber,
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Icon(Icons.menu),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    controller.setting();
                  },
                  value: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.report_outlined,
                    ),
                  ),
                ),
              ];
            },
          ),
        )
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.pageBgColor,
      body: LayoutBuilder(
        builder: (context, constrants) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constrants.maxHeight),
              child: Column(
                children: [
                  Expanded(
                    child: GetBuilder<Test1Controller>(
                      builder: (Test1Controller controller) {
                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          controller: controller.scrollController,
                          reverse: true,
                          children: controller.charData
                              .map((e) {
                                return e.type == 0
                                  ? buildMessageSendWidget('${e.size}--${e.msg}')
                                  : buildMessageRecepWidget('${e.size}--${e.msg}');
                              })
                              .toList(),
                        );
                      },
                      id: controller.chatListId,
                    ),
                  ),
                  buildTextInputField(),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMessageSendWidget(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10, bottom: 10,left: 20),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: const BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border(
                top: BorderSide(
                  color: MyColors.containerSideColor,
                ),
                left: BorderSide(
                  color: MyColors.containerSideColor,
                ),
                right: BorderSide(
                  color: MyColors.containerSideColor,
                ),
                bottom: BorderSide(
                  color: MyColors.containerSideColor,
                ),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildMessageRecepWidget(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10,right: 20),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border(
                top: BorderSide(
                  color: MyColors.containerSideColor,
                ),
                left: BorderSide(
                  color: MyColors.containerSideColor,
                ),
                right: BorderSide(
                  color: MyColors.containerSideColor,
                ),
                bottom: BorderSide(
                  color: MyColors.containerSideColor,
                ),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTextInputField() {
    return Obx(
      () => TextField(
        controller: controller.textEditingController,
        enabled: controller.sendInput.value,
        autofocus: false,
        minLines: 1,
        textInputAction: TextInputAction.send,
        onEditingComplete: () {
          //不做任何事情，
        },
        style: TextStyle(
          fontSize: 18.sp,
          textBaseline: TextBaseline.alphabetic,
        ),
        onChanged: (value) => {},
        onSubmitted: (value) => {controller.udpWrite(value)},
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: const Icon(
            Icons.chat,
            color: Colors.black,
          ),
          alignLabelWithHint: true,
          hintStyle: const TextStyle(
            height: 2.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.black, //边线颜色为白色
              width: 1, //边线宽度为2
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black, //边框颜色为白色
              width: 1, //宽度为5
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black, //边框颜色为白色
              width: 1, //宽度为5
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
