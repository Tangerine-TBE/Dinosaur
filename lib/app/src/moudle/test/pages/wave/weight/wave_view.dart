import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



///三阶曲线波形图的反应。
///无限循环
///从左自右
///中心点为X轴
///Y轴为空间最左边
///正Y为数学表达Y
///负Y为数学表达Y
///曲线变化参数由一个List<int>表示 不断从数据源读取，每200ms读取一次，点与点之间由两个控制点控制
///形成曲线 点参数的一半为控制点1.2；
Paint wavePaint = Paint()
  ..isAntiAlias = true
  ..color = const Color(0xffFF5E65)
  ..style = PaintingStyle.stroke
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 2;
 abstract class  WaveController {
  void refresh();
}
class ExternalWaveController implements WaveController {
  WavePainter? wavePainter;
  setWavePainter (WavePainter wavePainter){
    this.wavePainter = wavePainter;
  }

  @override
  void refresh() {
    wavePainter?.refresh();
  }
}
class WavePainter extends CustomPainter  {
  static  final List<int> _processes = [];
  final int process;
  final ExternalWaveController  waveController;
  WavePainter({required this.process,required this.waveController}){
    waveController.setWavePainter(this);
  }
  void add(int data) {
    for(int i = 1 ; i <= _processes.length - 1; i ++){
      _processes[i - 1] =   _processes[i]  ;
    }
    _processes[ _processes.length - 1] = data;
  }
  _changeCanvasAis(Canvas canvas, Size size) {
    canvas.translate(0, size.height); // 将原点移动到底部
    canvas.scale(1, -1); // 垂直方向翻转坐标系
  }


  @override
  void paint(Canvas canvas, Size size) {
    _changeCanvasAis(canvas,size);
    var cellHeight = size.height/1023;
    var cellWidth = size.width / (_processes.length-1);
    _processes.isEmpty?_processes.addAll(List.generate(30, (index) => 0)):_processes;
    add(process);
    //数据反应是0-1023
    var path = Path();
    path.moveTo(0,cellHeight * _processes[0]);
    for (int i = 1; i < _processes.length-1; i++) {
      double prevX = cellWidth * (i - 1);
      double prevY = cellHeight * _processes[i - 1];
      double currentX = cellWidth * i;
      double currentY = cellHeight * _processes[i];
      double nextX = cellWidth * (i + 1);
      double nextY = cellHeight * _processes[i + 1];

      double controlX1 = (prevX + currentX) / 2;
      double controlY1 = (prevY + currentY) / 2;
      double controlX2 = (currentX + nextX) / 2;
      double controlY2 = (currentY + nextY) / 2;
      path.cubicTo(controlX1, controlY1, currentX, currentY, controlX2, controlY2,);
    }
    canvas.drawPath(path, wavePaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void refresh() {
    _processes.clear();
  }

}
