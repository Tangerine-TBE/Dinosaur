import 'dart:async';

import 'package:app_base/exports.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class MainPage extends BaseEmptyPage {
  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: MyColors.pageBgColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: MyColors.pageBgColor,
            title: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
              TabBar(
                isScrollable: true,
                unselectedLabelStyle: TextStyle(
                    color: MyColors.indicatorNormalTextColor, fontSize: 16),
                labelStyle: TextStyle(
                    color: MyColors.indicatorSelectedTextColor, fontSize: 24),
                indicatorColor: MyColors.indicatorColor,
                indicatorPadding: EdgeInsets.only(bottom: 5),
                indicatorSize: TabBarIndicatorSize.label,
                dividerHeight: 0,
                indicatorWeight: 1,

                tabs: [
                  Tab(
                    text: '自己玩',
                  ),
                  Tab(
                    text: '远程遥控',
                  ),
                ],
              )
            ],),
          ),
        ),
        body: TabBarView(children: [
            build01(),
            Container()
        ],),
      ),
    );
  }
}

class PicAnimatorBanner extends StatefulWidget {
  const PicAnimatorBanner({super.key});

  @override
  State<PicAnimatorBanner> createState() => _PicAnimatorBannerState();
}

Widget build01() {
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
                        color: Colors.black,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                      ),
                      bottom: BorderSide(color: Colors.black),
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
                        color: Colors.black,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                      ),
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Row(
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
                    Container(
                      width: 80,
                      height: 50,
                      child: Center(child: Text('按钮1')),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                          ),
                          bottom: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                        width: 80,
                        height: 50,
                        child: Center(child: Text('按钮2')),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                            ),
                            left: BorderSide(
                              color: Colors.black,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                            ),
                            bottom: BorderSide(color: Colors.black),
                          ),
                        )),
                    Container(
                        width: 80,
                        height: 50,
                        child: Center(child: Text('按钮3')),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                            ),
                            left: BorderSide(
                              color: Colors.black,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                            ),
                            bottom: BorderSide(color: Colors.black),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Flexible(child: Container(),flex: 3,)
    ],
  );
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
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
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
      duration: Duration(seconds: 1),
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
