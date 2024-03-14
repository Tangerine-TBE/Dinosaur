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
                      Align(
                        alignment: Alignment.center,
                        child: Obx(
                          () => RepaintBoundary(
                            child: CustomPaint(
                              size: Size(280.w, 70.h),
                              painter: ChartsPainter(
                                  process: controller.process.value,
                                  processMax: 1023),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60.h,
                        left: 26.w,
                        child: Obx(() => Container(
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
                            )),
                      ),
                      Positioned(
                        bottom: 60.h,
                        right: 26.w,
                        child: Obx(
                          () => Container(
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
                    ],
                  )),
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
          ),
        ],
      ),
    );
  }

  _buildContentClassic() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(1, false),
              _buildItem(2, false),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(3, false),
              _buildItem(4, false),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(5, false),
              _buildItem(6, false),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(7, false),
              _buildItem(8, false),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(9, false),
              _buildItem(10, false),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(11, false),
              _buildItem(12, false),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
        ],
      ),
    );
  }
  _buildContentMine(){
    return Container();
  }
  Widget _buildItem(int index, bool isSelect) {
    AssetImage view;
    switch (index) {
      case 1:
        view = AssetImage(ResName.imgNDycx);
        break;
      case 2:
        view = AssetImage(ResName.imgNQymm);
        break;
      case 3:
        view = AssetImage(ResName.imgNRyds);
        break;
      case 4:
        view = AssetImage(ResName.imgNYfrh);
        break;
      case 5:
        view = AssetImage(ResName.imgNNgsh);
        break;
      case 6:
        view = AssetImage(ResName.imgNQsyh);
        break;
      case 7:
        view = AssetImage(ResName.imgNMlmh);
        break;
      case 8:
        view = AssetImage(ResName.imgBYbbn);
        break;
      case 9:
        view = AssetImage(ResName.imgNKlwj);
        break;
      case 10:
        view = AssetImage(ResName.imgNYszh);
        break;
      case 11:
        view = AssetImage(ResName.imgNXhnf);
        break;
      case 12:
        view = AssetImage(ResName.imgNGdck);
        break;
      default:
        view = AssetImage(ResName.imgNDycx);
        break;
    }
    return Container(
      height: 83.h,
      width: 144.w,
      decoration: BoxDecoration(
        image: DecorationImage(image: view),
      ),
    );
  }
}
