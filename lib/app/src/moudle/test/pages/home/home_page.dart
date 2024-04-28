import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends BaseEmptyPage<HomeController> {
  @override
  bool get canPopBack => false;
  const HomePage({super.key});

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Obx(() => _getButtonNavigationBar()),
      ),
      body: SafeArea(
        top: false,
        child: Navigator(
          key: Get.nestedKey(1),
          initialRoute: RouteName.playPage,
          onGenerateRoute: controller.onGenerateRoute,
        ),
      ),
    );
  }

  Widget _getButtonNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
      child: BottomNavigationBar(
        backgroundColor: MyColors.homePageNaviBgColor,
        unselectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        selectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedItemColor: MyColors.homePageNaviItemNormalColor,
        selectedItemColor: MyColors.homePageNaviItemSelectColor,
        type: BottomNavigationBarType.fixed,
        items: [
          _getNaviBarItem(
            '玩耍',
            ResName.iconPlay,
            ResName.iconPlay,
          ),
          _getNaviBarItem(
            '波形',
            ResName.iconConvert,
            ResName.iconConvert,
          ),
          _getNaviBarItem(
            '萌宠圈',
            ResName.iconGhost,
            ResName.iconGhost,
          ),
          _getNaviBarItem(
            '消息',
            ResName.iconMessage,
            ResName.iconMessage,
          ),
          _getNaviBarItem(
            '我的',
            ResName.iconGrammerly,
            ResName.iconGrammerly,
          ),
        ],
        currentIndex: controller.selectedTabIndex.value,
        onTap: (index) {
          if (index == controller.selectedTabIndex.value) {
            return;
          }
          controller.selectedTabIndex.value = index;
          if (index == 0) {
            Get.toNamed(RouteName.playPage, id: 1);
          } else if (index == 1) {
            Get.toNamed(RouteName.chartPage, id: 1);
          } else if (index == 2) {
            Get.toNamed(RouteName.petPage, id: 1);
          } else if (index == 3) {
            Get.toNamed(RouteName.message, id: 1);
          } else if (index == 4) {
            Get.toNamed(RouteName.minePage, id: 1);
          }
        },
      ),
    );
  }

  BottomNavigationBarItem _getNaviBarItem(
    String title,
    String highlightIcon,
    String icon,
  ) {
    return BottomNavigationBarItem(
      activeIcon: Image.asset(
        highlightIcon,
        color: MyColors.iconSelectedColor,
        width: 22,
        height: 22,
      ),
      icon: Image.asset(
        icon,
        color: Colors.grey,
        width: 22,
        height: 22,
      ),
      label: title,
    );
  }
}
