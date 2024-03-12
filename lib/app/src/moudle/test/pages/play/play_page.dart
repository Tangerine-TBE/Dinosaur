import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:test01/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:test01/app/src/moudle/test/pages/play/weight/curved_indicator.dart';

class PlayPage extends BaseEmptyPage<PlayController> {
  const PlayPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.bgLinearShapeColor1,
                MyColors.bgLinearShapeColor2,
              ], begin: Alignment.topCenter, end: Alignment.center),
            ),
          ),
          Scaffold(
            backgroundColor: MyColors.pageBgColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(64.h),
              child: AppBar(
                backgroundColor: MyColors.pageBgColor,
                automaticallyImplyLeading: false,
                elevation: 0.0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      unselectedLabelStyle: TextStyle(
                          color: MyColors.indicatorNormalTextColor,
                          fontSize: 16.sp),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.indicatorSelectedTextColor,
                          fontSize: 18.sp),
                      indicatorColor: MyColors.indicatorColor,
                      indicatorPadding: EdgeInsets.only(bottom: 10.h),
                      indicator: CurvedIndicator(),
                      indicatorSize: TabBarIndicatorSize.label,
                      splashFactory: NoSplash.splashFactory,
                      dividerHeight: 0,
                      padding: EdgeInsets.only(left: 20.w),
                      labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
                      overlayColor: const MaterialStatePropertyAll<Color>(
                          Colors.transparent),
                      tabs: const [
                        Tab(
                          text: '自己玩',
                        ),
                        Tab(
                          text: '远程遥控',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              child: TabBarView(
                children: [
                  _buildFra1Content(),
                  _buildFra2Content(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildFra1Content() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(
            height: 282.h,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 26.h,
                  child: Image.asset(
                    ResName.iconImg,
                    width: 150.w,
                    height: 176.h,
                  ),
                ),
                Positioned(
                  left: 49.w,
                  top: 50.h,
                  child: Text(
                    '点我\r\n连接设备哦',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: MyColors.textBlackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                        color: MyColors.F7F7F7,
                        borderRadius: BorderRadius.circular(8.w),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.grey,
                            offset: const Offset(2, 2),
                            blurRadius: 4.h,
                            spreadRadius: 0,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ResName.iconSide,
                              width: 46.h,
                              height: 46.h,
                            ),
                             Text('划一划',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: MyColors.textBlackColor,),)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ResName.iconShake,
                              width: 46.h,
                              height: 46.h,
                            ),
                             Text('摇一摇',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: MyColors.textBlackColor,),),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ResName.iconModel,
                              width: 46.h,
                              height: 46.h,
                            ),
                             Text('模式',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: MyColors.textBlackColor,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '话题中心',
              style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return _centerItem(controller.data[index],(){});
            },
            itemCount: controller.data.length,
          ))
        ],
      ),
    );
  }

  _centerItem(TopPicCenterBean bean,Function onPress) {
    return SizedBox(
      height: 70.h,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.h),
            child: Image.network(
              bean.imgUrl,
              width: 64.h,
              height: 64.h,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left:12.w ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bean.title,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    bean.preTitle,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Text(
                            bean.subTitle,
                            style: TextStyle(
                                fontSize: 11.sp, color: MyColors.textGreyColor),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Text(
                            bean. date,
                            style: TextStyle(
                                fontSize: 11.sp, color: MyColors.textGreyColor),
                          ),
                        )
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

  _buildFra2Content() {
    return Container(
      color: Colors.red,
    );
  }
}
