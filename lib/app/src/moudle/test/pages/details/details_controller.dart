import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/repository/details_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../home/home_controller.dart';
import '../pet/weight/image_preview_single.dart';

class DetailsController extends BaseController {
  final PostsList item;
  final int index;
  final isLike = false.obs; //对于帖子来说
  final isCollect = false.obs; //对于帖子来说
  final _repo = Get.find<DetailsRepo>();
  final list = <CommentList>[];
  final listId = 1;
  CommentList? selectedCommentItem;
  final editTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final showSend = false.obs;

  DetailsController({required this.item, required this.index}) {}

  @override
  onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        //键盘焦点
        showSend.value = true;
      } else {
        //没有键盘焦点
        showSend.value = false;
        selectedCommentItem = null;
      }
    });
    _fetchCommentList();
  }

  onItemComment(CommentList commentList) {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    } else {
      FocusScope.of(Get.context!).requestFocus(focusNode);
    }
    selectedCommentItem = commentList;
  }

  onItemLike() {
    logE('like');
  }

  onItemMoreClick(CommentList item) {
    Get.bottomSheet(
      Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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

  onInputSubmit() async {
    focusNode.unfocus();
    var parentId = '';
    //当我评论评论的时候 parentId =
    if (selectedCommentItem != null) {
      parentId = selectedCommentItem!.postsId;
    } else {
      parentId = '0';
    }
    final response = await _repo.createComment(
      CommentCreateReq(
          postsId: item.id,
          path: '/',
          sortIndex: 1,
          level: 1,
          userId: User.loginRspBean!.userId,
          parentId: parentId,
          content: editTextController.value.text),
    );
    editTextController.clear();
    if (response.isSuccess) {
      if(response.data?.data != null){
        list.insert(0,response.data!.data!);
        update([listId]);
        EasyLoading.showSuccess('评论成功！');
      }
    }
  }

  onInputCollect() {
    //对于主题帖子来说
  }

  onInputLike() {
    //对于主题帖子来说
  }

  imagePreView(List<String> images, BuildContext context, double size,
      int parentIndex, List<ImageString> list) {
    ///每一张预期图片都是一个正方形
    if (images.isNotEmpty) {
      ///图片最多9张喔！
      ///只有一张的情况 大小限制为202.w的正方形
      if (images.length == 1) {
        var tag = '$parentIndex${0.toString()}details';
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
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: ((context, index) {
              var tag = '$parentIndex${index.toString()}details';
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
      return const SizedBox();
    }
  }

  _fetchCommentList() async {
    CommentListReq commentListReq = CommentListReq(
        postsId: item.id,
        pageIndex: 1,
        pageSize: 10,
        orderBy: 'createTime desc');
    final response = await _repo.getCommentList(commentListReq);
    if (response.isSuccess) {
      if (response.data?.data != null) {
        List<CommentList> commentList = response.data!.data!.commentList;
        list.addAll(commentList);
        update([listId]);
      }
    }
  }
}
