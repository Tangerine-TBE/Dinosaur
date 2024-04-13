import 'dart:math';
import 'dart:ui';

import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

var gradientBoldLineDouble = LinearGradient(
  colors: [
    const Color(0xff5EFFF8),
    const Color(0xff5E94FF).withOpacity(0.43),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

var gradientBoldLine = LinearGradient(
  colors: [const Color(0xff5E94FF).withOpacity(0.43), const Color(0xffFF5E65)],
  // 定义渐变色
  begin: Alignment.centerLeft,
  // 渐变起始位置
  end: Alignment.centerRight, // 渐变结束位置
);
var gradientBoldCircle = LinearGradient(
  colors: [const Color(0xff5E94FF).withOpacity(0.43), const Color(0xffFF5E65)],
  // 定义渐变色
  begin: Alignment.topCenter,
  // 渐变起始位置
  end: Alignment.bottomCenter, // 渐变结束位置
);
var gradientYLine = LinearGradient(
  colors: [
    const Color(0xffCA2626).withOpacity(0),
    const Color(0xffCA2626),
    const Color(0xffCA2626).withOpacity(0)
  ], // 定义渐变色
  begin: Alignment.topCenter, // 渐变起始位置
  end: Alignment.bottomCenter,
);

class AwesomeChartView extends StatefulWidget {
  final List<List<int>> dataList;
  final double width;
  final double height;
  int type;
  List<int> shakeLevel = <int>[];
  int controlDot;
  int level1;

  int level2;

  AwesomeChartView({
    super.key,
    required this.dataList,
    required this.width,
    required this.height,
    this.controlDot = 5,
    this.type = 0,
    this.level1 = 0,
    this.level2 = 10,
  });

  @override
  State<AwesomeChartView> createState() => _AwesomeChartViewState();
}

class _AwesomeChartViewState extends State<AwesomeChartView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animation = IntTween(begin: widget.level1, end: widget.level2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: AwesomeChart(
              controllerDot: _animation.value,
              lineList: widget.dataList,
              type: widget.type,
              panColor: MyColors.themeTextColor),
        );
      },
    );
  }
}

class AwesomeChart extends CustomPainter {
  int controllerDot;
  Color shakeBoldColor;
  Color shakeShapeColor;
  Paint shakeBoldLinePaint = Paint();
  Paint shakeShapeLinePaint = Paint();
  Paint shakeBoldCirclePaint = Paint();
  Paint shakeShapeCirclePaint = Paint();
  Paint yLinePaint = Paint();
  double strokeWidth;
  Color panColor;
  int type = 0;
  final List<List<int>> lineList;
  int totalTime = 0;
  var textHeight = 0;

  AwesomeChart({
    required this.controllerDot,
    required this.lineList,
    required this.panColor,
    this.type = 0,
    this.shakeBoldColor = Colors.blueAccent,
    this.shakeShapeColor = Colors.pinkAccent,
    this.strokeWidth = 6.0,
  }) {
    yLinePaint
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    shakeBoldLinePaint
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    shakeShapeLinePaint
      ..isAntiAlias = true
      ..color = const Color(0xffFF5E65).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    shakeBoldCirclePaint
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    shakeShapeCirclePaint
      ..isAntiAlias = true
      ..color = const Color(0xffFF5E65).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < lineList.length; i++) {
      totalTime = 0;
      for (int j = 1; j <= lineList[i].length; j++) {
        totalTime += 200;
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width < size.height) {
      throw "the view has width  < height";
    }
    if (lineList.isEmpty || (lineList.length == 1 && lineList[0].isEmpty)) {
      return;
    }
    _changeCanvasAis(canvas, size);
    _drawPan(canvas, size);
    if (type == 0) {
      for (int i = 0; i < lineList.length; i++) {
        if (lineList[i].isNotEmpty) {
          _drawCurve(canvas, size, lineList[i], i);
        }
      }
    } else {
      for (int i = 0; i < lineList.length; i++) {
        if (lineList[i].isNotEmpty) {
          _drawCircle(canvas, size, lineList[i]);
        }
      }
    }
  }

