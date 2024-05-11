import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/repository/mine_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineReviewController extends BaseController {
  final _repo = Get.find<MineRepo>();
  final list = <CommentList>[];
  final listId = 1;

  @override
  onInit() {
    _fetchPostList();
    super.onInit();
  }
  onItemLike() {
    logE('like');
  }
  naviToDetails(CommentList item, int index) {
    //Todo 跳转到评论页面
    // var map = {'item': item, 'index': index};
    // navigateTo(RouteName.details, args: map);
  }
  
  onItemMoreClick(CommentList item) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12),),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12),),
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
