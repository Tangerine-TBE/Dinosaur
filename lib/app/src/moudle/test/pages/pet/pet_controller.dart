import 'dart:async';

import 'package:app_base/config/res_name.dart';
import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_controller.dart';
import 'package:app_base/util/image.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:dinosaur/app/src/moudle/test/dialog/my_dialog_widget.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:app_base/mvvm/model/friends_share_bean.dart';
import 'package:get/get.dart';

class PetController extends BaseController {
  late CommonManager commonManager;
  late DynamicManager dynamicManager;
  late HandPickManager handPickManager;
  late RefreshManager refreshManager;

  @override
  void onInit() {
    commonManager = CommonManager(controller: this);
    dynamicManager = DynamicManager(controller: this);
    handPickManager = HandPickManager(controller: this);
    refreshManager = RefreshManager(controller: this);
    commonManager.init();
    super.onInit();
  }

  naviToDetails(Recommon item) {
    navigateTo(RouteName.details, args: item);
  }

  naviToImageView(String url) {
    navigateTo(RouteName.imageView, args: url);
  }

  onPageChanged(int index) {
    if (index == 0) {
      commonManager.init();
    } else if (index == 1) {
      dynamicManager.init();
    } else if (index == 2) {
      handPickManager.init();
    } else if (index == 3) {
      refreshManager.init();
    }
  }

  imagePreView(List<String> images, BuildContext context, double size) {
    ///每一张预期图片都是一个正方形
    if (images.isNotEmpty) {
      ///图片最多9张喔！
      ///只有一张的情况 大小限制为202.w的正方形
      if (images.length == 1) {
        return FutureBuilder<ui.Image>(
          future: loadImageWithUrl(images[0], context),
          builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              ///图片完成后检举一下图片
              var image = snapshot.data;
              if (image != null) {
                var imageWidth = image.width; //图片的实际宽度
                var imageHeight = image.height; //图片的实际高度
                ///比对一下图片的比例
                if (imageWidth ~/ imageHeight == 1) {
                  ///正方形的图片 直接返回我们需要的实际大小的容器并包裹
                  return SizedBox(
                    width: size.toDouble(),
                    height: size.toDouble(),
                    child: RawImage(
                      image: image,
                      fit: BoxFit.fill,
                    ),
                  );
                } else if (imageWidth ~/ imageHeight < 1) {
                  /// 长方形图片，宽比高多类型，所以BoxFit。最好就是以宽优先
                  return SizedBox(
                    width: size.toDouble(),
                    child: RawImage(
                      image: image,
                      fit: BoxFit.fill,
                    ),
                  );
                } else if (imageWidth ~/ imageHeight > 1) {
                  /// 长方形图片，高比宽多类型，所以BoxFit。最好就是以高优先
                  return SizedBox(
                    height: size.toDouble(),
                    child: RawImage(
                      image: image,
                      fit: BoxFit.fill,
                    ),
                  );
                } else {
                  return SizedBox(
                    height: size.toDouble(),
                    child: RawImage(
                      image: image,
                      fit: BoxFit.fill,
                    ),
                  );
                }
              } else {
                return Container(
                  width: size.toDouble(),
                  height: size.toDouble(),
                  color: Colors.purple,
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: size.toDouble(),
                height: size.toDouble(),
                color: Colors.red,
              );
            } else {
              return Container(
                width: size.toDouble(),
                height: size.toDouble(),
                color: Colors.purple,
              );
            }
          },
        );
      } else {
        ///3x3摆放
        var reSizeHeight= 0.0;
        var reSizeWidth = 0.0;
        var crossAxisCount = images.length;
        if(images.length <= 3){
          crossAxisCount = images.length;
          reSizeHeight  = size /3;
          reSizeWidth = size/3 * images.length;
        }else if(images.length == 4){
          crossAxisCount = images.length -2;
          reSizeHeight = size /3 *(images.length-2);
          reSizeWidth = size/3 * (images.length -2);
        }else{
          crossAxisCount = 3;
          reSizeWidth = size/3 * 3;
          if(images.length <= 6){
            reSizeHeight = size /3 * 2;
          }else{
            reSizeHeight = size /3 * 3;
          }
        }
        return SizedBox(
          width: reSizeWidth,
          height: reSizeHeight,
          child: IgnorePointer(
            child: GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 2.w,
                crossAxisSpacing: 2.w,
              ),
              itemBuilder: ((context, index) {
                return FutureBuilder(
                  future: loadImageWithUrl(images[index], context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      var image = snapshot.data;
                      if (image != null) {
                        var imageWidth = image.width; //图片的实际宽度
                        var imageHeight = image.height; //图片的实际高度
                        ///比对一下图片的比例
                        if (imageWidth ~/ imageHeight == 1) {
                          ///正方形的图片 直接返回我们需要的实际大小的容器并包裹
                          return SizedBox(
                            child: RawImage(
                              image: image,
                              fit: BoxFit.fill,
                            ),
                          );
                        } else if (imageWidth ~/ imageHeight < 1) {
                          /// 长方形图片，宽比高多类型，所以BoxFit。最好就是以宽优先
                          return SizedBox(
                            child: RawImage(
                              image: image,
                              fit: BoxFit.fill,
                            ),
                          );
                        } else if (imageWidth ~/ imageHeight > 1) {
                          /// 长方形图片，高比宽多类型，所以BoxFit。最好就是以高优先
                          return SizedBox(
                            child: RawImage(
                              image: image,
                              fit: BoxFit.fill,
                            ),
                          );
                        } else {
                          return SizedBox(
                            child: RawImage(
                              image: image,
                              fit: BoxFit.fill,
                            ),
                          );
                        }
                      } else {
                        return Container(
                          color: Colors.purple,
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                        child: Icon(Icons.downloading),
                      );
                    } else {
                      return Container(
                        child: Icon(Icons.picture_in_picture_alt_outlined),
                      );
                    }
                  },
                );
              }),itemCount: images.length,
            ),
          ),
        );
        // return FutureBuilder<ui.Image>(
        //     future: loadImageWithUrl(images, context), builder: builder)
      }
    } else {
      return SizedBox();
    }
  }
}

class CommonManager {
  bool isInit = false;
  final PetController controller;
  final listId = 1;
  final dataList = <Recommon>[];

  CommonManager({required this.controller});

  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }

  showTipDialog() {
    Get.dialog(TipsDialogWidget());
  }

  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    dataList.addAll(RecommonRsp.mock().recommon);
    controller.update([listId]);
    controller.dismiss();
  }

  List<BannerModel> get listBanners {
    return [
      BannerModel(imagePath: ResName.homeAdd0, id: "1", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd1, id: "2", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd2, id: "3", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd3, id: "4", boxFit: BoxFit.cover),
    ];
  }
}

class DynamicManager {
  bool isInit = false;
  final PetController controller;
  final listId = 2;

  DynamicManager({required this.controller});

  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }

  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.update([listId]);
    controller.dismiss();
  }
}

class HandPickManager {
  bool isInit = false;
  final PetController controller;
  final listId = 3;

  HandPickManager({required this.controller});

  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }

  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.update([listId]);
    controller.dismiss();
  }
}

class RefreshManager {
  bool isInit = false;
  final PetController controller;
  final listId = 4;

  RefreshManager({required this.controller});

  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }

  getList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.update([listId]);
    controller.dismiss();
  }
}
