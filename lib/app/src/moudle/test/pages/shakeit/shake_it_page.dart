import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:dinosaur/app/src/moudle/test/pages/shakeit/shake_it_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/shakeit/weight/fill_icon_clipper.dart';

class ShakeItPage extends BaseEmptyPage<ShakeItController> {
  const ShakeItPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return _buildContent02();
  }

  _buildContent01() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          '摇一摇',
          style: TextStyle(
            fontSize: SizeConfig.titleTextDefaultSize,
            color: MyColors.textBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: MyColors.shakeCardBgColor,
                borderRadius: BorderRadius.circular(11)),
            margin: EdgeInsets.only(right: 26, left: 26, top: 26),
            height: 144,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '试着用手晃动手机,体验不同的震感快乐',
                  style: TextStyle(
                    color: MyColors.textBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  child: LayoutBuilder(
                    builder: (context, c) {
                      return Stack(
                        children: [
                          Row(
                            children: List.generate(
                                8,
                                (index) => Image.asset(
                                      ResName.iconFill1,
                                      width: 35,
                                      height: 27,
                                    )),
                          ),
                          Obx(
                            () {
                              controller.onShakeIt(controller.threshold.value);
                              return TweenAnimationBuilder<double>(
                                tween: Tween(end: controller.threshold.value),
                                duration: const Duration(milliseconds: 500),
                                builder: (BuildContext context, double value,
                                    Widget? child) {
                                  return ClipRect(
                                    clipper: FillIconClipper(
                                        offsetValue: value,
                                        vector: controller.vector.round()),
                                    child: Row(
                                      children: List.generate(
                                        8,
                                        (index) => Image.asset(
                                          ResName.iconFill,
                                          width: 35,
                                          height: 27,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 43,
          ),
          Image.asset(
            ResName.imgYao,
            width: 253,
            height: 253,
          )
        ],
      ),
    );
  }

  _buildContent02() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          '摇一摇',
          style: TextStyle(
                    fontSize: SizeConfig.titleTextDefaultSize,
            fontWeight: FontWeight.w700,
            color: MyColors.textBlackColor,
          ),
        ),
      ),
      body: Column(
        children: [
          const Flexible(
            flex: 4,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PicShakeAnimation(),
            ),
          ),
          Flexible(
            flex: 3,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  '试着用手晃动手机,体验不同的震感快乐',
                  style: TextStyle(
                    color: MyColors.textBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  child: LayoutBuilder(
                    builder: (context, c) {
                      return Stack(
                        children: [
                          Row(
                            children: List.generate(
                                8,
                                    (index) => Image.asset(
                                  ResName.iconFill1,
                                  width: 35,
                                  height: 27,
                                )),
                          ),
                          Obx(
                                () {
                              controller.onShakeIt(controller.threshold.value);
                              return TweenAnimationBuilder<double>(
                                tween: Tween(end: controller.threshold.value),
                                duration: const Duration(milliseconds: 500),
                                builder: (BuildContext context, double value,
                                    Widget? child) {
                                  return ClipRect(
                                    clipper: FillIconClipper(
                                        offsetValue: value,
                                        vector: controller.vector.round()),
                                    child: Row(
                                      children: List.generate(
                                        8,
                                            (index) => Image.asset(
                                          ResName.iconFill,
                                          width: 35,
                                          height: 27,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class PicShakeAnimation extends StatefulWidget {
  const PicShakeAnimation({super.key});

  @override
  State<PicShakeAnimation> createState() => _PicShakeAnimationState();
}

class _PicShakeAnimationState extends State<PicShakeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;
  late Animation<double> _shakeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _shakeAnimation = Tween<double>(begin: -10, end: 10 ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: Image.asset(ResName.imgShake,
              width: 299,
              height: 299,),
          ),
        );
      },
    );
  }
}

