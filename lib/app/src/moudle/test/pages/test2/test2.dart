import 'dart:async';
import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/test2/test2Controller.dart';

import 'charts_painter.dart';

class test2 extends BaseEmptyPage<Test2Controller> {
  const test2({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        height: 200,
        width: double.infinity,
        child: Obx(() =>CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: ChartsPainter(process:controller.process.value, processMax: 1024),
          willChange: true,
        ),),
      ),
    );
  }
}