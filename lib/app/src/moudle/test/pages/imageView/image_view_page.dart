import 'dart:ffi';
import 'dart:io';

import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ImageViewPage extends BaseEmptyPage<ImageViewController> {
  final String tagString;
  final String urlString;

  const ImageViewPage(
      {super.key, required this.tagString, required this.urlString});

  @override
  Color get background => Colors.black;

  @override
  String? get tag => tagString;

  @override
  Widget buildContent(BuildContext context) {
    return
      GestureDetector(
        onTap: (){Get.back();},
        onDoubleTapDown: (details){
         controller.position.value =  details.localPosition;
        },
        onDoubleTap: (){
          double scale = controller.transformationController.value.getMaxScaleOnAxis();
          double targetScale = scale < 2.0 ? 2.0 : 1.0; // 根据当前缩放比例确定目标缩放比例

          // 计算放大的中心点
          Offset localPosition =  controller.position.value;
          Offset position = Offset(
            localPosition.dx / controller.transformationController.value[0],
            localPosition.dy / controller.transformationController.value[5],
          );
          Matrix4 newMatrix = Matrix4.identity()
            ..translate(position.dx, position.dy)
            ..scale(targetScale)
            ..translate(-position.dx, -position.dy);
          controller.transformationController.value = newMatrix;
        },
        child: InteractiveViewer(
          maxScale: 4.0,
          transformationController: controller.transformationController,
          child: SizedBox(
            child: Center(
              child: Hero(
                tag: tagString,
                child: urlString.startsWith('http')
                    ? Image.network(
                  urlString,
                  fit: BoxFit.contain,
                  width: double.infinity,
                )
                    : Image.file(
                  File(urlString),
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
      )
      ;
  }
}
