import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'select_device_controller.dart';

class SelectDevicePage extends BaseEmptyPage<SelectDeviceController> {
  const SelectDevicePage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff1f3),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xffeff1f3),
        title: const Text(
          '选择品牌',
          style: TextStyle(
            fontSize: SizeConfig.titleTextDefaultSize,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: GetBuilder<SelectDeviceController>(
            builder: (controller) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return _buildItem(index);
                },
                itemCount: 10,
              );
            },
            id: controller.listId,
          ),
        ),
      ),
    );
  }

  _buildItem(int index) {
    return Card(
      elevation: 6,
      color: Colors.white,
      child: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: loadImage(
                'https://via.placeholder.com/150/0000F0/808080?Text=Image0',
                constraints.maxWidth,
                constraints.maxWidth,
              ),
            );
          }),
          Text('蓝牙设备01'),
        ],
      ),
    );
  }
}
