import 'package:flutter/material.dart';

class CurvedIndicator extends Decoration{
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CurvedIndicatorPainter(this);
  }


}
class _CurvedIndicatorPainter extends BoxPainter {
  final CurvedIndicator decoration;

  _CurvedIndicatorPainter(this.decoration);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var size = configuration.size??const Size(0, 0);
    final Rect rect = offset & size;
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth= 3
      ..strokeCap =StrokeCap.round
      ..style = PaintingStyle.stroke;

    var indicatorX = rect.center.dx;
    var indicatorY= rect.bottom;
    Path path = Path();
    path.moveTo(indicatorX-7, indicatorY-2); // 起点
    path.arcToPoint(
      Offset(indicatorX+7, indicatorY-2), // 弧线终点
      radius: const Radius.circular(20), // 弧线半径
      clockwise: false, // 是否顺时针绘制
    );
    // final Path path = Path()
    //   ..moveTo(rect.left, rect.bottom) // 起点
    //   ..quadraticBezierTo(rect.width / 2, rect.height + 20, rect.right, rect.bottom) // 二阶贝塞尔曲线
    //   ..lineTo(rect.right, rect.top) // 终点
    //   ..lineTo(rect.left, rect.top) ;// 回到起点
    //
    canvas.drawPath(path, paint);
  }
}