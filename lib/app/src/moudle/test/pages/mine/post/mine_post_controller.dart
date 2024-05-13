import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/repository/mine_repo.dart';
import 'package:app_base/widget/listview/smart_refresh_listview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/home_controller.dart';
import '../../pet/weight/image_preview_single.dart';

class MinePostController extends BaseController {
  final _repo = Get.find<MineRepo>();
  final list = <PostsList>[];
  final listId = 1;
  var pageIndex = 1;
  final canLoadMore = false.obs;
 final  RefreshController refreshController =
  RefreshController(initialRefresh: true);
  showBottomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
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
  Future loadMoreList(bool isRefresh) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await _repo.getPost(
      MineReq(
        userId: User.loginRspBean!.userId,
        pageSize: 10,
        orderBy: 'createTime desc',
        pageIndex: isRefresh?1:pageIndex,
      ),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        var list = response.data!.data!.postsList;
        if (list.isNotEmpty) {
          if (isRefresh) {
            this.list.clear();
            canLoadMore.value = true;
            pageIndex = 1;
          } else {
            pageIndex = pageIndex + 1;
          }
          this.list.addAll(list);
          update([listId]);
        }
      }
    }
    if (isRefresh) {
      if (response.isSuccess) {
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshFailed();
      }
    } else {
      if (response.isSuccess) {
        if (response.data?.data != null) {
          if (response.data!.data!.postsList.isEmpty) {
            refreshController.loadNoData();
            return;
          }
        }
        refreshController.loadComplete();
      } else {
        refreshController.loadFailed();
      }
    }
  }
  @override
  void onClose(){
    refreshController.dispose();
    super.onClose();
  }
  _fetchPostList() async {
    final response = await _repo.getPost(
      MineReq(
        userId: User.loginRspBean!.userId,
        pageSize: 10,
        orderBy: 'createTime desc',
        pageIndex: 1,
      ),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        list.addAll(response.data!.data!.postsList);
        update([listId]);
      }
    }
  }
  naviToDetails(PostsList item, int index) {
    var map = {'item': item, 'index': index};
    navigateTo(RouteName.details, args: map);
  }
  imagePreView(List<String> images, BuildContext context, double size,
      int parentIndex, List<ImageString> list, String type) {
    ///每一张预期图片都是一个正方形
    if (images.isNotEmpty) {
      ///图片最多9张喔！
      ///只有一张的情况 大小限制为202.w的正方形
      if (images.length == 1) {
        var tag = '$type$parentIndex${0.toString()}';
        return InkWell(
          onTap: () {
            final homeController = Get.find<HomeController>();
            homeController.toImageView(images[0], tag,list[0].height,list[0].width);
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
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: ((context, index) {
              var tag = '$type$parentIndex${index.toString()}';
              return InkWell(
                onTap: () {
                  final homeController = Get.find<HomeController>();
                  homeController.toImageView(images[index], tag,list[index].height,list[index].width);
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
