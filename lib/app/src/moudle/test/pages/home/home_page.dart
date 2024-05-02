import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/mine_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/play_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../chart/chart_page.dart';
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
        // child: Obx(
        //   () => Stack(
        //     children: [
        //       Offstage(
        //         offstage: !(controller.selectedTabIndex.value == 0),
        //         child: const PlayPage(),
        //       ),
        //       Offstage(
        //         offstage: !(controller.selectedTabIndex.value == 1),
        //         child: const ChartPage(),
        //       ),
        //       Offstage(
        //         offstage: !(controller.selectedTabIndex.value == 2),
        //         child: const PetPage(),
        //       ),
        //       Offstage(
        //         offstage: !(controller.selectedTabIndex.value == 3),
        //         child: const MessagePage(),
        //       ),
        //       Offstage(
        //         offstage: !(controller.selectedTabIndex.value == 4),
        //         child: const MinePage(),
        //       ),
        //     ],
        //   ),
        // ),
        child: PageView(children: [
          const PlayPage(),
          const ChartPage(),
          const PetPage(),
          const MessagePage(),
          const MinePage(),
        ],
        onPageChanged: (index){
          logE('${index}');
        },
        controller: controller.pageController,
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
          controller.pageController.jumpToPage(index);
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
