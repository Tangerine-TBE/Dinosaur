import 'dart:async';

import 'package:app_base/exports.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:test01/app/src/pages/play/play_fra1_page.dart';
import 'package:test01/app/src/pages/play/play_fra2_page.dart';

class PlayPage extends BaseEmptyPage {
  const PlayPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: MyColors.pageBgColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: MyColors.pageBgColor,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TabBar(
                  isScrollable: true,
                  unselectedLabelStyle: TextStyle(
                      color: MyColors.indicatorNormalTextColor, fontSize: 16),
                  labelStyle: TextStyle(
                      color: MyColors.indicatorSelectedTextColor, fontSize: 24),
                  indicatorColor: MyColors.indicatorColor,
                  indicatorPadding: EdgeInsets.only(bottom: 5),
                  indicatorSize: TabBarIndicatorSize.label,
                  splashFactory: NoSplash.splashFactory,
                  dividerHeight: 0,
                  overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                  indicatorWeight: 1,
                  tabs: [
                    Tab(
                      text: '自己玩',
                    ),
                    Tab(
                      text: '远程遥控',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            PlayFra1Page(),
            PlayFra2Page(),
          ],
        ),
      ),
    );
  }
}
