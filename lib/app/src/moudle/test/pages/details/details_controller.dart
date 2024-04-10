import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../pet/weight/image_preview_single.dart';


class DetailsController extends BaseController{
  final PostsList item;
  final int index;
  DetailsController({required this.item,required this.index});

  imagePreView(
      List<String> images, BuildContext context, double size, int parentIndex,List<ImageString> list) {
    ///每一张预期图片都是一个正方形
    if (images.isNotEmpty) {
      ///图片最多9张喔！
      ///只有一张的情况 大小限制为202.w的正方形
      if (images.length == 1) {
        var tag = '$parentIndex${0.toString()}details';
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
              var tag = '$parentIndex${0.toString()}details';
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
      return const SizedBox();
    }
  }

  _fetchCommentList(){

  }
}