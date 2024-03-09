import 'dart:async';
import 'dart:math';

import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            child: Row(
              children: [
                Flexible(
                  child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: SexSlider(
                      onValueChanged: (value) async {
                        if (!controller.queenSend) {
                          controller.queenSend = true;
                          controller.write(controller.unQueue());
                        }
                        await controller.processWrite(value);
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Transform.rotate(
                    angle: -90 * pi / 180,
                    child: SexSlider(
                      onValueChanged: (value) async {
                        // if (!controller.queenSend) {
                        //   controller.queenSend = true;
                        //   controller.write(controller.unQueue());
                        // }
                        // await controller.processWrite(value);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SexSlider extends StatefulWidget {
  final Function(double value) onValueChanged;

  const SexSlider({super.key, required this.onValueChanged});

  @override
  State<SexSlider> createState() => _SexSliderState();
}

class _SexSliderState extends State<SexSlider> {
  double value = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.blue,
        trackShape: const RoundedRectSliderTrackShape(),
        trackHeight: 20.0,
        thumbColor: Colors.blueAccent,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
      ),
      child: Slider(
        value: value,
        min: 0,
        max: 1023,
        thumbColor: Colors.pink,
        secondaryActiveColor: Colors.white,
        activeColor: Colors.blue,
        onChanged: (value) {
          setState(() {
            this.value = value;
            widget.onValueChanged.call(value);
          });
        },
      ),
    );
  }
}
