import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:app_base/util/image.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:app_base/widget/listview/smart_load_more_listview.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:dinosaur/app/src/moudle/test/device/run_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/weight/curved_indicator.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../weight/my_tabs.dart';

class PlayPage extends BaseEmptyPage<PlayController> {
  const PlayPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
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
              preferredSize: const Size.fromHeight(64),
              child: AppBar(
                backgroundColor: MyColors.pageBgColor,
                automaticallyImplyLeading: false,
                elevation: 0.0,
                title: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ScaleTabBar(
                      isScrollable: true,
                      unselectedLabelStyle: const TextStyle(
                          color: MyColors.indicatorNormalTextColor,
                          fontSize: SizeConfig.titleTextScaleSize),
                      unselectedLabelColor: MyColors.indicatorNormalTextColor,
                      labelColor: MyColors.indicatorSelectedTextColor,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.indicatorSelectedTextColor,
                          fontSize: SizeConfig.titleTextDefaultSize),
                      indicatorColor: MyColors.indicatorColor,
                      indicatorPadding: const EdgeInsets.only(bottom: 10),
                      indicator: CurvedIndicator(),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      tabs: const [
                        Tab(
                          text: '自己玩',
                        ),
                        Tab(
                          text: '远程遥控',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                ContentFra1(
                  controller: controller,
                ),
                ContentFra2(
                  controller: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentFra1 extends StatefulWidget {
  final PlayController controller;

  const ContentFra1({
    super.key,
    required this.controller,
  });

  @override
  State<ContentFra1> createState() => _ContentFra1State();
}

class _ContentFra1State extends State<ContentFra1>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    PlayController controller = widget.controller;
    return SmartRefresher(
      controller: controller.playSelfContentManager.refreshController,
      onRefresh: controller.playSelfContentManager.fetchTopCenterList,
      enablePullDown: true,
      header: WaterDropHeader(
        refresh: SizedBox(
          width: 25.0,
          height: 25.0,
          child: defaultTargetPlatform == TargetPlatform.iOS
              ? CupertinoActivityIndicator(
            color: MyColors.themeTextColor,
          )
              : CircularProgressIndicator(
              strokeWidth: 2.0, color: MyColors.themeTextColor),
        ),
        failed: Text('加载失败'),
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.done,
              color: Colors.black,
            ),
            Container(
              width: 15.0,
            ),
            const Text(
              '刷新完成',
              style: TextStyle(color: MyColors.textBlackColor),
            )
          ],
        ),
        waterDropColor: MyColors.themeTextColor,
      ),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("上拉加载");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("加载失败！点击重试！");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("松手,加载更多!");
          } else {
            body = Text("没有更多数据了!");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      child: CustomScrollView(
        key: const PageStorageKey<String>(RouteName.playPage),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 282,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        GestureDetector(
                        onTap: (){
                          controller.onScanClicked();
                        },
                          child: Stack(children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 26,
                              child: GestureDetector(
                                onTap: () {
                                  controller.onScanClicked();
                                },
                                child: Image.asset(
                                  ResName.iconImg,
                                  width: 150,
                                  height: 176,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 49,
                              top: 50,
                              child: Obx(
                                    () =>
                                    Text(
                                      Runtime.deviceInfo.value == null
                                          ? '点我\r\n连接设备哦'
                                          : '\r\n${Runtime.deviceInfo.value!
                                          .bluetoothDevice
                                          .platformName}\r\n已链接',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: MyColors.textBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              ),
                            ),
                          ],),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: MyColors.cardViewBgColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  )
                                ]),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.onSideItClicked();
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ResName.iconSide,
                                        width: 46,
                                        height: 46,
                                      ),
                                      const Text(
                                        '划一划',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.textBlackColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.onShakeItClicked();
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ResName.iconShake,
                                        width: 46,
                                        height: 46,
                                      ),
                                      const Text(
                                        '摇一摇',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.textBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.onModelClicked();
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ResName.iconModel,
                                        width: 46,
                                        height: 46,
                                      ),
                                      Text(
                                        '模式',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.textBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '话题中心',
                      style: TextStyle(
                          color: MyColors.textBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: GetBuilder<PlayController>(
              builder: (controller) {
                return controller.playSelfContentManager.dataList.isNotEmpty
                    ? _buildSliverList()
                    : controller.playSelfContentManager.refreshing
                    ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: LoadingAnimationWidget.newtonCradle(
                      color: MyColors.homePageNaviItemSelectColor,
                      size: 100,
                    ),
                  ),
                )
                    : const SliverFillRemaining(
                  hasScrollBody: false,
                  child: NoDataWidget(),
                );
              },
              id: controller.playSelfContentManager.dataListId,
            ),
          )
        ],
      ),
    );
  }

  _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return _centerItem(
            widget.controller.playSelfContentManager.dataList[index],
                () {
              widget.controller.onCenterDetailsIndexTap(
                widget.controller.playSelfContentManager.dataList[index],
              );
            },
          );
        },
        childCount: widget.controller.playSelfContentManager.dataList.length,
        // childCount: controller.dataList.length,
      ),
    );
  }

  _centerItem(TopicList bean, Function onPress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 70,
      child: InkWell(
        onTap: () {
          onPress.call();
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: loadImage(bean.imageUrl, 64, 64),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bean.title,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      bean.subtitle,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              bean.subtitle,
                              style: const TextStyle(
                                  fontSize: 11, color: MyColors.textGreyColor),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Text(
                              bean.deletedTime,
                              style: const TextStyle(
                                  fontSize: 11, color: MyColors.textGreyColor),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ContentFra2 extends StatefulWidget {
  final PlayController controller;

  const ContentFra2({super.key, required this.controller});

  @override
  State<ContentFra2> createState() => _ContentFra2State();
}

class _ContentFra2State extends State<ContentFra2>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Image.asset(
                ResName.group38,
                width: 223,
                height: 223,
              ),
              const Text(
                '点击\r\n分享遥控',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GetBuilder<PlayController>(
                  builder: (controller) {
                    return Wrap(
                      runSpacing: 16,
                      spacing: 16,
                      children: controller.remoteControlContentManager.shareData
                          .map<Widget>(
                              (e) => _buildWrapChild(e.assetName, e.text))
                          .toList(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '互动需双方同时链接，离开此界面自动将断开',
                style: TextStyle(
                  fontSize: 11,
                  color: MyColors.textGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildWrapChild(String assetPath, String text) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [
              const Color(0xffff5e65),
              const Color(0xffFF5E65).withAlpha(54),
              const Color(0xffD8D8D8).withAlpha(0),
            ],
            begin: Alignment.center,
            end: Alignment.centerRight,
            transform: const GradientRotation(1.2),
          ),
        ),
        child: FittedBox(
          child: Row(
            children: [
              Image.asset(
                assetPath,
                width: 22,
                height: 22,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
