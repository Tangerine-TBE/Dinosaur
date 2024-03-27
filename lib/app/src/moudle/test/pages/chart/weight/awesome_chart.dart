import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AwesomeChart extends CustomPainter {
  int controllerDot;
  Color shakeBoldColor;
  Color shakeShapeColor;
  Paint shakeBoldLinePaint = Paint();
  Paint shakeShapeLinePaint = Paint();
  Paint xLinePaint = Paint();
  Paint yLinePaint = Paint();
  Paint chuckPanPaint = Paint();
  double strokeWidth;
  Color panColor;
  final List<int> dataList;

  int totalTime = 0;

  AwesomeChart({
    required this.controllerDot,
    required this.dataList,
    required this.panColor,
    this.shakeBoldColor = Colors.blueAccent,
    this.shakeShapeColor = Colors.pinkAccent,
    this.strokeWidth = 6.0,
  }) {
    xLinePaint
      ..isAntiAlias = true
      ..color = Colors.white
      ..strokeWidth = 0.3;
    yLinePaint
      ..isAntiAlias = true
      ..color = Colors.white
      ..strokeWidth = 0.3;
    shakeBoldLinePaint
      ..isAntiAlias = true
      ..color = shakeBoldColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    shakeShapeLinePaint
      ..isAntiAlias = true
      ..color = shakeBoldColor.withAlpha(90)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    chuckPanPaint.isAntiAlias = true;
    for (int i = 0; i < dataList.length; i++) {
      totalTime += i * 200;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width < size.height) {
      throw "the view has width  < height";
    }

    _changeCanvasAis(canvas, size);
    _drawPan(canvas, size);
    _drawCurve(canvas, size);
  }

  _drawCurve(Canvas canvas, Size size) {
    Path boldPath = Path();
    Path shapePath = Path();
    var cellStrengthY = size.height / 1024;
    var cellTimeX = size.width / (dataList.length - 1);
    var startIndex = 2;
    var endIndex = dataList.length - 2;
    boldPath.moveTo(cellTimeX * startIndex,
        cellStrengthY * (dataList[startIndex] - (controllerDot + 5)));
    shapePath.moveTo(cellTimeX * startIndex,
        cellStrengthY * (dataList[startIndex] + (controllerDot + 5)));
    for (int i = startIndex + 1; i < endIndex; i++) {
      double prevX;
      double prevY;
      double currentX;
      double currentY;
      double nextX;
      double nextY;
      if (i % 2 == 0) {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) + controllerDot;
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) - controllerDot;
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) + controllerDot;
      } else {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) - controllerDot;
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + controllerDot;
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) - controllerDot;
      }
      if (i == endIndex - 1) {
        if (i % 2 == 0) {
          prevX = (cellTimeX) * (i - 1);
          prevY = cellStrengthY * (dataList[i - 1]) + controllerDot;
          currentX = (cellTimeX) * i;
          currentY = cellStrengthY * (dataList[i]) - controllerDot;
          nextX = (cellTimeX) * (i + 1);
          nextY = cellStrengthY * (dataList[i + 1]) + controllerDot;
        } else {
          prevX = (cellTimeX) * (i - 1);
          prevY = cellStrengthY * (dataList[i - 1]) - controllerDot;
          currentX = (cellTimeX) * i;
          currentY = cellStrengthY * (dataList[i]) + controllerDot;
          nextX = (cellTimeX) * (i + 1);
          nextY = cellStrengthY * (dataList[i + 1]) - controllerDot;
        }
      }
      double controlPoint1X = (prevX + currentX) / 2;
      double controlPoint1Y = (prevY + currentY) / 2;
      double controlPoint2X = (currentX + nextX) / 2;
      double controlPoint2Y = (currentY + nextY) / 2;
      boldPath.cubicTo(controlPoint1X, controlPoint1Y, currentX, currentY,
          controlPoint2X, controlPoint2Y);
    }
    for (int i = startIndex + 1; i < endIndex; i++) {
      double prevX;
      double prevY;
      double currentX;
      double currentY;
      double nextX;
      double nextY;
      if (i % 2 == 0) {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) - (controllerDot);
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + (controllerDot);
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) - (controllerDot);
      } else {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) + (controllerDot);
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) - (controllerDot);
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) + (controllerDot);
      }
      if (i == endIndex - 1) {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) - controllerDot;
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + controllerDot;
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) - controllerDot;
      }
      double controlPoint1X = (prevX + currentX) / 2;
      double controlPoint1Y = (prevY + currentY) / 2;
      double controlPoint2X = (currentX + nextX) / 2;
      double controlPoint2Y = (currentY + nextY) / 2;
      shapePath.cubicTo(controlPoint1X, controlPoint1Y, currentX, currentY,
          controlPoint2X, controlPoint2Y);
    }
    canvas.drawPath(shapePath, shakeShapeLinePaint);
    canvas.drawPath(boldPath, shakeBoldLinePaint);
  }

  _changeCanvasAis(Canvas canvas, Size size) {
    canvas.translate(0, size.height); // 将原点移动到底部
    canvas.scale(1, -1); // 垂直方向翻转坐标系
  }

  //绘制面板图
  _drawPan(Canvas canvas, Size size) {
    var chuckHeight = size.height / 3;
    var chuck = 255 ~/ 3;
    var chuckTime = totalTime / 3;
    var endX = size.width;
    var endY = size.height;
    var chuckWidth = size.width / 3;
    for (int i = 0; i < 3; i++) {
      chuckPanPaint.color = panColor.withAlpha(chuck + chuck * i);
      canvas.drawRect(
          Rect.fromLTRB(
              0, chuckHeight + chuckHeight * i, size.width, chuckHeight * i),
          chuckPanPaint);
    }
    for (int i = 0; i < 2; i++) {
      canvas.drawLine(Offset(0, chuckHeight + chuckHeight * i),
          Offset(endX, chuckHeight + chuckHeight * i), yLinePaint);
      canvas.drawLine(Offset(chuckWidth + chuckWidth * i, 0),
          Offset(chuckWidth + chuckWidth * i, endY), xLinePaint);
    }
    for (int i = 0; i < 3; i++) {
      canvas.save();
      canvas.scale(1, -1);
      TextSpan span = TextSpan(
          text: _calculateTime(chuckTime + chuckTime * i),
          style: TextStyle(color: Colors.black, fontSize: 12.sp));
      TextPainter textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      double textX = chuckWidth + chuckWidth * i - textPainter.width;
      double textY = -endY + textPainter.height / 4; // 考虑文字高度
      textPainter.paint(canvas, Offset(textX, textY));
      canvas.restore();
    }
  }

  _calculateTime(double millSecondTime) {
    var millTime = millSecondTime / 1000;
    var seconds = (millTime % 60).toInt();
    var min = millTime ~/ 60;
    return "$min'$seconds''";
  }

  _drawBorder() {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
