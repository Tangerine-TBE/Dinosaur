import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/setting/setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingPage extends BaseEmptyPage<SettingController> {
  const SettingPage({super.key});
  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff1f3),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '设置',
          style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
        ),
        backgroundColor: const Color(
          0xffeff1f3,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          '品牌设置',
                          style: TextStyle(color: MyColors.textGreyColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('APP 图标'),
                      ),
                      loadImage('', 20, 20),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text('选择品牌'),
                      ),
                      Text('小萌宠'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '隐私设置',
                          style: TextStyle(color: MyColors.textGreyColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('允许被搭讪'),
                      ),
                     Obx(() =>
                         CupertinoSwitch(value: controller.allowToBother.value, onChanged: (value) {
                           controller.allowToBother.value = value;
                           controller.saveSettingInfo(SettingKey.allowToBother.toString(), value?"1":"2");
                         })
                     )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('波形作品公开'),
                      ),
                      Obx(() =>
                          CupertinoSwitch(value: controller.allowToPublic.value, onChanged: (value) {
                            controller.allowToPublic.value = value;
                            controller.saveSettingInfo(SettingKey.allowToPublic.toString(), value?"1":"2");

                          })
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '消息通知',
                          style: TextStyle(color: MyColors.textGreyColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('萌宠物圈互动消息'),
                      ),
                      Obx(() =>    CupertinoSwitch(value: controller.petMessageNotify.value, onChanged: (value) {
                        controller.petMessageNotify.value =value;
                        controller.saveSettingInfo(SettingKey.petMessageNotify.toString(), value?"1":"2");

                      }))
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('波形互动消息'),
                      ),
                      Obx(() => CupertinoSwitch(value: controller.chartMessageNotify.value, onChanged: (value) {
                        controller.chartMessageNotify.value = value;
                        controller.saveSettingInfo(SettingKey.chartMessageNotify.toString(), value?"1":"2");

                      }))
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('搭讪消息'),
                      ),
                      Obx(() =>
                          CupertinoSwitch(value: controller.botherMessageNotify.value, onChanged: (value) {
                            controller.botherMessageNotify.value = value;
                            controller.saveSettingInfo(SettingKey.botherMessageNotify.toString(), value?"1":"2");

                          })
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('被关注消息'),
                      ),
                      Obx(() =>
                          CupertinoSwitch(value: controller.subscribeMessageNotify.value, onChanged: (value) {
                            controller.subscribeMessageNotify.value = value;
                            controller.saveSettingInfo(SettingKey.subscribeMessageNotify.toString(), value?"1":"2");

                          })
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('私信消息'),
                      ),
                      Obx(() => CupertinoSwitch(value: controller.chatPrivateMessageNotify.value, onChanged: (value) {
                        controller.chatPrivateMessageNotify.value = value;
                        controller.saveSettingInfo(SettingKey.chatPrivateMessageNotify.toString(), value?"1":"2");

                      }))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('账号注销'),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('关于'),
                      ),
                      Text(
                        'v1.0.1(1)',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                      controller.onLogOutClicked();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('退出登录'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