  ///关系数据有x轴的变化 与 y轴的变化 ，和圆自身大小无关
  ///
  _drawCircle(Canvas canvas, Size size, List<int> list) {
    //数据压缩

    var dataList = <int>[];
    if (list.length > 20) {
      var chuckSize = list.length ~/ 20;

      var j = 1;
      for (int i = 0; i < list.length; i++) {
        if (i / (chuckSize - 1) == j || chuckSize - 1 == 0) {
          dataList.add(list[i]);
          j = j + 1;
        }
      }
    } else {
      dataList.addAll(list);
    }
    var cellStrengthY = (size.height - textHeight) / 1024;
    for (int i = 0; i < dataList.length - 6; i++) {
      var circleY = cellStrengthY * dataList[i];
      var diameter = size.width / (dataList.length - 10);
      var circleX = diameter + diameter * i - diameter / 6;
      if (circleX <= 0) {
        continue;
      } else if (circleX >= size.width) {
        continue;
      }
      if (i % 2 == 0) {
        shakeBoldCirclePaint.shader = gradientBoldCircle.createShader(
          Rect.fromCenter(
              center: Offset(circleX, circleY + controllerDot),
              width: diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2,
              height: diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2),
        );

        canvas.drawCircle(
            Offset(circleX, circleY + controllerDot),
            diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2,
            shakeBoldCirclePaint);
        canvas.drawCircle(
            Offset(circleX, circleY - controllerDot),
            diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2,
            shakeShapeCirclePaint);
      } else {
        shakeBoldCirclePaint.shader = gradientBoldCircle.createShader(
          Rect.fromCenter(
              center: Offset(circleX, circleY - controllerDot),
              width: diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2,
              height: diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2),
        );

        canvas.drawCircle(
            Offset(circleX, circleY - controllerDot),
            diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2,
            shakeBoldCirclePaint);
        canvas.drawCircle(
            Offset(circleX, circleY + controllerDot),
            diameter / 2 - shakeBoldCirclePaint.strokeWidth / 2,
            shakeShapeCirclePaint);
      }
    }
  }

