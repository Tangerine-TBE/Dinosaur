import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomShape extends SliderTrackShape with BaseSliderTrackShape {
  /// Create a slider track that draws two rectangles with rounded outer edges.
  final ui.Image image;

  const CustomShape({required this.image});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting can be a no-op.
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween =
        ColorTween(begin: Colors.blue, end: Colors.red);
    final Paint activePaint = Paint()..color = Colors.red.withAlpha(190);
    final Paint inactivePaint = Paint();
    final Paint borderSidePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const gradient = LinearGradient(
      colors: [Color(0xffBA38CB), Color(0xffFF5E65)], // 定义渐变色
      begin: Alignment.centerLeft, // 渐变起始位置
      end: Alignment.centerRight, // 渐变结束位置
    );


    final Paint backgroundPaint = Paint()..color = Colors.grey; // 选择所需的背景颜色
    final Paint leftTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
    }
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius borderSideRadius = Radius.circular(trackRect.height + 10 / 2);
    final Radius activeTrackRadius =
        Radius.circular((trackRect.height + additionalActiveTrackHeight) / 2);
    backgroundPaint.shader  = gradient.createShader(Rect.fromPoints(Offset(trackRect.left,trackRect.top),Offset(trackRect.right,trackRect.bottom),),);
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      backgroundPaint,
    );
    final targetRect = RRect.fromLTRBAndCorners(
      trackRect.left,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
      topRight: trackRadius,
      bottomRight: trackRadius,
      topLeft: trackRadius,
      bottomLeft: trackRadius,
    ).outerRect;
    context.canvas.save(); // Save the current canvas state
    context.canvas.translate(targetRect.center.dx,
        targetRect.center.dy); // Move the canvas to the center
    context.canvas
        .rotate(90 * 3.1415927 / 180); // Rotate the canvas by 90 degrees
    context.canvas.translate(
        -targetRect.center.dx, -targetRect.center.dy); // Move the canvas
    FittedSizes fittedSizes = applyBoxFit(
        BoxFit.cover,
        Size(
          image.width.toDouble(),
          image.height.toDouble(),
        ),
        Size(targetRect.height, targetRect.width));
// 获得一个图片区域中，指定大小的，居中位置处的 Rect
    Rect inputRect = Alignment.center.inscribe(fittedSizes.source,
        Offset.zero & Size(image.width.toDouble(), image.height.toDouble()));
// 获得一个绘制区域内，指定大小的，居中位置处的 Rect
    Rect outputRect =
        Alignment.center.inscribe(fittedSizes.destination, targetRect);
    context.canvas.drawImageRect(
      image,
      inputRect,
      outputRect,
      inactivePaint, // Adjust opacity as needed
    );
    context.canvas.restore();
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        trackRect.top,
        thumbCenter.dx,
        trackRect.bottom,
        topLeft: trackRadius,
        bottomLeft: trackRadius,
      ),
      leftTrackPaint,
    );
  }
}
