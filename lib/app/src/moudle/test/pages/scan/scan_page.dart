import 'dart:ffi';

import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/scan/scan_controller.dart';

class ScanPage extends BaseEmptyPage<ScanController> {
  const ScanPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  AppBar? buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      title: const Text('连接设备'),
      centerTitle: true,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
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
}
