import 'package:app_base/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/bean/finger_info.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ImageViewPage extends StatelessWidget {
  final String tagString;
  final String urlString;

  const ImageViewPage({
    super.key,
    required this.tagString,
    required this.urlString,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ImageView(
        controller: ImageViewController(),
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
  late Animation _animation;
  var currentX = 0.0;
  var currentY = 0.0;
  var scaleSize = 1.0;
  var currentOpacity = 1.0;
  FingerInfo fingerStartInfo = FingerInfo(
      type: FingerType.unKnow, dx: 0, dy: 0, tapTime: DateTime.now());
  FingerInfo fingerEndInfo = FingerInfo(
      type: FingerType.unKnow, dx: 0, dy: 0, tapTime: DateTime.now());

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    widget.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      onDoubleTapDown: (details) {
        widget.controller.position = details.localPosition;
      },
      onDoubleTap: () {
        widget.controller.dragModel = Model.unKnow;
        double scale = widget.controller.transformationController.value
            .getMaxScaleOnAxis();
        double targetScale = scale < 2.0 ? 2.0 : 1.0;

        Offset localPosition = widget.controller.position;
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
          if (widget.controller.dragModel == Model.unKnow) {
            widget.controller.transformationController.value = animation.value;
          }
        });
        animationController.forward();
      },
      child: Container(
        color: Colors.black.withOpacity(currentOpacity),
        child: InteractiveViewer(
          trackpadScrollCausesScale: true,
          onInteractionStart: (details) {
            if (details.pointerCount > 1 && details.pointerCount <= 2) {
              //双指
              fingerStartInfo.type = FingerType.double;
              fingerStartInfo.dy = details.localFocalPoint.dy;
              fingerStartInfo.dx = details.localFocalPoint.dx;
            } else if (details.pointerCount == 1) {
              //单指
              fingerStartInfo.type = FingerType.single;
              fingerStartInfo.dy = details.localFocalPoint.dy;
              fingerStartInfo.dx = details.localFocalPoint.dx;
              fingerStartInfo.tapTime = DateTime.now();
            } else {
              //三指或其他
            }
          },
          onInteractionEnd: (details) {
            if (details.pointerCount > 1 && details.pointerCount <= 2) {
              //双指
            } else if (details.pointerCount == 1) {
              //单指
            } else {
              if (widget.controller.dragModel == Model.picTransformScale) {
                if (fingerEndInfo.type == FingerType.single &&
                    fingerStartInfo.type == FingerType.single) {
                  if (fingerEndInfo.dy - fingerStartInfo.dy >= 150) {
                    Navigator.pop(context);
                  } else {
                    var currentScaleSize = scaleSize;
                    var currentOffsetX = currentX;
                    var currentOffsetY = currentY;
                    var currentOffsetOpacity = currentOpacity;
                    _animation = Tween<double>(begin: 0.0, end: 1.0)
                        .animate(animationController)
                      ..addListener(
                        () {
                          logE('_animation Tween');
                          if (widget.controller.dragModel ==
                              Model.picTransformScale) {
                          setState(
                            () {

                                currentX = currentOffsetX -
                                    currentOffsetX * _animation.value;
                                currentY = currentOffsetY -
                                    currentOffsetY * _animation.value;
                                scaleSize = currentScaleSize +
                                    _animation.value * (1 - currentScaleSize);

                                currentOpacity = currentOffsetOpacity +
                                    _animation.value *
                                        (1 - currentOffsetOpacity);
                              }
                          );
                          }
                        },
                      )
                      ..addStatusListener((status) {
                        if (status == AnimationStatus.completed) {
                          widget.controller.dragModel = Model.unKnow;
                        }
                      });
                    animationController.forward(from: 0.0);
                  }
                }
              }
            }
          },
          onInteractionUpdate: (details) {
            if (details.pointerCount > 1 && details.pointerCount <= 2) {
            } else if (details.pointerCount == 1) {
              if (widget.controller.transformationController.value
                      .getMaxScaleOnAxis() >
                  1.0) {
                return;
              }
              if (fingerStartInfo.dy - details.localFocalPoint.dy < 0) {
                if (widget.controller.dragModel != Model.picTransformScale) {
                  widget.controller.dragModel = Model.picTransformScale;
                }

                fingerEndInfo.dy = details.localFocalPoint.dy;
                fingerEndInfo.dx = details.localFocalPoint.dx;
                fingerEndInfo.tapTime = DateTime.now();
                fingerEndInfo.type = FingerType.single;
              }
              if (widget.controller.dragModel == Model.picTransformScale) {
                var startDragY = fingerStartInfo.dy;
                var offset = startDragY - details.localFocalPoint.dy;
                if (offset < 0) {
                  if (widget.controller.canDrag == false) {
                    widget.controller.canDrag = true;
                  } else {
                    var currentScaleSize =
                        1 + offset / MediaQuery.of(context).size.height;
                    setState(() {
                      scaleSize = currentScaleSize;
                    });
                  }
                }
                setState(() {
                  currentX = -(fingerStartInfo.dx - details.localFocalPoint.dx);
                  currentY = -(fingerStartInfo.dy - details.localFocalPoint.dy);
                  var calculateOpacity = 1.0 *
                      (1 -
                          (details.localFocalPoint.dy - fingerStartInfo.dy) /
                              (MediaQuery.of(context).size.height -
                                  fingerStartInfo.dy));
                  if (calculateOpacity <= 1.0) {
                    currentOpacity = calculateOpacity;
                  }
                });
              }
            } else {
              //三指或其他
            }
          },
          transformationController: widget.controller.transformationController,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  Positioned(
                    left: currentX,
                    top: currentY,
                    bottom: -currentY,
                    right: -currentX,
                    child: Align(
                      alignment: Alignment.center,
                      child: AnimatedScale(
                        scale: scaleSize,
                        duration: const Duration(milliseconds: 200),
                        child: Hero(
                          tag: widget.tagString,
                          child: CachedNetworkImage(
                            imageUrl:widget.urlString,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
