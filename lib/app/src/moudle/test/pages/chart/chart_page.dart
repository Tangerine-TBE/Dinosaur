import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/weight/awesome_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_controller.dart';

class ChartPage extends BaseEmptyPage<ChartController> {
  const ChartPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.w)),
        child: AwesomeChartView(
          dataList: controller.list,
        ),
      ),
    );
  }
}

class AwesomeChartView extends StatefulWidget {
  final List<int> dataList;

  const AwesomeChartView({super.key, required this.dataList});

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
      duration: const Duration(milliseconds: 150),
    );

    _animation = IntTween(begin: 0, end: 10).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        logE('${_animation.value}');
        return CustomPaint(
          size: const Size(400, 200),
          painter: AwesomeChart(
              controllerDot: _animation.value,
              dataList: widget.dataList,
              panColor: MyColors.themeTextColor),
        );
      },
    );
    // return CustomPaint(
    //   size: const Size(400, 200),
    //   painter: AwesomeChart(
    //       dataList: List.generate(50, (index) => Random().nextInt(1024)),
    //       panColor: MyColors.themeTextColor),
    // );
  }
}
