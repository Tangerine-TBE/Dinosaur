import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/friend/fri_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/msg/msg_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/notify/notify_page.dart';
import 'package:dinosaur/app/src/moudle/test/weight/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../play/weight/curved_indicator.dart';

class MessagePage extends BaseEmptyPage<MessageController>
      {
  const MessagePage({super.key});
  @override
  bool get canPopBack => false;
  @override
  Widget buildContent(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (context) {
        final tabController = DefaultTabController.of(context);
        tabController.addListener(() {
            controller.onPageChanged(tabController.index);
        });
      return  Stack(
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
                  actions: [
                    Container(
                      padding: EdgeInsets.only(
                        right: 20,
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.onSearchClicked();
                        },
                        child: FaIcon(
                          FontAwesomeIcons.userPlus,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                  title: ScaleTabBar(
                    isScrollable: true,
                    unselectedLabelColor: MyColors.indicatorNormalTextColor,
                    labelColor:MyColors.indicatorSelectedTextColor ,
                    unselectedLabelStyle: TextStyle(
                        color: MyColors.indicatorNormalTextColor,
                        fontSize: SizeConfig.titleTextScaleSize),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.indicatorSelectedTextColor,
                        fontSize: SizeConfig.titleTextDefaultSize),
                    indicatorColor: MyColors.indicatorColor,
                    indicatorPadding: EdgeInsets.only(bottom: 10),
                    indicator: CurvedIndicator(),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(horizontal: 6),
                    tabs: const [
                      Tab(
                        text: '消息',
                      ),
                      Tab(
                        text: '好友',
                      ),
                      Tab(
                        text: '通知',
                      ),
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: TabBarView(
                  children: [
                    MsgPage(
                      controller: controller,
                    ),
                    FriPage(
                      controller: controller,
                    ),
                    NotifyPage(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
