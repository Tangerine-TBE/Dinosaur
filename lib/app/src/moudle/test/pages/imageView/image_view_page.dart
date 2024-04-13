import 'dart:io';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    return ImageView(
      controller: controller,
      tagString: tagString,
      urlString: urlString,
    );
  }
}

class ImageView extends StatefulWidget {
  final ImageViewController controller;
  final String tagString;
  final String urlString;

  const ImageView(
      {super.key,
      required this.controller,
      required this.tagString,
      required this.urlString});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this, // 请根据您的具体情况替换为正确的TickerProvider
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.controller.finish();
      },
      onDoubleTapDown: (details) {
        widget.controller.position.value = details.localPosition;
      },
      onDoubleTap: () {
        double scale = widget.controller.transformationController.value.getMaxScaleOnAxis();
        double targetScale = scale < 2.0 ? 2.0 : 1.0;

        Offset localPosition = widget.controller.position.value;
        Offset position = Offset(
          localPosition.dx / widget.controller.transformationController.value[0],
          localPosition.dy / widget.controller.transformationController.value[5],
        );

        Matrix4 beginMatrix = widget.controller.transformationController.value;
        Matrix4 endMatrix = Matrix4.identity()
          ..translate(position.dx, position.dy)
          ..scale(targetScale)
          ..translate(-position.dx, -position.dy);

        animationController.stop(); // 停止之前的动画
        animationController.reset(); // 重置动画

        Animation<Matrix4> animation = Matrix4Tween(
          begin: beginMatrix,
          end: endMatrix,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ));

        animation.addListener(() {
          widget.controller.transformationController.value = animation.value;
        });

        animationController.forward();
      },
      child: InteractiveViewer(
        maxScale: 4.0,
        transformationController: widget.controller.transformationController,
        child: SizedBox(
          child: Center(
            child: Hero(
              tag: widget.tagString,
              child: widget.urlString.startsWith('http')
                  ? Image.network(
                      widget.urlString,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    )
                  : Image.file(
                      File(widget.urlString),
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