  _drawCurve(Canvas canvas, Size size, List<int> list, int i) {
    var dataList = <int>[];
    if (list.length > 20) {
      var chuckSize = list.length ~/ 20;
      var j = 1;
      for (int i = 0; i < list.length; i++) {
        if (i / (chuckSize - 1) == j || chuckSize - 1 == 0) {
          dataList.add(list[i]);
          j = j + 1;
        }
      }
    } else {
      dataList.addAll(list);
    }
    Path boldPath = Path();
    Path shapePath = Path();
    var endIndex = dataList.length - 2;
    var startIndex = 2;
    var cellStrengthY = (size.height - textHeight) / 1024;
    var cellTimeX = size.width / endIndex;
    boldPath.moveTo(
        cellTimeX * startIndex,
        cellStrengthY * (dataList[startIndex] - (controllerDot + 5)) +
            textHeight);
    shapePath.moveTo(
        cellTimeX * startIndex,
        cellStrengthY * (dataList[startIndex] + (controllerDot + 5)) +
            textHeight);
    for (int i = startIndex + 1; i < endIndex; i++) {
      double prevX;
      double prevY;
      double currentX;
      double currentY;
      double nextX;
      double nextY;
      if (i % 2 == 0) {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) + textHeight + controllerDot;
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + textHeight - controllerDot;
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) + textHeight + controllerDot;
      } else {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) + textHeight - controllerDot;
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + textHeight + controllerDot;
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) + textHeight - controllerDot;
      }
      if (i == endIndex - 1) {
        if (i % 2 == 0) {
          prevX = (cellTimeX) * (i - 1);
          prevY =
              cellStrengthY * (dataList[i - 1]) + textHeight + controllerDot;
          currentX = (cellTimeX) * i;
          currentY = cellStrengthY * (dataList[i]) + textHeight - controllerDot;
          nextX = (cellTimeX) * (i + 1);
          nextY =
              cellStrengthY * (dataList[i + 1]) + textHeight + controllerDot;
        } else {
          prevX = (cellTimeX) * (i - 1);
          prevY =
              cellStrengthY * (dataList[i - 1]) + textHeight - controllerDot;
          currentX = (cellTimeX) * i;
          currentY = cellStrengthY * (dataList[i]) + textHeight + controllerDot;
          nextX = (cellTimeX) * (i + 1);
          nextY =
              cellStrengthY * (dataList[i + 1]) + textHeight - controllerDot;
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
        prevY =
            cellStrengthY * (dataList[i - 1]) + textHeight - (controllerDot);
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + textHeight + (controllerDot);
        nextX = (cellTimeX) * (i + 1);
        nextY =
            cellStrengthY * (dataList[i + 1]) + textHeight - (controllerDot);
      } else {
        prevX = (cellTimeX) * (i - 1);
        prevY =
            cellStrengthY * (dataList[i - 1]) + textHeight + (controllerDot);
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + textHeight - (controllerDot);
        nextX = (cellTimeX) * (i + 1);
        nextY =
            cellStrengthY * (dataList[i + 1]) + textHeight + (controllerDot);
      }
      if (i == endIndex - 1) {
        prevX = (cellTimeX) * (i - 1);
        prevY = cellStrengthY * (dataList[i - 1]) + textHeight - controllerDot;
        currentX = (cellTimeX) * i;
        currentY = cellStrengthY * (dataList[i]) + textHeight + controllerDot;
        nextX = (cellTimeX) * (i + 1);
        nextY = cellStrengthY * (dataList[i + 1]) + textHeight - controllerDot;
      }
      double controlPoint1X = (prevX + currentX) / 2;
      double controlPoint1Y = (prevY + currentY) / 2;
      double controlPoint2X = (currentX + nextX) / 2;
      double controlPoint2Y = (currentY + nextY) / 2;
      shapePath.cubicTo(controlPoint1X, controlPoint1Y, currentX, currentY,
          controlPoint2X, controlPoint2Y);
    }
    if (i == 0) {
      shakeBoldLinePaint.shader =
          gradientBoldLine.createShader(boldPath.getBounds());
    } else {
      shakeBoldLinePaint.shader =
          gradientBoldLineDouble.createShader(boldPath.getBounds());
      shakeShapeLinePaint.color = const Color(0xff5E94FF).withOpacity(0.2);
    }
    canvas.drawPath(shapePath, shakeShapeLinePaint);
    canvas.drawPath(boldPath, shakeBoldLinePaint);
  }

  _changeCanvasAis(Canvas canvas, Size size) {
    canvas.translate(0, size.height); // 将原点移动到底部
    canvas.scale(1, -1); // 垂直方向翻转坐标系
  }

  _drawPan(Canvas canvas, Size size) {
    var chuckWidth = size.width / 4;
    var chuckTime = totalTime / 4;
    for (int i = 0; i < 3; i++) {
      canvas.save();
      canvas.scale(1, -1);
      TextSpan span = TextSpan(
          text: _calculateTime(chuckTime + chuckTime * i),
          style: TextStyle(color: Colors.black, fontSize: 12));
      TextPainter textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      double textX = chuckWidth + chuckWidth * i - (textPainter.width / 2);
      double textY = -textPainter.height;
      textHeight = max(textHeight, textPainter.height.toInt());
      textPainter.paint(canvas, Offset(textX, textY));
      canvas.restore();
    }
    for (int i = 0; i < 3; i++) {
      var path = Path();
      path.moveTo(chuckWidth + chuckWidth * i, textHeight.toDouble());
      path.lineTo(chuckWidth + chuckWidth * i, size.height);
      yLinePaint.shader = gradientYLine.createShader(path.getBounds());
      canvas.drawPath(path, yLinePaint);
    }
  }

  _calculateTime(double millSecondTime) {
    var millTime = millSecondTime / 1000;
    var seconds = (millTime % 60).toInt();
    var min = millTime ~/ 60;
    return "$min'$seconds''";
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
