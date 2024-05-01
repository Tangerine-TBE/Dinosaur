import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/common/common_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/dynamic/dynamic_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/handpick/hand_pick_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/refresh/refresh_page.dart';
import 'package:dinosaur/app/src/moudle/test/weight/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../play/weight/curved_indicator.dart';
class PetPage extends StatefulWidget {
  const PetPage({super.key});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> with SingleTickerProviderStateMixin{
  late  TabController tabController;
  late PetController controller;
  @override
  void initState() {
    controller = Get.find<PetController>();
     tabController = TabController(length: 4, vsync: this,initialIndex: controller.currentIndex);
     tabController.addListener(() {
      controller.onPageChanged(tabController.index);
    });
    super.initState();
  }
  @override
  void dispose() {
    tabController.dispose();
    controller.refreshManager.refreshController.dispose();
    controller.commonManager.refreshController.dispose();
    controller.handPickManager.refreshController.dispose();
    controller.dynamicManager.refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      Stack(
        key: const PageStorageKey<String>(RouteName.petPage),
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.bgLinearShapeColor1,
                MyColors.bgLinearShapeColor2,
              ], begin: Alignment.topCenter, end: Alignment.center),
            ),
          ),
          Scaffold(
            backgroundColor: MyColors.pageBgColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                backgroundColor: MyColors.pageBgColor,
                automaticallyImplyLeading: false,
                centerTitle: false,
                elevation: 0.0,
                title: ScaleTabBar(
                  controller: tabController,
                  unselectedLabelColor: MyColors.indicatorNormalTextColor,
                  labelColor:MyColors.indicatorSelectedTextColor ,
                  isScrollable: true,
                  unselectedLabelStyle: const TextStyle(
                      color: MyColors.indicatorNormalTextColor, fontSize: SizeConfig.titleTextScaleSize),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.indicatorSelectedTextColor,
                      fontSize: SizeConfig.titleTextDefaultSize),
                  indicator: CurvedIndicator(),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 10),
                  labelPadding: EdgeInsets.symmetric(horizontal: 6),
                  tabs: const [
                    Tab(
                      text: '推荐',
                    ),
                    Tab(
                      text: '精选',
                    ),
                    Tab(
                      text: '动态',
                    ),
                    Tab(
                      text: '最新',
                    )
                  ],
                ),
                actions: [
                  Container(
                    width: 80,
                    height: 30,
                    margin: EdgeInsets.only(right: 20),
                    child: MaterialButton(
                      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: MyColors.themeTextColor,
                      onPressed: () {
                        // controller.commonManager.showTipDialog();
                        controller.naviToPush();
                      },
                      child: const Text('发布'),
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                controller: tabController,
                children: [
                  CommonPage(
                    controller: controller,
                  ),
                  HandPickPage(
                    controller: controller,
                  ),
                  DynamicPage(
                    controller: controller,
                  ),
                  RefreshPage(
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }

}

