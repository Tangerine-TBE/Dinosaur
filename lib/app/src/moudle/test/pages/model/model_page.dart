import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../sideIt/widget/charts_painter.dart';
import 'model_controller.dart';

class ModelPage extends BaseEmptyPage<ModelController> {
  const ModelPage({super.key});

  @override
  Color get background => Colors.white;

  @override
  Widget buildContent(BuildContext context) {
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
              controller: controller.pageController,
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
            padding: EdgeInsets.only(bottom: 23.h),
            child: Container(
              width: double.infinity,
              height: 75.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ResName.iconShake1,
                    width: 16.w,
                    height: 16.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onLastClick();
                    },
                    child: Image.asset(
                      ResName.iconLeft,
                      width: 16.w,
                      height: 16.w,
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
                  GestureDetector(
                    onTap: () {
                      controller.onNextClick();
                    },
                    child: Image.asset(
                      ResName.iconRight,
                      width: 16.w,
                      height: 16.w,
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
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        children: List.generate(
          controller.mRecordBean.dataList.length,
          (index) => _buildCustomModelItem(
              controller.mRecordBean.dataList[index].recordName, index),
        ),
      ),
    ));
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
}
