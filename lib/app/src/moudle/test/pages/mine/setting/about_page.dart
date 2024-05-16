import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/setting/about_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AboutPage extends BaseEmptyPage<AboutController> {
  const AboutPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffeff1f3),
        title: const Text(
          '关于',
          style: TextStyle(
            fontSize: SizeConfig.titleTextDefaultSize,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(builder: (context, constraints) {
              return Image.asset(
                ResName.logo,
                width: constraints.maxWidth / 3,
                height: constraints.maxWidth / 3,
              );
            }),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'V 1.0.1 (1)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '官网：https://www.miaoaiot.com',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 40,),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: GetBuilder<AboutController>(
                            builder: (controller) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return _buildItem(index);
                  },
                  separatorBuilder: (context, index) {
                    return  Container();
                  },
                  itemCount: controller.list.length,
                );
                            },
                            id: controller.listId,
                          ),
              ))
        ],
      ),
    );
  }

  _buildItem(int index) {
    return InkWell(
      onTap: () => controller.onItemClicked(index),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 10),
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    controller.list[index].title,
                    style: const TextStyle(
                        color: MyColors.textBlackColor, fontSize: 14),
                  ),
                ),
                Expanded(
                    child:    Text(
                    controller.list[index].content.isEmpty
                        ? controller.list[index].hintText
                        : controller.list[index].content,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  )
                ),
                const Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: MyColors.textGreyColor,
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
