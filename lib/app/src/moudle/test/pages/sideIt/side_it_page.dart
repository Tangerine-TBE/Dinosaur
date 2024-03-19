import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/side_it_controller.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/image_slider_thumb.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/widget/timer_count_down.dart';

import 'widget/charts_painter.dart';

class SideItPage extends BaseEmptyPage<SideItController> {
  const SideItPage({super.key});

  @override
  Color get background => Colors.white;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget buildContent(BuildContext context) {
    return _buildContent02();
  }

  _buildContent01() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 260.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ResName.imgWdmsBg), fit: BoxFit.fill),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(horizontal: 48.w),
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
              ),
              Positioned(
                bottom: 0,
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
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    left: 30.w,
                    top: 50.h,
                    child: GestureDetector(
                      onTap: () {
                        controller.onClassicClick();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            ResName.iconWdms,
                            width: 100.w,
                            height: 100.w,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            '经典模式',
                            style: TextStyle(
                                color: MyColors.textBlackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30.w,
                    top: 50.h,
                    child: GestureDetector(
                      onTap: () {
                        controller.onSuperModelClick();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            ResName.iconYjbz,
                            width: 100.w,
                            height: 100.w,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            '一键暴走',
                            style: TextStyle(
                                color: MyColors.textBlackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: SizedBox(
                        height: 40.w,
                        width: 320.h,
                        child: FutureBuilder(
                          future: controller.loadImage(ResName.iconBt),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            return Listener(
                              onPointerDown: (_) {
                                controller.onSliverDown();
                              },
                              onPointerUp: (_) {
                                controller.onSliverUp();
                              },
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor:
                                      MyColors.sliderActiveTrackColor,
                                  inactiveTrackColor:
                                      MyColors.sliderInactiveTrackColor,
                                  trackShape:
                                      const RoundedRectSliderTrackShape(),
                                  trackHeight: 36.w,
                                  rangeTrackShape:
                                      const RoundedRectRangeSliderTrackShape(),
                                  thumbShape: snapshot.data == null
                                      ? const RoundSliderThumbShape(
                                          disabledThumbRadius: 20,
                                          enabledThumbRadius: 20)
                                      : ImageSliderThumb(
                                          image: snapshot.data,
                                          size: Size(60.w, 60.w)),
                                  overlayColor: Colors.red.withAlpha(32),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 28.0),
                                ),
                                child: Obx(
                                  () => Slider(
                                    value:
                                        controller.sliderValue.value.toDouble(),
                                    min: 0,
                                    max: 1023,
                                    secondaryActiveColor: Colors.white,
                                    activeColor:
                                        MyColors.sliderActiveTrackColor,
                                    onChanged: (value) {
                                      controller.onSliverProcessChanged(value);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30.w,
                    bottom: 50.h,
                    child: GestureDetector(
                      onTap: () {
                        controller.onCustomModelClick();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            ResName.iconCjms,
                            width: 100.w,
                            height: 100.w,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text('创建模式',
                              style: TextStyle(
                                  color: MyColors.textBlackColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30.w,
                    bottom: 50.h,
                    child: GestureDetector(
                      onTap: () {
                        controller.onPlayClick();
                      },
                      child: GestureDetector(
                        onTap: () {
                          controller.onPlayClick();
                        },
                        child: Obx(
                          () => !controller.play.value
                              ? Column(
                                  children: [
                                    Image.asset(
                                      ResName.iconDqxh,
                                      width: 100.w,
                                      height: 100.w,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                      '开始享受',
                                      style: TextStyle(
                                          color: MyColors.textBlackColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Image.asset(
                                      ResName.iconXh,
                                      width: 100.w,
                                      height: 100.w,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                      '休息一下',
                                      style: TextStyle(
                                          color: MyColors.textBlackColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: Obx(
              () => Visibility(
                visible: controller.slideItModel.value == 1,
                child: Countdown(
                  seconds: 10,
                  controller: controller.countdownController,
                  onFinished: () {
                    controller.onCountDownFinish();
                  },
                  build: (context, double time) {
                    return Text(
                      time.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    );
                  },
                  buildPause: (context) {
                    return Text(
                      '请滑动滑条',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    );
                  },
                  interval: const Duration(milliseconds: 100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildContent02() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          '划一划',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: MyColors.pageBgColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffFF676D), Colors.white],
                  begin: Alignment.topCenter),
            ),
          ),
          Column(
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.onClassicClick();
                              },
                              child: Row(
                                children: [
                                  Card(
                                    shape: const CircleBorder(),
                                    color: Colors.red,
                                    elevation: 6,
                                    child: Container(
                                      padding: EdgeInsets.all(18.w),
                                      child: Image.asset(
                                        ResName.magic_star,
                                        width: 28.w,
                                        color: Colors.white,
                                        height: 28.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Text(
                                    '经典模式',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.onSuperModelClick();
                              },
                              child: Row(
                                children: [
                                  Card(
                                    shape: const CircleBorder(),
                                    color: Colors.red,
                                    elevation: 6,
                                    child: Container(
                                      padding: EdgeInsets.all(18.w),
                                      child: Image.asset(
                                        ResName.flash,
                                        color: Colors.white,
                                        width: 28.w,
                                        height: 28.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Text(
                                    '一键暴走',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.onCustomModelClick();
                              },
                              child: Row(
                                children: [
                                  Card(
                                    shape: const CircleBorder(),
                                    color: Colors.red,
                                    elevation: 6,
                                    child: Container(
                                      padding: EdgeInsets.all(18.w),
                                      child: Image.asset(
                                        ResName.cloud_plus,
                                        color: Colors.white,
                                        width: 28.w,
                                        height: 28.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Text(
                                    '创建模式',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.onPlayClick();
                              },
                              child: Obx(
                                () => Row(
                                  children: [
                                    Card(
                                      shape: const CircleBorder(),
                                      color: controller.play.value
                                          ? Colors.grey
                                          : Colors.red,
                                      elevation: 6,
                                      child: Container(
                                        padding: EdgeInsets.all(18.w),
                                        child: Image.asset(
                                          ResName.moon,
                                          color: Colors.white,
                                          width: 28.w,
                                          height: 28.w,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16.w,
                                    ),
                                    Text(
                                      '休息一会',
                                      style: TextStyle(
                                        color: controller.play.value
                                            ? Colors.grey
                                            : Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: SizedBox(
                            height: double.infinity,
                            width: 420.h,
                            child: FutureBuilder(
                              future: controller.loadImage(ResName.button),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                return Listener(
                                  onPointerDown: (_) {
                                    controller.onSliverDown();
                                  },
                                  onPointerUp: (_) {
                                    controller.onSliverUp();
                                  },
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor:
                                          MyColors.sliderActiveTrackColor,
                                      inactiveTrackColor:
                                          MyColors.sliderInactiveTrackColor,
                                      trackShape:
                                          const RoundedRectSliderTrackShape(),
                                      trackHeight: 50.w,
                                      rangeTrackShape:
                                          const RoundedRectRangeSliderTrackShape(),
                                      thumbShape: snapshot.data == null
                                          ? const RoundSliderThumbShape(
                                              disabledThumbRadius: 20,
                                              enabledThumbRadius: 20)
                                          : ImageSliderThumb(
                                              image: snapshot.data,
                                              size: Size(80.w, 80.w)),
                                      overlayColor: Colors.red.withAlpha(32),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                              overlayRadius: 28.0),
                                    ),
                                    child: Obx(
                                      () => Slider(
                                        value: controller.sliderValue.value
                                            .toDouble(),
                                        min: 0,
                                        max: 1023,
                                        secondaryActiveColor: Colors.white,
                                        activeColor:
                                            MyColors.sliderActiveTrackColor,
                                        onChanged: (value) {
                                          controller
                                              .onSliverProcessChanged(value);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Obx(
                            () => RepaintBoundary(
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
                      Obx(
                            () => Visibility(
                          visible: controller.slideItModel.value == 1,
                          child: Countdown(
                            seconds: 10,
                            controller: controller.countdownController,
                            onFinished: () {
                              controller.onCountDownFinish();
                            },
                            build: (context, double time) {
                              return Text(
                                time.toString(),
                                style: TextStyle(
                                    color: MyColors.textBlackColor,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                            buildPause: (context) {
                              return Text(
                                '请滑动滑条',
                                style: TextStyle(
                                    color: MyColors.textBlackColor,
                                    fontSize: 30.sp,

                                    fontWeight: FontWeight.bold),
                              );
                            },
                            interval: const Duration(milliseconds: 100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
