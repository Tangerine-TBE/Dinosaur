import 'package:app_base/config/res_name.dart';
import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/base_controller.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/repository/push_repo.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:dinosaur/app/src/moudle/test/dialog/my_dialog_widget.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/weight/image_preview_single.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';

class PetController extends BaseController {
  late CommonManager commonManager;
  late DynamicManager dynamicManager;
  late HandPickManager handPickManager;
  late RefreshManager refreshManager;
  var currentIndex = 0;
  final _pushRepo = Get.find<PushRepo>();

  @override
  void onInit() {
    commonManager = CommonManager(controller: this, pushRepo: _pushRepo);
    dynamicManager = DynamicManager(controller: this, pushRepo: _pushRepo);
    handPickManager = HandPickManager(controller: this, pushRepo: _pushRepo);
    refreshManager = RefreshManager(controller: this, pushRepo: _pushRepo);
    commonManager.init();
    super.onInit();
  }

  naviToDetails(PostsList item,int index) {
    var map = {'item':item,'index':index};
    navigateTo(RouteName.details, args: map);
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
    } else {
      refreshManager.init();
    }
    currentIndex = index;
  }

  naviToPush() async {
    PostsList postsList = await navigateForResult(RouteName.push);
    if (currentIndex == 0) {
      commonManager.dataList.insert(0, postsList);
      update([commonManager.listId]);
    } else if (currentIndex == 1) {
      handPickManager.dataList.insert(0, postsList);
      update([handPickManager.listId]);
    } else if (currentIndex == 2) {
      dynamicManager.dataList.insert(0, postsList);
      update([dynamicManager.listId]);
    } else {
      refreshManager.dataList.insert(0, postsList);
     update([refreshManager.listId]);
    }
  }

  imagePreView(
      List<String> images, BuildContext context, double size, int parentIndex,List<ImageString> list) {
    ///每一张预期图片都是一个正方形
    if (images.isNotEmpty) {
      ///图片最多9张喔！
      ///只有一张的情况 大小限制为202.w的正方形
      if (images.length == 1) {
        var tag = '$parentIndex${0.toString()}';
        return InkWell(
          onTap: () {
            final homeController = Get.find<HomeController>();
            homeController.toImageView(images[0], tag);
          },
          child: Hero(
            tag: tag,
            child: ImagePreViewSingle(
              url: images[0],
              size: size,
              imageHeight: list[0].height,
              imageWidth: list[0].width,
            ),
          ),
        );
      } else {
        ///3x3摆放
        var reSizeHeight = 0.0;
        var reSizeWidth = 0.0;
        var crossAxisCount = images.length;
        if (images.length <= 3) {
          crossAxisCount = images.length;
          reSizeHeight = size / 3;
          reSizeWidth = size / 3 * images.length;
        } else if (images.length == 4) {
          crossAxisCount = images.length - 2;
          reSizeHeight = size / 3 * (images.length - 2);
          reSizeWidth = size / 3 * (images.length - 2);
        } else {
          crossAxisCount = 3;
          reSizeWidth = size / 3 * 3;
          if (images.length <= 6) {
            reSizeHeight = size / 3 * 2;
          } else {
            reSizeHeight = size / 3 * 3;
          }
        }
        return SizedBox(
          width: reSizeWidth,
          height: reSizeHeight,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 2.w,
              crossAxisSpacing: 2.w,
            ),
            itemBuilder: ((context, index) {
              var tag = '$parentIndex${index.toString()}';
              return InkWell(
                onTap: () {
                  final homeController = Get.find<HomeController>();
                  homeController.toImageView(images[index], tag);
                },
                child: Hero(
                  tag: tag,
                  child: ImagePreViewSingle(
                    url: images[index],
                    size: size,
                    imageWidth: list[index].width,
                    imageHeight: list[index].height,
                  ),
                ),
              );
            }),
            itemCount: images.length,
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
  final PushRepo pushRepo;
  final listId = 1;
  final dataList = <PostsList>[];
  var pageIndex = 1;

  CommonManager({required this.controller, required this.pushRepo});
  Future loadMoreList() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await pushRepo.getPushMsg(
      PushMsgReq(
          topicId: 'Dynamic',
          pageIndex: ++pageIndex,
          pageSize: 10,
          orderBy: 'createTime desc',
          postsType: 'Dynamic'),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        dataList.addAll(response.data!.data!.postsList);
        controller.update([listId]);
      }
    }
  }
  showBottomSheet(){
    Get.bottomSheet(
      Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text(
                  '举报',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                color: MyColors.textGreyColor.withOpacity(0.3),
                thickness: 5,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  '取消',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
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
    final response = await controller.apiLaunch(
      () => pushRepo.getPushMsg(
        PushMsgReq(
            topicId: 'Recomed',
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            postsType: 'Recomed'),
      ),
    );

    if (response?.data != null) {
      dataList.addAll(response!.data!.postsList);
      controller.update([listId]);
    }
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
  final PushRepo pushRepo;
  final dataList = <PostsList>[];
  var pageIndex = 1;

  DynamicManager({required this.controller, required this.pushRepo});

  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }

  List<BannerModel> get listBanners {
    return [
      BannerModel(imagePath: ResName.homeAdd0, id: "1", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd1, id: "2", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd2, id: "3", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd3, id: "4", boxFit: BoxFit.cover),
    ];
  }

  getList() async {
    final response = await controller.apiLaunch(
      () => pushRepo.getPushMsg(
        PushMsgReq(
            topicId: 'Dynamic',
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            postsType: 'Dynamic'),
      ),
    );

    if (response?.data != null) {
      dataList.addAll(response!.data!.postsList);
      controller.update([listId]);
    }
  }
  Future loadMoreList() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await pushRepo.getPushMsg(
      PushMsgReq(
          topicId: 'Dynamic',
          pageIndex: ++pageIndex,
          pageSize: 10,
          orderBy: 'createTime desc',
          postsType: 'Dynamic'),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        dataList.addAll(response.data!.data!.postsList);
        controller.update([listId]);
      }
    }
  }
  showBottomSheet(){
    Get.bottomSheet(
      Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text(
                  '举报',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                color: MyColors.textGreyColor.withOpacity(0.3),
                thickness: 5,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  '取消',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}

class HandPickManager {
  bool isInit = false;
  final PetController controller;
  final listId = 3;
  final PushRepo pushRepo;
  final dataList = <PostsList>[];
  var pageIndex = 1;

  HandPickManager({required this.controller, required this.pushRepo});

  List<BannerModel> get listBanners {
    return [
      BannerModel(imagePath: ResName.homeAdd0, id: "1", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd1, id: "2", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd2, id: "3", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd3, id: "4", boxFit: BoxFit.cover),
    ];
  }

  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }
  Future loadMoreList() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await pushRepo.getPushMsg(
      PushMsgReq(
          topicId: 'Curated',
          pageIndex: ++pageIndex,
          pageSize: 10,
          orderBy: 'createTime desc',
          postsType: 'Curated'),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        dataList.addAll(response.data!.data!.postsList);
        controller.update([listId]);
      }
    }
  }
  showBottomSheet(){
    Get.bottomSheet(
      Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text(
                  '举报',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                color: MyColors.textGreyColor.withOpacity(0.3),
                thickness: 5,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  '取消',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  getList() async {
    final response = await controller.apiLaunch(
      () => pushRepo.getPushMsg(
        PushMsgReq(
            topicId: 'Curated',
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            postsType: 'Curated'),
      ),
    );

    if (response?.data != null) {
      dataList.addAll(response!.data!.postsList);
      controller.update([listId]);
    }
  }
}

class RefreshManager {
  bool isInit = false;
  final PetController controller;
  final listId = 4;
  final PushRepo pushRepo;
  final dataList = <PostsList>[];
  var pageIndex = 1;
  RefreshManager({required this.controller, required this.pushRepo});

  List<BannerModel> get listBanners {
    return [
      BannerModel(imagePath: ResName.homeAdd0, id: "1", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd1, id: "2", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd2, id: "3", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd3, id: "4", boxFit: BoxFit.cover),
    ];
  }
  Future loadMoreList() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await pushRepo.getPushMsg(
      PushMsgReq(
          topicId: 'Latest',
          pageIndex: ++pageIndex,
          pageSize: 10,
          orderBy: 'createTime desc',
          postsType: 'Latest'),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        dataList.addAll(response.data!.data!.postsList);
        controller.update([listId]);
      }
    }
  }
  init() {
    if (!isInit) {
      getList();
      isInit = true;
    }
  }
  showBottomSheet(){
     Get.bottomSheet(
      Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text(
                  '举报',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                color: MyColors.textGreyColor.withOpacity(0.3),
                thickness: 5,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  '取消',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  getList() async {
    final response = await controller.apiLaunch(
      () => pushRepo.getPushMsg(
        PushMsgReq(
            topicId: 'Latest',
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            postsType: 'Latest'),
      ),
    );
    if (response?.data != null) {
      dataList.addAll(response!.data!.postsList);
      controller.update([listId]);
    }
  }
}
