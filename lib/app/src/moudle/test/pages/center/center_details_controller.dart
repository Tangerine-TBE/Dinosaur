import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/mvvm/repository/push_repo.dart';
import 'package:app_base/widget/listview/smart_refresh_listview.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_controller.dart';
import '../pet/weight/image_preview_single.dart';

class CenterDetailsController extends BaseController {
  final TopicList topCenterList;

  CenterDetailsController({required this.topCenterList});
  late RefreshManager refreshManager;
  var currentIndex = 0;
  final _pushRepo = Get.find<PushRepo>();

  @override
  void onInit() {
    refreshManager = RefreshManager(controller: this, pushRepo: _pushRepo);
    super.onInit();
  }
  @override
  void onReady(){
    refreshManager.init();
  }
  @override
  void onClose(){
    refreshManager.freshController.dispose();
    super.onClose();
  }

  naviToDetails(PostsList item,int index) {
    var map = {'item':item,'index':index};
    navigateTo(RouteName.details, args: map);
  }

  naviToImageView(String url) {
    navigateTo(RouteName.imageView, args: url);
  }


  naviToPush() async {
    PostsList postsList = await navigateForResult(RouteName.push);
      refreshManager.dataList.insert(0, postsList);
      update([refreshManager.listId]);
  }

  imagePreView(
      List<String> images, BuildContext context, double size, int parentIndex,List<ImageString> list) {
    ///每一张预期图片都是一个正方形
    if (images.isNotEmpty) {
      ///图片最多9张喔！
      ///只有一张的情况 大小限制为202.w的正方形
      if (images.length == 1) {
        var tag = 'centerDetails$parentIndex${0.toString()}';
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
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: ((context, index) {
              var tag = 'centerDetails$parentIndex${index.toString()}';
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



class RefreshManager {
  bool isInit = false;
  final CenterDetailsController controller;
  final listId = 4;
  final PushRepo pushRepo;
  final dataList = <PostsList>[];
  var pageIndex = 1;
  final freshController = RefreshController(initialRefresh: false);
  final canLoadMore = false.obs;

  RefreshManager({required this.controller, required this.pushRepo});

  List<BannerModel> get listBanners {
    return [
      BannerModel(imagePath: ResName.homeAdd0, id: "1", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd1, id: "2", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd2, id: "3", boxFit: BoxFit.cover),
      BannerModel(imagePath: ResName.homeAdd3, id: "4", boxFit: BoxFit.cover),
    ];
  }

  Future loadMoreList(bool isRefresh) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await pushRepo.getPushMsg(
      PushMsgReq(
          userId: User.loginRspBean!.userId,
          topicId: '',
          pageIndex: pageIndex+1,
          pageSize: 10,
          orderBy: 'createTime desc',
          postsType: 'Latest'),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        var list = response.data!.data!.postsList;
        if (list.isNotEmpty) {
          if (isRefresh) {
            dataList.clear();
            canLoadMore.value = true;
            pageIndex = 1;
          } else {
            pageIndex = pageIndex + 1;
          }
          pageIndex = pageIndex+1;
          dataList.addAll(list);
          controller.update([listId]);
        }
      }
    }
    if (isRefresh) {
      if (response.isSuccess) {
        freshController.refreshCompleted();
      } else {
        freshController.refreshFailed();
      }
    } else {
      if (response.isSuccess) {
        if (response.data?.data != null) {
          if (response.data!.data!.postsList.isEmpty) {
            freshController.loadNoData();
            return;
          }
        }
        freshController.loadComplete();
      } else {
        freshController.loadFailed();
      }
    }
  }

  init() {
    if (!isInit) {
      freshController.requestRefresh();
      isInit = true;
    }
  }

  showBottomSheet() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                MaterialButton(
                  minWidth: double.infinity,
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
                MaterialButton(
                  minWidth: double.infinity,
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
      ),
    );
  }

}


