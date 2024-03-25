import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:dinosaur/app/src/moudle/shake/pages/main/main_controller.dart';
import 'package:app_base/res/shake_colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainPage extends BaseEmptyPage<MainController> {
  const MainPage({super.key});

  @override
  Color get background => ShakeColors.mainBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Column(
          children: [
            _buildMainTitleBar(),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  _buildModelBar(),
                  _buildContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainTitleBar() {
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: SizedBox()),
              Text(
                'HI，XHT',
                style: TextStyle(
                    color: ShakeColors.mainTitleColor, fontSize: 30.sp),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                '链接设备，马上玩',
                style: TextStyle(
                    color: ShakeColors.mainTitleColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                decoration: BoxDecoration(
                    color: ShakeColors.mainTitleColor,
                    borderRadius: BorderRadius.all(Radius.circular(17.h))),
                child: FittedBox(
                  child: Row(
                    children: [
                      const Text(
                        '未连接设备',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Image.asset(
                        ResName.iconLianjie,
                        width: 14.h,
                        height: 14.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              )
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 23,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    ResName.imgBanner,
                    height: 188.h,
                    width: 184.w,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildModelBar() {
    return Flexible(
      flex: 1,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ResName.imgMyModel),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 27.w,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '开始玩',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp),
                  ),
                  Text(
                    'Start playing',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Flexible(
      flex: 2,
      child: MasonryGridView.count(
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return index == 0
              ? _buildSideItCell()
              : index == 1
                  ? _buildShakeItCell()
                  : index == 2
                      ? _buildInstructions()
                      : index == 3
                          ? _buildShare()
                          : _buildSideItCell();
        },
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildSideItCell() {
    return Container(
      height: 174.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ResName.imgSideIt),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '划一划',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp),
                ),
                Text(
                  'Side it',
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShakeItCell() {
    return Container(
      height: 200.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ResName.imgShakeIt),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '摇一摇',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp),
                ),
                Text(
                  'Shake it',
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ResName.imgInstructions),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '使用教程',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp),
                ),
                Text(
                  'Instructions',
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShare() {
    return Container(
      height: 174.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ResName.imgShare),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '分享遥控',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp),
                ),
                Text(
                  'Share',
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
