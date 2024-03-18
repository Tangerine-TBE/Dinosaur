import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/scan/scan_controller.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:test01/app/src/moudle/test/pages/play/weight/curved_indicator.dart';

class ScanPage extends BaseEmptyPage<ScanController> {
  const ScanPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return _buildContent01();
  }

  _buildContent01() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0.0,
            centerTitle: true,
            title: TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              unselectedLabelStyle: TextStyle(
                  color: MyColors.scanIndicatorTextNormalColor,
                  fontSize: 16.sp),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.scanIndicatorTextSelectedColor,
                  fontSize: 18.sp),
              indicatorPadding: EdgeInsets.only(left: 22.w, right: 22.w),
              indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.w),
                  ),
                  borderSide: BorderSide(
                      width: 4.h, color: MyColors.scanIndicatorColor)),
              indicatorSize: TabBarIndicatorSize.label,
              splashFactory: NoSplash.splashFactory,
              dividerHeight: 0,
              overlayColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
              tabs: const [
                Tab(
                  text: '连接蓝牙',
                ),
                Tab(
                  text: '使用教程',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildConnection(),
              _buildUseIntroduction(),
            ],
          )),
    );
  }

  _buildUseIntroduction() {
    return Container();
  }

  _buildConnection() {
    return Column(
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: 1,
                duration: Duration(
                  milliseconds: 200,
                ),
                child: Image.asset(
                  ResName.looperGroup,
                  width: 144.w,
                  height: 144.w,
                ),
              ),
              SizedBox(
                height: 61.h,
              ),
              Text(
                '搜索设备中...',
                style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
          flex: 1,
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '发现设备:',
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: GetBuilder<ScanController>(
                    builder: (controller) {
                      return ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return _buildDeviceItem01(
                                controller.devices[index].device.platformName,
                                index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20.h,
                            );
                          },
                          itemCount: controller.devices.length);
                    },
                    id: controller.devicesListId,
                  ),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }

  _buildContent() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 90.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColors.cardViewBgColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(11.w),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Obx(
                            () => Container(
                              margin: EdgeInsets.only(top: 10.h, right: 10.h),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: controller.bluetoothState.value !=
                                        '蓝牙状态: 未开启'
                                    ? Colors.green
                                    : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '连蓝牙',
                          style: TextStyle(
                              color: MyColors.textBlackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => Text(
                            controller.bluetoothState.value,
                            style: TextStyle(
                              color: MyColors.textGreyColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 19.w,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 90.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColors.cardViewBgColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(11.w),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top: 10.h, right: 10.h),
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          '使用教程',
                          style: TextStyle(
                              color: MyColors.textBlackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '无法连接点击这里',
                          style: TextStyle(
                            color: MyColors.textGreyColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Image.asset(
              ResName.gifAixin,
              width: 300.w,
              height: 300.w,
            ),
            Text(
              '设备搜索中...',
              style: TextStyle(color: Colors.pink),
            ),
            SizedBox(
              height: 40.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '发现设备: ',
                        style: TextStyle(color: MyColors.textBlackColor),
                      ),
                      TextSpan(
                        text: controller.devicesSize.value.toString(),
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<ScanController>(
                builder: (controller) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return _buildDeviceItem(
                          controller.devices[index].device.platformName, index);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 20.h,
                      );
                    },
                    itemCount: controller.devices.length,
                  );
                },
                id: controller.devicesListId,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDeviceItem(String name, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(color: MyColors.textBlackColor, fontSize: 20.sp),
        ),
        TextButton(
          onPressed: () {
            controller.onDeviceSelected(index);
          },
          child: const Text(
            '连接',
            style: TextStyle(color: Colors.pink),
          ),
        )
      ],
    );
  }

  _buildDeviceItem01(String name, int index) {
    return SizedBox(
      height: 72.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.scanItemDeviceBgColor01,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.w),
                bottomLeft: Radius.circular(12.w),
              ),
            ),
            height: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 18.w),
            child: Image.asset(
              ResName.iconDevice01,
              width: 43.w,
              height: 24.h,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.scanItemDeviceBgColor02,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.w),
                  bottomRight: Radius.circular(12.w),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 14.sp, color: MyColors.textBlackColor),
                        ),
                        Text(
                          '第二代',
                          style: TextStyle(
                              fontSize: 12.sp, color: MyColors.textGreyColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.onDeviceSelected(index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.w),border:Border.fromBorderSide(BorderSide(color: Colors.red,width: 1.w))),
                      child: Text(
                        '连接',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
