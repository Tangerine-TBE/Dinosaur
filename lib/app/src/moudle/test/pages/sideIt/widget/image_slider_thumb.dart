

import 'dart:math';
import 'dart:ui' as Ui;

import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';

class ImageSliderThumb extends SliderComponentShape{
  final Size size;
  final Ui.Image image;
  ImageSliderThumb({
    required this.image,
    required this.size,
});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
      return size;
  }

  @override
  void paint(PaintingContext context, Offset center, {required Animation<double> activationAnimation, required Animation<double> enableAnimation, required bool isDiscrete, required TextPainter labelPainter, required RenderBox parentBox, required SliderThemeData sliderTheme, required TextDirection textDirection, required double value, required double textScaleFactor, required Size
  sizeWithOverflow}) {

        double dx = size.width/2;
        double dy = size.height/2;
        final Rect sourceRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
        double left = center.dx-dx;
        double top = center.dy - dy;
        double right = center.dx+dx;
        double bottom = center.dy + dy;
        Rect destinationRect = Rect.fromLTRB(left, top, right, bottom);
        final Canvas canvas = context.canvas;
        final Paint paint = Paint();
        paint.isAntiAlias =true;
        canvas.save(); // Save the current canvas state
        canvas.translate(center.dx, center.dy); // Move the canvas to the center
        canvas.rotate(90 * 3.1415927 / 180); // Rotate the canvas by 90 degrees
        canvas.translate(-center.dx, -center.dy); // Move the canvas back to its original position

        canvas.drawImageRect(image, sourceRect, destinationRect, paint);
        logE('${ destinationRect.height/2}-----${ destinationRect.width/2/2}');
        canvas.restore();
  }

}