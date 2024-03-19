import 'package:app_base/constant/constants.dart';
import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:test01/app/src/moudle/test/pages/mine/mine_controller.dart';

class MinePage extends BaseEmptyPage<MineController> {
  const MinePage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.pageBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.pageBgColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 405.h,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      MyColors.bgLinearShapeColor1,
                      MyColors.bgLinearShapeColor2,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        ResName.mineBg,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 248.h,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26.w),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: controller
                              .buildTitleItem()
                              .map<Widget>(
                                  (e) => _buildTitleBar(e.name, e.assetName))
                              .toList(),
                        ),
                        SizedBox(height: 24.h),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return _buildContentItem(
                                  controller.buildLineItem()[index].name,
                                  controller.buildLineItem()[index].assetName);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox();
                            },
                            itemCount: controller.buildLineItem().length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildContentItem(String name, String assetName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        children: [
          Image.asset(
            assetName,
            width: 24.w,
            height: 24.w,
          ),
          SizedBox(width:8.w,),
          Expanded(child: Text(name)),
          Icon(Icons.arrow_right, size: 26.w),
        ],
      ),
    );
  }

  _buildTitleBar(String name, String assetName) {
    return Column(
      children: [
        Image.asset(
          assetName,
          width: 32.w,
          height: 32.w,
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          name,
          style: const TextStyle(
            color: MyColors.textBlackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
