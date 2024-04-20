import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/wave/wave_form_demo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class WaveFormDemoPage extends BaseEmptyPage<WaveFormDemoController> {
  const WaveFormDemoPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '波形预览',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Container(
        child: Center(
          child: Text('波形预览界面'),
        ),
      ),
    );
  }
}
