import 'package:app_base/exports.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/app.dart';
import '../sideIt/widget/charts_painter.dart';
import 'model_controller.dart';

class ModelPage extends BaseEmptyPage<ModelController> implements SingleTickerProviderStateMixin{
  const ModelPage({super.key});

  @override
  Color get background => Colors.white;

  @override
  Widget buildContent(BuildContext context) {
    return _buildContent02();
  }

  _buildContent02() {
    TabController tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      controller.currentModelPage.value = tabController.index;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.pageBgColor,
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
        ),
        title: TabBar(
          controller: tabController,
            dividerHeight: 0,
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            indicatorPadding: EdgeInsets.only(left: 22.w, right: 22.w),
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.all(
                Radius.circular(2.w),
              ),
              borderSide: BorderSide(
                width: 4.h,
                color: Color(0xffFF5E65),
              ),
            ),
            unselectedLabelStyle:
                TextStyle(color: Colors.white, fontSize: 18.sp),
            splashFactory: NoSplash.splashFactory,
            overlayColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.scanIndicatorTextSelectedColor,
                fontSize: 18.sp),
            tabs: [
              Tab(
                text: '经典模式',
              ),
              Tab(
                text: '我的模式',
              )
            ]),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffFF676D), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.3]),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        child: _buildContentClassic01(),
                      ),
                      Container(
                        child: _buildContentMine01(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: _buildBottomBar(),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomBar() {
    return Column(
      children: [
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 2.h),
            child: RepaintBoundary(
              child: CustomPaint(
                size: Size(280.w, 60.h),
                painter: ChartsPainter(
                    process: controller.process.value.obx, processMax: 1023),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              height: 75.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      controller.onLastClick();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      child: Image.asset(
                        ResName.playerBack,
                        width: 36.w,
                        height: 36.w,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onPlayClick();
                    },
                    child: Obx(
                      () => controller.playModel.value
                          ? Image.asset(
                              ResName.buttonL,
                              width: 64.w,
                              height: 64.w,
                            )
                          : Image.asset(
                              ResName.buttonR,
                              width: 64.w,
                              height: 64.w,
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.onNextClick();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      child: Image.asset(
                        ResName.playerSkip,
                        width: 36.w,
                        height: 36.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildContent01() {
    return Scaffold(
      backgroundColor: MyColors.pageBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        backgroundColor: MyColors.pageBgColor,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 280.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ResName.imgWdmsBg), fit: BoxFit.fill),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 33,
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 48.w, vertical: 90.h),
                          child: RepaintBoundary(
                            child: CustomPaint(
                              size: Size(280.w, 70.h),
                              painter: ChartsPainter(
                                  process: controller.process.value.obx,
                                  processMax: 1023),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60.h,
                      left: 26.w,
                      child: Obx(() => GestureDetector(
                            onTap: () {
                              controller.changePage(0);
                            },
                            child: Container(
                              width: 136.w,
                              height: 50.h,
                              decoration: controller.currentModelPage.value == 0
                                  ? BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.pink, width: 2.w),
                                      borderRadius: BorderRadius.circular(25.w),
                                    )
                                  : BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(25.w),
                                    ),
                              alignment: Alignment.center,
                              child: Text(
                                '经典模式',
                                style: controller.currentModelPage.value == 0
                                    ? const TextStyle(
                                        color: Colors.pink,
                                      )
                                    : const TextStyle(
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      bottom: 60.h,
                      right: 26.w,
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.changePage(1);
                          },
                          child: Container(
                            width: 136.w,
                            height: 50.h,
                            decoration: controller.currentModelPage.value == 1
                                ? BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.pink, width: 2.w),
                                    borderRadius: BorderRadius.circular(25.w),
                                  )
                                : BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(25.w),
                                  ),
                            alignment: Alignment.center,
                            child: Text(
                              '我的模式',
                              style: controller.currentModelPage.value == 1
                                  ? const TextStyle(
                                      color: Colors.pink,
                                    )
                                  : const TextStyle(
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -1,
                right: 0,
                left: 0,
                child: Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(42.h),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              // controller: controller.pageController,
              children: [
                _buildContentClassic(),
                _buildContentMine(),
              ],
            ),
          ),
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ResName.imgBgBfq), fit: BoxFit.fill),
            ),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 26.h),
            child: SizedBox(
              width: double.infinity,
              height: 75.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    ResName.iconShake1,
                    width: 16.w,
                    height: 16.w,
                  ),
                  InkWell(
                    onTap: () {
                      controller.onLastClick();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      child: Image.asset(
                        ResName.iconLeft,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onPlayClick();
                    },
                    child: Obx(
                      () => controller.playModel.value
                          ? Image.asset(
                              ResName.iconZt,
                              width: 75.w,
                              height: 75.w,
                            )
                          : Image.asset(
                              ResName.iconBf,
                              width: 75.w,
                              height: 75.w,
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.onNextClick();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      child: Image.asset(
                        ResName.iconRight,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                  ),
                  Image.asset(
                    ResName.iconXhbf,
                    width: 16.w,
                    height: 16.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildContentClassic01() {
    var mainAxisAlignment = MainAxisAlignment.spaceBetween;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(0),
                _buildTemplateModelItem(1),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(2),
                _buildTemplateModelItem(3),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(4),
                _buildTemplateModelItem(5),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(6),
                _buildTemplateModelItem(7),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(8),
                _buildTemplateModelItem(9),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(10),
                _buildTemplateModelItem(11),
              ],
            ),
          ],
        ),
      ),
    );
  }
  _buildContentMine01() {
    return GetBuilder<ModelController>(builder: (controller) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 20.w,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h),
        childAspectRatio: 2,
        children: List.generate(
          controller.mRecordBean.dataList.length,
              (index) => _buildCustomModelItem01(
              controller.mRecordBean.dataList[index].recordName, index),
        ),
      );
    },id: controller.customPageId,);
  }
  _buildContentClassic() {
    var mainAxisAlignment = MainAxisAlignment.spaceBetween;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(0),
                _buildTemplateModelItem(1),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(2),
                _buildTemplateModelItem(3),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(4),
                _buildTemplateModelItem(5),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(6),
                _buildTemplateModelItem(7),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(8),
                _buildTemplateModelItem(9),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(10),
                _buildTemplateModelItem(11),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
          ],
        ),
      ),
    );
  }



  _buildContentMine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: controller.mRecordBean.dataList.length > 0
              ? Obx(
                  () => Column(
                    children: List.generate(
                      controller.mRecordBean.dataList.length,
                      (index) => _buildCustomModelItem(
                          controller.mRecordBean.dataList[index].recordName,
                          index),
                    ),
                  ),
                )
              : Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: NoDataWidget(
                    title: '暂无记录',
                  ),
                ),
        );
      },
    );
  }

  _buildCustomModelItem01(String name, int index) {
    var isSelect = false;
    if (controller.currentCustomModel.value == index) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    return GestureDetector(
      onTap: () {
        controller.onCustomModelClick(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: !isSelect?Color(0xffFFD5D7):Color(0xffFF5E65),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ResName.path25,
              width: 69.w,
              height: 42.h,
              color: isSelect?Colors.white:Color(0xffFF5E65),
            ),
            SizedBox(
              width: 11.w,
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isSelect?Colors.white:Color(0xffFF5E65),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCustomModelItem(String name, int index) {
    var isSelect = false;
    if (controller.currentCustomModel.value == index) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    return GestureDetector(
      onTap: () {
        controller.onCustomModelClick(index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 60.w,
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              !isSelect ? ResName.iconBtMr : ResName.iconBtBf,
              width: 60.w,
              height: 60.w,
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateModelItem(int index) {
    AssetImage normal;
    var isSelect = false;
    if (controller.currentClassicModel.value == index) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    if (!isSelect) {
      switch (index) {
        case 0:
          normal = const AssetImage(ResName.imgNDycx);
          break;
        case 1:
          normal = const AssetImage(ResName.imgNQymm);
          break;
        case 2:
          normal = const AssetImage(ResName.imgNRyds);
          break;
        case 3:
          normal = const AssetImage(ResName.imgNYfrh);
          break;
        case 4:
          normal = const AssetImage(ResName.imgNNgsh);
          break;
        case 5:
          normal = const AssetImage(ResName.imgNQsyh);
          break;
        case 6:
          normal = const AssetImage(ResName.imgNMlmh);
          break;
        case 7:
          normal = const AssetImage(ResName.imgBYbbn);
          break;
        case 8:
          normal = const AssetImage(ResName.imgNKlwj);
          break;
        case 9:
          normal = const AssetImage(ResName.imgNYszh);
          break;
        case 10:
          normal = const AssetImage(ResName.imgNXhnf);
          break;
        case 11:
          normal = const AssetImage(ResName.imgNGdck);
          break;
        default:
          normal = const AssetImage(ResName.imgNDycx);
          break;
      }
    } else {
      switch (index) {
        case 0:
          normal = const AssetImage(ResName.imgYDycx);
          break;
        case 1:
          normal = const AssetImage(ResName.imgYQymm);
          break;
        case 2:
          normal = const AssetImage(ResName.imgYRyds);
          break;
        case 3:
          normal = const AssetImage(ResName.imgYYfrh);
          break;
        case 4:
          normal = const AssetImage(ResName.imgYNqsh);
          break;
        case 5:
          normal = const AssetImage(ResName.imgYQsyh);
          break;
        case 6:
          normal = const AssetImage(ResName.imgYMlmh);
          break;
        case 7:
          normal = const AssetImage(ResName.imgYYbbn);
          break;
        case 8:
          normal = const AssetImage(ResName.imgYKlwj);
          break;
        case 9:
          normal = const AssetImage(ResName.imgYYszh);
          break;
        case 10:
          normal = const AssetImage(ResName.imgYXhnf);
          break;
        case 11:
          normal = const AssetImage(ResName.imgYGdck);
          break;
        default:
          normal = const AssetImage(ResName.imgYDycx);
          break;
      }
    }

    return GestureDetector(
      onTap: () {
        controller.onClassicItemClick(index);
      },
      child: Container(
        width: 144.w,
        height: 83.h,
        decoration: BoxDecoration(
          image: DecorationImage(image: normal),
        ),
      ),
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
