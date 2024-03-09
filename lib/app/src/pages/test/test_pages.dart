import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:app_base/exports.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            flex: 1,
            child: Container(
              color: MyColors.pageBgColor,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SexSlider(
                      0.0,
                      onValueChanged: (value) async {
                        if (!controller.queenSend) {
                          controller.queenSend = true;
                          controller.write(controller.unQueue());
                        }
                        await controller.processWrite(value);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Obx(
                            () => AbsorbPointer(
                              absorbing: controller.absorb.value,
                              child: Listener(
                                onPointerDown: (_) {
                                  controller.onSliverDown();
                                },
                                onPointerUp: (_) {
                                  controller.onSliverUp();
                                },
                                child: Obx(
                                  () => SexSlider(
                                    controller.processCountDownValue.value,
                                    onValueChanged: (value) {
                                      controller
                                          .onCountDownProcessChanged(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            controller.addModel();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          icon: const Icon(Icons.play_circle),
                                          onPressed: () {
                                            controller.playModel();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: CircularCountDownTimer(
                                      width: double.infinity,
                                      height: double.infinity,
                                      duration: 0,
                                      fillColor: Colors.black,
                                      ringColor: Colors.red,
                                      onChange: (value) {
                                        controller.onCountChange(value);
                                      },
                                      controller:
                                          controller.countDownController,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SexSlider extends StatefulWidget {
  final Function(double value) onValueChanged;
  double value = 0;

  SexSlider(this.value, {super.key, required this.onValueChanged});

  @override
  State<SexSlider> createState() => _SexSliderState();
}

class _SexSliderState extends State<SexSlider> {
  @override
  void initState() {
    super.initState();
  }

  bool isTouchingsSlider = false;

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
        value: widget.value,
        min: 0,
        max: 1023,
        thumbColor: Colors.pink,
        secondaryActiveColor: Colors.white,
        activeColor: Colors.blue,
        onChanged: (value) {
          setState(() {
            widget.value = value;
          });
          widget.onValueChanged.call(value);
        },
      ),
    );
  }
}
