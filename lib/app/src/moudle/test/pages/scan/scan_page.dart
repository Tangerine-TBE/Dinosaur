import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dinosaur/app/src/moudle/test/pages/scan/scan_controller.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/weight/curved_indicator.dart';

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
    return SingleChildScrollView(
      child: Container(padding:EdgeInsets.only(left: 20.w,right: 20.w,bottom: 20.h
      ),child: Text('''●连接产品准备工作
确保蓝牙与位置信息(定位)已打开，否则无法使用
●开始连接
第一步：通过扫描二维码下载“小萌宠APP”。
第二步：打开小萌宠APP，按照指引注册并登陆APP。
第三步：打开“玩耍”页面，点击“马上玩”，连接设备。
第四步：长按产品的开机键开机。
第五步：点击搜索出来的设备【连接】。
●远程控制/异地遥控
连接设备之后，进入“玩耍”页面，点击“远程遥控—点击分享遥控”，可以分享链接给另一方进行操控，中途不可退出，任何一方退出后需要重新分享遥控。
●波形
分享自己喜爱的波形，或体验其他萌友分享的波形。
●萌宠圈
遵守小萌宠社区公约，文明有爱地分享萌趣生活。
●消息
找好友，聊天记录，评论记录。


常见问题
Q：不能顺利连接
A：1、确保蓝牙已打开，并开启定位或授权位置信息；
充电以保持电量充足：未连接蓝牙时无法判断电量，需要插上充电线进行一次完整的充电，充电指示灯从闪烁到常亮即充电完成。
确保小萌宠APP是最新版本：点击头像进入侧边栏，进入设置—关于，可以看到是否是最新到版本。
确保蓝牙不要同时连接其他电子设备，如蓝牙耳机等。
如以上都尝试过，仍无法顺利连接设备，清重启手机后卸载重新安装小萌宠APP，按正确的连接方法再试一次。
如果仍然无法连接，请在“APP—客服中心—联系客服”操作，将有专人为您解决问题。

Q：遥控中突然断开连接或者搜索不到设备
A：请确保电量充足，然后重新连接设备。
'''),),
    );
  }

  _buildConnection() {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeartbeatAnimation(),
              SizedBox(
                height: 61.h,
              ),
              DotAnimation(),
            ],
          ),
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
                    onTap: () {
                      controller.onDeviceSelected(index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.w),
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.red, width: 1.w))),
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

class DotAnimation extends StatefulWidget {
  const DotAnimation({super.key});

  @override
  _DotAnimationState createState() => _DotAnimationState();
}

class _DotAnimationState extends State<DotAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _animation = IntTween(begin: 0, end: 3).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String dots = '.' * _animation.value;
        return Text(
          '设备搜索中$dots',
          style: TextStyle(
            color: MyColors.textBlackColor,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
          ),
        );
      },
    );
  }
}

class HeartbeatAnimation extends StatefulWidget {

  //1.开始
  //2.会动的心跳，easyInOut
  //3.完毕








  const HeartbeatAnimation({super.key});

  @override
  _HeartbeatAnimationState createState() => _HeartbeatAnimationState();
}

class _HeartbeatAnimationState extends State<HeartbeatAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
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
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Image.asset(ResName.iconScan, width: 80.w, height: 80.w),
        );
      },
    );
  }
}
