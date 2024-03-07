import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/pages/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends BaseEmptyPage<HomeController> {
  const HomePage({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Navigator(
            key: Get.nestedKey(1),
            initialRoute: RouteName.playPage,
            onGenerateRoute: controller.onGenerateRoute,
          ),
        ),
      ],
    );
  }

  @override
  Widget? buildBottomNavigation() {
    return Obx(
      () => _getButtonNavigationBar(),
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
        if (index == 0) {
          Get.toNamed(RouteName.playPage, id: 1);
        } else if (index == 1) {
          Get.toNamed(RouteName.testPage, id: 1);
        } else if (index == 2) {
          Get.toNamed(RouteName.test1Page, id: 1);
        } else {
          Get.toNamed(RouteName.test2Page, id: 1);
        }
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
