import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/weight/curved_indicator.dart';
import 'package:get/get.dart';
import 'package:loadmore_listview/loadmore_listview.dart';

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
              preferredSize: Size.fromHeight(64.h),
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
                      padding: EdgeInsets.only(left: 20.w),
                      labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
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
        margin: EdgeInsets.all(20.w),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
        ),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 282.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 26.h,
                        child: GestureDetector(
                          onTap: () {
                            onScanCall.call();
                          },
                          child: Image.asset(
                            ResName.iconImg,
                            width: 150.w,
                            height: 176.h,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 49.w,
                        top: 50.h,
                        child: Obx(
                          () => Text(
                            controller.manager.mDevice.value == null
                                ? '点我\r\n连接设备哦'
                                : '\r\n${controller.manager.mDevice.value!.platformName}\r\n已链接',
                            style: TextStyle(
                              fontSize: 12.sp,
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
                          height: 100.h,
                          decoration: BoxDecoration(
                              color: MyColors.cardViewBgColor,
                              borderRadius: BorderRadius.circular(8.w),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(2, 2),
                                  blurRadius: 4.h,
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
                                      width: 46.h,
                                      height: 46.h,
                                    ),
                                    Text(
                                      '划一划',
                                      style: TextStyle(
                                        fontSize: 14.sp,
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
                                      width: 46.h,
                                      height: 46.h,
                                    ),
                                    Text(
                                      '摇一摇',
                                      style: TextStyle(
                                        fontSize: 14.sp,
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
                                      width: 46.h,
                                      height: 46.h,
                                    ),
                                    Text(
                                      '模式',
                                      style: TextStyle(
                                        fontSize: 14.sp,
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
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '话题中心',
                    style: TextStyle(
                        color: MyColors.textBlackColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: GetBuilder<PlayController>(
            builder: (controller) {
              return controller.playSelfContentManager.dataList.isNotEmpty
                  ? _buildSliverList()
                  : controller.playSelfContentManager.refreshing
                      ? SliverFillRemaining(
                          child: Center(
                            child: LoadingAnimationWidget.newtonCradle(
                              color: MyColors.homePageNaviItemSelectColor,
                              size: 100.w,
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
      height: 70.h,
      child: InkWell(
        onTap: (){
          onPress.call();
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.h),
              child: Image.network(
                bean.icon,
                width: 64.h,
                height: 64.h,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bean.title,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      bean.subtitle,
                      style: TextStyle(
                          fontSize: 14.sp,
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
                                  fontSize: 11.sp, color: MyColors.textGreyColor),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Text(
                              bean.deletedTime,
                              style: TextStyle(
                                  fontSize: 11.sp, color: MyColors.textGreyColor),
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
          width: 223.w,
          height: 223.w,
        ),
        Text(
          '点击\r\n分享遥控',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColors.textBlackColor,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(
          height: 42.h,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GetBuilder<PlayController>(
              builder: (controller) {
                return Wrap(
                  runSpacing: 16.h,
                  spacing: 24.w,
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
            fontSize: 11.sp,
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
        borderRadius: BorderRadius.circular(14.w),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.w),
          gradient: LinearGradient(
            colors: [
              const Color(0xffff5e65),
              const Color(0xffFF5E65).withAlpha(54),
              const Color(0xffD8D8D8).withAlpha(0),
            ],
            begin: Alignment.center,
            end: Alignment.centerRight,
            transform: GradientRotation(1.2),
          ),
        ),
        child: FittedBox(
          child: Row(
            children: [
              Image.asset(
                assetPath,
                width: 22.w,
                height: 22.w,
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
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
