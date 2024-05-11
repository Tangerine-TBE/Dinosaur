import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/edit/weight/circle_border.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

enum RecordStatus {
  refreshRecord,
  startRecord,
  endRecord,
  finishRecord,
}

enum PlayStatus {
  startPlay,
  stopPlay,
}

class RecordSoundView extends StatefulWidget {
  final Function recordEndCallback;
  final Future<void> Function() recordStartCallback;
  final Function saveRecordClicked;
  final Function dismissRecordClicked;
  final Function startPlayed;
  final Function stopPlayed;

  const RecordSoundView({
    super.key,
    required this.recordEndCallback,
    required this.recordStartCallback,
    required this.saveRecordClicked,
    required this.dismissRecordClicked,
    required this.startPlayed,
    required this.stopPlayed,
  });

  @override
  State<RecordSoundView> createState() => _RecordSoundViewState();
}

class _RecordSoundViewState extends State<RecordSoundView>
    with SingleTickerProviderStateMixin {
  late AnimationController _commonController;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _customCircleBorderAnimation;
  late AnimationStatusListener iconScaleListener;
  late AnimationStatusListener circleBorderListener;
  Timer? timer;
  var recordStatus = RecordStatus.refreshRecord;
  var playStatus = PlayStatus.stopPlay;

  @override
  void initState() {
    _commonController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    iconScaleListener = (animation) async {
      if (animation == AnimationStatus.completed) {
        if (recordStatus == RecordStatus.refreshRecord) {
         await widget.recordStartCallback.call();
          recordStatus = RecordStatus.startRecord;
          _commonController.removeStatusListener(iconScaleListener);
          _commonController.duration = const Duration(seconds: 30);
          _customCircleBorderAnimation.addStatusListener(circleBorderListener);
          _commonController.reset();
          _commonController.forward();
        }
      } else if (animation == AnimationStatus.dismissed) {
        if (recordStatus == RecordStatus.endRecord) {
          setState(() {
            recordStatus = RecordStatus.finishRecord;
          });
        }
      }
    };
    circleBorderListener = (animation) {
      if (animation == AnimationStatus.completed) {
        widget.recordEndCallback.call();
        recordStatus = RecordStatus.endRecord;
        _commonController.removeStatusListener(circleBorderListener);
        _commonController.duration = const Duration(seconds: 1);
        _customCircleBorderAnimation.addStatusListener(iconScaleListener);
        _commonController.reverse();
      }
    };

    _iconScaleAnimation =
        Tween<double>(begin: 75, end: 100).animate(_commonController);
    _customCircleBorderAnimation =
        Tween<double>(begin: 0, end: 30).animate(_commonController);
    _iconScaleAnimation.addStatusListener(iconScaleListener);

    super.initState();
  }

  recordStart() async{
    PermissionStatus status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      showToast('获取权限才可录制哦');
    }else{
      _commonController.forward();
    }
  }

  recordEnd() {
    recordStatus = RecordStatus.endRecord;
    widget.recordEndCallback.call();
  }

  @override
  void dispose() {
    _commonController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: recordStatus == RecordStatus.finishRecord ? 1.0 : 0.0,
                child: InkWell(
                    onTap: () {
                      setState(
                        () {
                          recordStatus = RecordStatus.refreshRecord;
                        },
                      );
                    },
                    child: const Icon(Icons.cancel_outlined, size: 40)),
              ),
              AnimatedBuilder(
                builder: (context, child) {
                  return CustomPaint(
                    painter: RecordStatus.startRecord.name == recordStatus.name
                        ? CustomCirCleBorder(
                            seconds: _customCircleBorderAnimation.value,
                            radius: constraints.maxHeight / 3 * 2,
                            textSize: 12,
                          )
                        : null,
                    child: InkWell(
                      onTap: () {
                        if (recordStatus.name ==
                            RecordStatus.refreshRecord.name) {
                          recordStart();
                        } else if (recordStatus == RecordStatus.finishRecord) {
                          if (playStatus == PlayStatus.stopPlay) {
                            setState(() {
                              playStatus = PlayStatus.startPlay;
                              widget.startPlayed.call();

                            });
                          } else {
                            setState(() {
                              playStatus = PlayStatus.stopPlay;
                              widget.stopPlayed.call();
                            });
                          }
                        }
                      },
                      child: Icon(
                        recordStatus.name == RecordStatus.finishRecord.name
                            ? playStatus == PlayStatus.stopPlay
                                ? Icons.not_started
                                : Icons.pause_circle
                            : Icons.mic,
                        size: recordStatus.name != RecordStatus.startRecord.name
                            ? _iconScaleAnimation.value
                            : 100,
                      ),
                    ),
                  );
                },
                animation: _commonController,
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: recordStatus == RecordStatus.finishRecord ? 1.0 : 0.0,
                child: InkWell(
                  onTap: () {
                    widget.saveRecordClicked.call();
                    setState(() {
                      recordStatus = RecordStatus.refreshRecord;
                    });
                  },

                  child: const Icon(Icons.done, size: 40),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
