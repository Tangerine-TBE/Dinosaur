import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:app_base/util/image.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:dinosaur/app/src/moudle/test/device/run_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/weight/curved_indicator.dart';
import 'package:get/get.dart';

import '../../weight/loadmore_listview.dart';

class PlayPage extends BaseEmptyPage<PlayController> {
  const PlayPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

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
              preferredSize: Size.fromHeight(64),
              child: AppBar(
                backgroundColor: MyColors.pageBgColor,
                automaticallyImplyLeading: false,
                elevation: 0.0,
                title: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      unselectedLabelStyle: TextStyle(
                          color: MyColors.indicatorNormalTextColor,
                          fontSize: 16),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.indicatorSelectedTextColor,
                          fontSize: 18),
                      indicatorColor: MyColors.indicatorColor,
                      indicatorPadding: EdgeInsets.only(bottom: 10),
                      indicator: CurvedIndicator(),
                      indicatorSize: TabBarIndicatorSize.label,
                      splashFactory: NoSplash.splashFactory,
                      dividerHeight: 0,
                      labelPadding: EdgeInsets.symmetric(horizontal: 6),
                      overlayColor: const MaterialStatePropertyAll<Color>(
                          Colors.transparent),
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
                _buildFra1Content(
                    controller.onScanClicked,
                    controller.onSideItClicked,
                    controller.onShakeItClicked,
                    controller.onModelClicked),
                _buildFra2Content(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildFra1Content(Function onScanCall, Function onSideCall,
      Function onShakeCall, Function onModelCall) {
    return LoadMoreListView.customScrollView(
      onLoadMore: controller.playSelfContentManager.loaMoreList,
      loadMoreWidget: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
        ),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 282,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 26,
                        child: GestureDetector(
                          onTap: () {
                            onScanCall.call();
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
                          () => Text(
                            Runtime.deviceInfo.value == null
                                ? '点我\r\n连接设备哦'
                                : '\r\n${Runtime.deviceInfo.value!.bluetoothDevice.platformName}\r\n已链接',
                            style: TextStyle(
                              fontSize: 12,
                              color: MyColors.textBlackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(2, 2),
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
                                    Text(
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
                                    Text(
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
                          child: Center(
                            child: LoadingAnimationWidget.newtonCradle(
                              color: MyColors.homePageNaviItemSelectColor,
                              size: 100,
                            ),
                          ),
                        )
                      : const SliverFillRemaining(
                          child: NoDataWidget(),
                        );
            },
            id: controller.playSelfContentManager.dataListId,
          ),
        )
      ],
    );
  }

  _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _centerItem(
          controller.playSelfContentManager.dataList[index],
          () {
            controller.onCenterDetailsIndexTap(
              controller.playSelfContentManager.dataList[index],
            );
          },
        );
      }, childCount: controller.playSelfContentManager.dataList.length
          // childCount: controller.dataList.length,
          ),
    );
  }

  _centerItem(TopicList bean, Function onPress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 70,
      child: InkWell(
        onTap: (){
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
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      bean.subtitle,
                      style: TextStyle(
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
                              style: TextStyle(
                                  fontSize: 11, color: MyColors.textGreyColor),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Text(
                              bean.deletedTime,
                              style: TextStyle(
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

  _buildFra2Content() {
    return Column(
      children: [
        Image.asset(
          ResName.group38,
          width: 223,
          height: 223,
        ),
        Text(
          '点击\r\n分享遥控',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColors.textBlackColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 42,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GetBuilder<PlayController>(
              builder: (controller) {
                return Wrap(
                  runSpacing: 16,
                  spacing: 24,
                  children: controller.remoteControlContentManager.shareData
                      .map<Widget>((e) => _buildWrapChild(e.assetName, e.text))
                      .toList(),
                );
              },
            ),
          ),
        ),
        Text(
          '互动需双方同时链接，离开此界面自动将断开',
          style: TextStyle(
            fontSize: 11,
            color: MyColors.textGreyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
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
}
