import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/pages/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/pages/play/play_page.dart';
import 'package:test01/app/src/pages/test/test_pages.dart';

class HomePage extends BaseEmptyPage<HomeController> {
  const HomePage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Offstage(
                  offstage: !(controller.selectedTabIndex.value == 0),
                  child: const PlayPage(),
                ),
                Offstage(
                  offstage: !(controller.selectedTabIndex.value == 1),
                  child: const TestPages(),
                ),
                Offstage(
                  offstage: !(controller.selectedTabIndex.value == 2),
                  child:  Container(),
                ),
                Offstage(
                  offstage: !(controller.selectedTabIndex.value == 3),
                  child: Container(),
                ),
              ],
            ),
          ),
          _getButtonNavigationBar(),
        ],
      ),
    );
  }

  BottomNavigationBar _getButtonNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: MyColors.homePageNaviBgColor,
      selectedFontSize: 11.sp,
      unselectedFontSize: 11.sp,
      elevation: 0,
      unselectedItemColor: MyColors.homePageNaviItemNormalColor,
      selectedItemColor: MyColors.homePageNaviItemSelectColor,
      type: BottomNavigationBarType.fixed,
      items: [
        _getNaviBarItem(
          '玩耍',
          ResName.buttonNaviIconHomeHL,
          ResName.buttonNaviIconHome,
        ),
        _getNaviBarItem(
          '波形',
          ResName.buttonNaviIconBookingHL,
          ResName.buttonNaviIconBooking,
        ),
        _getNaviBarItem(
          '怪兽圈',
          ResName.buttonNaviIconMsgHL,
          ResName.buttonNaviIconMsg,
        ),
        _getNaviBarItem(
          '消息',
          ResName.buttonNaviIconMeHL,
          ResName.buttonNaviIconMe,
        ),
      ],
      currentIndex: controller.selectedTabIndex.value,
      onTap: (index) {
        controller.selectedTabIndex.value = index;
      },
    );
  }

  BottomNavigationBarItem _getNaviBarItem(
    String title,
    String highlightIcon,
    String icon,
  ) {
    return BottomNavigationBarItem(
      activeIcon: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Image.asset(
          highlightIcon,
          width: 16.w,
          height: 16.w,
        ),
      ),
      icon: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Image.asset(
          icon,
          width: 16.w,
          height: 16.w,
        ),
      ),
      label: title,
    );
  }
}
