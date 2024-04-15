import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/painting.dart';

LinearGradient linearGradient1 = const LinearGradient(
    colors: [Colors.red, Colors.purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);
LinearGradient linearGradient2 = const LinearGradient(
    colors: [Colors.greenAccent, Colors.blue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);

LinearGradient linearGradient3 = const LinearGradient(
    colors: [Colors.deepOrangeAccent, Colors.indigoAccent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);

LinearGradient linearGradient4 = const LinearGradient(
    colors: [Colors.lightGreen, Colors.yellow],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);

Paint circleBorderPaint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeJoin = StrokeJoin.round
  ..strokeWidth = 10.0
  ..isAntiAlias = true;
Paint circlePaint = Paint()
  ..style = PaintingStyle.fill
  ..isAntiAlias = true;

class CustomCirCleBorder extends CustomPainter {
  final double seconds;
  final double radius;
  final double textSize;

  CustomCirCleBorder(
      {required this.seconds, required this.radius, required this.textSize});

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    var centerOffset = Offset(width / 2, height / 2);
    double startAngle = -90 * (math.pi / 180); // 开始角度
    double sweepAngle = (360/30) * seconds * (math.pi / 180); // 转换为弧度
    Path path = Path();
    path.addArc(
      Rect.fromCenter(center: centerOffset, width: radius, height: radius),
      startAngle,
      sweepAngle,
    );
    if ((360/30) * seconds > 180) {
      circleBorderPaint.shader = linearGradient4.createShader(path.getBounds());
      circlePaint.shader = linearGradient1.createShader(path.getBounds());

    }else if ((360/30) * seconds >90){
      circleBorderPaint.shader = linearGradient3.createShader(path.getBounds());
      circlePaint.shader = linearGradient2.createShader(path.getBounds());

    }else if ((360/30) * seconds > 270){
      circleBorderPaint.shader = linearGradient2.createShader(path.getBounds());
      circlePaint.shader = linearGradient3.createShader(path.getBounds());

    }else{
      circleBorderPaint.shader = linearGradient1.createShader(path.getBounds());
      circlePaint.shader = linearGradient4.createShader(path.getBounds());
    }
    double indicatorAngle = startAngle + sweepAngle;
    double indicatorX = centerOffset.dx + radius / 2 * math.cos(indicatorAngle);
    double indicatorY = centerOffset.dy + radius / 2 * math.sin(indicatorAngle);
    canvas.drawPath(path, circleBorderPaint);
    canvas.drawCircle(Offset(indicatorX, indicatorY),
        textSize + textSize / 3 / 2, circlePaint);
    drawText(
        canvas, '${seconds.round()}\'\'', indicatorX, indicatorY, circleBorderPaint, textSize);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

// 在指示器内部画文字
  void drawText(Canvas canvas, String text, double x, double y, Paint paint,
      double textSize) {
    TextSpan span = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: textSize),
      text: text,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
  }
}
