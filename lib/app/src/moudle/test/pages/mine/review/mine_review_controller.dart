import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/repository/mine_repo.dart';
import 'package:app_base/widget/listview/smart_load_more_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineReviewController extends BaseController {
  final _repo = Get.find<MineRepo>();
  final list = <CommentList>[];
  final listId = 1;
  var pageIndex = 1;
  final canLoadMore = false.obs;
  var init = false;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onReady() {
    super.onReady();
    if (!init) {
      init = true;
      refreshController.requestRefresh();
    }
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  onItemLike() {
    logE('like');
  }

  naviToDetails(CommentList commentItem, int index) async {
    //Todo 跳转到评论页面
    final response = await apiLaunch(
      () => _repo.getPostItem(postId: commentItem.postsId),
    );
    if (response != null) {
      if (response.data != null) {
        final PostsList item = response.data!;
        var map = {'item': item, 'index': index};
        navigateTo(RouteName.details, args: map);
      }
    }
  }

  Future loadMoreList(bool isRefresh) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await _repo.getMineCommentList(
      MineReq(
        userId: User.loginRspBean!.userId,
        pageSize: 10,
        orderBy: 'createTime desc',
        pageIndex: isRefresh ? 1 : pageIndex,
      ),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        var list = response.data!.data!.commentList;
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
          if (response.data!.data!.commentList.isEmpty) {
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

  onItemMoreClick(CommentList item) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
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
      ),
    );
  }

  _fetchPostList() async {
    final response = await _repo.getMineCommentList(
      MineReq(
          userId: User.loginRspBean!.userId,
          pageSize: 10,
          pageIndex: 1,
          orderBy: 'createTime desc'),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        list.addAll(response.data!.data!.commentList);
        update([listId]);
      }
    }
  }
}
