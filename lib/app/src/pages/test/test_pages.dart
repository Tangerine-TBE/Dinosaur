import 'dart:async';

import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_seekbar/flutter_advanced_seekbar.dart';
import 'package:test01/app/src/pages/test/test_controller.dart';

class TestPages extends BaseEmptyPage<TestController> {
  const TestPages({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return MaterialButton(
                  onPressed: () {
                    controller.buttonClicked(index);
                  },
                  textColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Text('model$index'),
                );
              },
              itemCount: 12,
            ),
          ),
          Flexible(
            child: Center(
              child: SizedBox(
                width: 200,
                child: AdvancedSeekBar(
                  Colors.red,
                  10,
                  Colors.blue,
                  lineHeight: 5,
                  defaultProgress: 0,
                  scaleWhileDrag: true,
                  percentSplit: 10,
                  percentSplitColor: Colors.green,
                  percentSplitWidth: 1,
                  seekBarStarted: () {},
                  seekBarProgress: (v) {
                    if (!controller.queenSend) {
                      controller.queenSend = true;
                      controller.write(controller.noQueen());
                    }
                    controller.writeData(v);
                  },
                  seekBarFinished: (v) {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
