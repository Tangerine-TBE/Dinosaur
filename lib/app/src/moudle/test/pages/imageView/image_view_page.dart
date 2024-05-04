import 'dart:io';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
class ImageViewPage extends GetView<ImageViewController> {
  final String tagString;
  final String urlString;

  const ImageViewPage(
      {super.key, required this.tagString, required this.urlString});

  @override
  String? get tag => tagString;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: ImageView(
        controller: controller,
        tagString: tagString,
        urlString: urlString,
      ),
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
  var currentX = 0.0 ;
  var currentY = 0.0;
  var scaleSize = 1.0;
  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
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
        double scale = widget.controller.transformationController.value
            .getMaxScaleOnAxis();
        double targetScale = scale < 2.0 ? 2.0 : 1.0;

        Offset localPosition = widget.controller.position.value;
        Offset position = Offset(
          localPosition.dx /
              widget.controller.transformationController.value[0],
          localPosition.dy /
              widget.controller.transformationController.value[5],
        );

        Matrix4 beginMatrix = widget.controller.transformationController.value;
        Matrix4 endMatrix = Matrix4.identity()
          ..translate(position.dx, position.dy)
          ..scale(targetScale)
          ..translate(-position.dx, -position.dy);
        animationController.stop(); // 停止之前的动画
        animationController.duration =
            const Duration(milliseconds: 300); //重新设置延迟时间
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
      onVerticalDragStart: (details){
        widget.controller.dragStartPosition.value = details.localPosition;
      },
      onVerticalDragUpdate: (details){
        var currentPosition = details.localPosition;
        var currentY = currentPosition.dy;
        var startDragY = widget.controller.dragStartPosition.value.dy;
        var offset = startDragY - currentY;
        if(offset < 0 ){
          if(widget.controller.canDrag == false){
            widget.controller.canDrag = true;
          }else{
            //缩小
            //滑动的偏差与屏幕之间的比例
            var currentScaleSize = 1+ offset/MediaQuery.of(context).size.height;
            logE('scaleSize:$scaleSize');
            setState(() {
             scaleSize = currentScaleSize;
            });
          }
        }else{
          //放大到与原图一致
        }
        if(widget.controller.canDrag){
          //跟随手指滑动
          setState(() {
            currentX =-(widget.controller.dragStartPosition.value.dx - currentPosition.dx);
            this.currentY = -(widget.controller.dragStartPosition.value.dy - currentPosition.dy);
          });
        }
      },
      onVerticalDragEnd: (details){
        widget.controller.canDrag  =false;
        setState(() {
          currentX =0;
          currentY = 0;
          scaleSize = 1.0;
        });
      },
      child: Stack(
        children:[
          InteractiveViewer(
            maxScale: 4.0,
            transformationController: widget.controller.transformationController,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                return Center(
                  child: widget.urlString.startsWith('http')
                      ? Hero(
                    tag: widget.tagString,
                    child: Stack(
                      children:[
                        Positioned(
                          left: currentX,
                          top: currentY,
                          right: 0,
                          bottom: 0,
                          child: AnimatedScale(
                            scale: scaleSize,
                            duration: Duration(milliseconds: 200),
                            child: Image.network(
                              widget.urlString,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        )
                      ] ,
                    ),
                  )
                      : Image.file(
                    File(widget.urlString),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
