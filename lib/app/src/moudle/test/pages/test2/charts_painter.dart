import 'package:flutter/cupertino.dart';

class ChartsPainter extends CustomPainter {
  final double process;
  static List<double>? _processes;
  late Paint mShapePaint;
  final double processMax;
  Color color = const Color.fromRGBO(236, 88, 100, 1.0);
  final double cellWidth;
  final double cellSpacing; // 添加间距参数
  ChartsPainter(
      {required this.process,
      this.cellWidth = 6,
      this.cellSpacing = 1,
      required this.processMax}) {
    mShapePaint = Paint();
    mShapePaint.color = color;
  }

  void add(double data) {
    for (int i = _processes!.length - 1; i > 0; i--) {
      _processes?[i] = _processes![i - 1];
    }
    _processes?[0] = data;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var cellCount = (width / (cellWidth + cellSpacing)).floor();
    _processes ??= List.generate(cellCount, (index) => 0);
    add(process);
    var totalWidth =
        cellCount * cellWidth + (cellCount - 1) * cellSpacing; // 计算所有cell占据的总宽度
    var startX = (width - totalWidth) / 2; // 计算起始绘制的X坐标
    var height = size.height;
    for (int i = 0; i < cellCount; i++) {
      var cellCenterX = startX + i * (cellWidth + cellSpacing) + cellWidth / 2;
      var cellCenterY = size.height / 2;
      var cellHeight =
          height / processMax * _processes![_processes!.length - 1 - i] <
                  cellWidth
              ? cellWidth
              : height / processMax * _processes![_processes!.length - 1 - i];
      var rect = RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(cellCenterX, cellCenterY),
            width: cellWidth,
            height: cellHeight),
        const Radius.circular(10),
      );
      canvas.drawRRect(rect, mShapePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
