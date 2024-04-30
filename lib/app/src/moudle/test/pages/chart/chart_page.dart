import 'dart:math';

import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/double/double_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/single/single_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/special/special_page.dart';
import 'package:dinosaur/app/src/moudle/test/weight/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_controller.dart';
import 'package:flutter/widgets.dart';

import '../play/weight/curved_indicator.dart';

class ChartPage extends BaseEmptyPage<ChartController>
    implements SingleTickerProviderStateMixin {
  const ChartPage({super.key});
  @override
  bool get canPopBack => false;
  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
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
              centerTitle: false,
              backgroundColor: MyColors.pageBgColor,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              title: ScaleTabBar(
                controller: tabController,
                isScrollable: true,
                unselectedLabelColor: MyColors.indicatorNormalTextColor,
                labelColor:MyColors.indicatorSelectedTextColor ,
                unselectedLabelStyle: const TextStyle(
                    color: MyColors.indicatorNormalTextColor, fontSize: SizeConfig.titleTextScaleSize),
                labelStyle: const  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.indicatorSelectedTextColor,
                    fontSize: SizeConfig.titleTextDefaultSize),
                indicator: CurvedIndicator(),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                tabs: const [
                  Tab(
                    text: '单震',
                  ),
                  Tab(
                    text: '双震',
                  ),
                  Tab(
                    text: '允吸',
                  )
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              controller: tabController,
              children: [
                SinglePage(controller: controller),
                DoublePage(controller: controller),
                SpecialPage(controller: controller),
              ],
            ),
          ),
        ),
      ],
    );
  }





  @override
  void activate() {
  }

  @override
  BuildContext get context => throw UnimplementedError();

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  @override
  void deactivate() {
  }

  @override
  void didChangeDependencies() {
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
  }

  @override
  void dispose() {
  }

  @override
  void initState() {
  }

  @override
  bool get mounted => throw UnimplementedError();

  @override
  void reassemble() {
  }

  @override
  void setState(VoidCallback fn) {
  }

  @override
  StatefulWidget get widget => throw UnimplementedError();
}


