import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/common/common_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/dynamic/dynamic_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/handpick/hand_pick_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/refresh/refresh_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/weight/draggable_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../play/weight/curved_indicator.dart';

class PetPage extends BaseEmptyPage<PetController>
    implements SingleTickerProviderStateMixin {
  const PetPage({super.key});
  @override
  bool get canPopBack => false;
  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      controller.onPageChanged(tabController.index);
    });
    return Stack(
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
              title: TabBar(
                controller: tabController,
                automaticIndicatorColorAdjustment: true,
                tabAlignment: TabAlignment.start,
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
                splashFactory: NoSplash.splashFactory,
                dividerHeight: 0,
                labelPadding: EdgeInsets.symmetric(horizontal: 6),
                overlayColor:
                    const MaterialStatePropertyAll<Color>(Colors.transparent),
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

  @override
  void activate() {}

  @override
  BuildContext get context => throw UnimplementedError();

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {}

  @override
  void dispose() {}

  @override
  void initState() {}

  @override
  bool get mounted => throw UnimplementedError();

  @override
  void reassemble() {}

  @override
  void setState(VoidCallback fn) {}

  @override
  StatefulWidget get widget => throw UnimplementedError();
}
