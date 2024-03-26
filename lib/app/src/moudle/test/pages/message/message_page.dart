import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/friend/fri_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/msg/msg_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/notify/notify_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../play/weight/curved_indicator.dart';

class MessagePage extends BaseEmptyPage<MessageController>
    implements SingleTickerProviderStateMixin {
  const MessagePage({super.key});

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
              backgroundColor: MyColors.pageBgColor,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              actions: [
                Container(
                  padding: EdgeInsets.only(
                    right: 20.w,
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.onSearchClicked();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.userPlus,
                      size: 16.w,
                    ),
                  ),
                ),
              ],
              title: TabBar(
                controller: tabController,
                automaticIndicatorColorAdjustment: true,
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                unselectedLabelStyle: TextStyle(
                    color: MyColors.indicatorNormalTextColor,
                    fontSize: 16.sp),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.indicatorSelectedTextColor,
                    fontSize: 18.sp),
                indicatorColor: MyColors.indicatorColor,
                indicatorPadding: EdgeInsets.only(bottom: 10.h),
                indicator: CurvedIndicator(),
                indicatorSize: TabBarIndicatorSize.label,
                splashFactory: NoSplash.splashFactory,
                dividerHeight: 0,
                labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
                overlayColor:
                    const MaterialStatePropertyAll<Color>(Colors.transparent),
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
              controller: tabController,
              children: [
                MsgPage(
                  messageController: controller,
                ),
                FriPage(
                  messageController: controller,
                ),
                NotifyPage(),
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
