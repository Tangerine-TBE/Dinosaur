import 'dart:async';
import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:dinosaur/app/src/moudle/test/pages/test/play_fra1_controller.dart';

class PlayFra1Page extends BaseEmptyPage<PlayFra1Controller> {
  const PlayFra1Page({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Container(width:20,height:20,color: Colors.transparent,);
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
