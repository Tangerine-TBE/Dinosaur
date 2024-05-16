import 'package:app_base/config/size.dart';
import 'package:app_base/config/translations/msg_cn.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/edit/edit_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutController extends BaseController {
  final listId = 1;
  final list = <ItemBean>[];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    ItemBean itemBean1 = ItemBean(title: '版本更新', content: '', hintText: '');
    ItemBean itemBean2 = ItemBean(title: '小萌宠用户协议', content: '', hintText: '');
    ItemBean itemBean3 = ItemBean(title: '小萌宠隐私协议', content: '', hintText: '');
    ItemBean itemBean4 =
        ItemBean(title: 'APP用户使用规范', content: '', hintText: '');
    ItemBean itemBean5 = ItemBean(title: 'APP社区规范', content: '', hintText: '');
    list.add(itemBean1);
    list.add(itemBean2);
    list.add(itemBean3);
    list.add(itemBean4);
    list.add(itemBean5);
    update([listId]);
    super.onReady();
  }

  onTapPrivacy() {
    _showPrivacyDialog();
  }

  onTapAgreement() {
    _showProtocolDialog();
  }

  void _showProtocolDialog() async {
    var selectedConfirm = false;
    await Get.bottomSheet(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    '《小萌宠用户协议》',
                    style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(MsgCopy.privacyContent)),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          finish();
                        },
                        height: 40,
                        color: Colors.red,
                        child: const Text('取消'),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          selectedConfirm = true;
                          finish();
                        },
                        height: 40,
                        color: Colors.green,
                        child: Text('确定'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    if (selectedConfirm && SaveKey.readPrivacy.read != null) {
      if (SaveKey.readPrivacy.read) {}
    }
    SaveKey.readUserProtected.save(selectedConfirm);
  }

  void _showPrivacyDialog() async {
    var selectedConfirm = false;
    await Get.bottomSheet(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    '《小萌宠隐私保护政策》',
                    style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(MsgCopy.agreeContent)),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          finish();
                        },
                        height: 40,
                        color: Colors.red,
                        child: const Text('取消'),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: () {
                          selectedConfirm = true;
                          finish();
                        },
                        height: 40,
                        color: Colors.green,
                        child: Text('确定'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    if (selectedConfirm && SaveKey.readUserProtected.read != null) {
      if (SaveKey.readUserProtected.read) {
        //打勾
      }
    }
    SaveKey.readPrivacy.save(selectedConfirm);
  }

  onItemClicked(int index) {
    switch (index) {
      case 0:
        //Todo 打开网页
        showToast('打开网页！');
        break;
      case 1:
        onTapAgreement();
        break;
      case 2:
        onTapPrivacy();
        break;
      case 3:
        //Todo 弹出APP用户使用规范
        break;
      case 4:
        //Todo 弹出APP社区规范
        break;
      default:
        break;
    }
  }
}
