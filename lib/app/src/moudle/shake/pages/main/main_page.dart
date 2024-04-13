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
        padding: EdgeInsets.symmetric(horizontal: 26),
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
                    color: ShakeColors.mainTitleColor, fontSize: 30),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                '链接设备，马上玩',
                style: TextStyle(
                    color: ShakeColors.mainTitleColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                    color: ShakeColors.mainTitleColor,
                    borderRadius: BorderRadius.all(Radius.circular(17))),
                child: FittedBox(
                  child: Row(
                    children: [
                      const Text(
                        '未连接设备',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Image.asset(
                        ResName.iconLianjie,
                        width: 14,
                        height: 14,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
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
                    height: 188,
                    width: 184,
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
              left: 27,
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
                        fontSize: 18),
                  ),
                  Text(
                    'Start playing',
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
      height: 174,
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
                      fontSize: 18),
                ),
                Text(
                  'Side it',
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
      height: 200,
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
                      fontSize: 18),
                ),
                Text(
                  'Shake it',
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
      height: 200,
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
                      fontSize: 18),
                ),
                Text(
                  'Instructions',
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
      height: 174,
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
                      fontSize: 18),
                ),
                Text(
                  'Share',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
