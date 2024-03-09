import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:test01/app/src/pages/play/play_fra1_controller.dart';

class PlayFra1Page extends BaseEmptyPage<PlayFra1Controller> {
  const PlayFra1Page({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border(
                        top: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                        left: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                        right: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                        bottom: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  top: 100,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border(
                        top: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                        left: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                        right: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                        bottom: BorderSide(
                          color: MyColors.containerSideColor,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: PicAnimatorBanner(),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton(const Center(
                        child: Text(
                          'button1',
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                      _buildButton(const Center(
                        child: Text(
                          'button2',
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                      _buildButton(const Center(
                        child: Text(
                          'button3',
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            child: Center(child: IconButton(
              icon: Icon( Icons.share),
              onPressed: (){
                controller.onSharePress();
              },
            ),),
          ),
        )
      ],
    );
  }

  Widget _buildButton(Widget buttonStyle) {
    return Container(
      width: 80,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border(
          top: BorderSide(color: MyColors.buildButtonSideColor),
          left: BorderSide(
            color: MyColors.buildButtonSideColor,
          ),
          right: BorderSide(
            color: MyColors.buildButtonSideColor,
          ),
          bottom: BorderSide(
            color: MyColors.buildButtonSideColor,
          ),
        ),
      ),
      child: buttonStyle,
    );
  }
}

class PicAnimatorBanner extends StatefulWidget {
  const PicAnimatorBanner({super.key});

  @override
  State<PicAnimatorBanner> createState() => _PicAnimatorBannerState();
}

class _PicAnimatorBannerState extends State<PicAnimatorBanner> {
  int _imageIndex = 0;
  final List<String> _images = [
    'https://via.placeholder.com/150/0000FF/808080?Text=FirstImage',
    'https://via.placeholder.com/150/FF0000/FFFFFF?Text=SecondImage',
  ];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _imageIndex = (_imageIndex + 1) % _images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Image.network(
        _images[_imageIndex],
        key: ValueKey<int>(_imageIndex),
      ),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
