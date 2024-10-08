import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/edit/edit_info_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditInfoPage extends BaseEmptyPage<EditInfoController> {
  const EditInfoPage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
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
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: MyColors.pageBgColor,
            automaticallyImplyLeading: true,
            title: const Text(
              '个人资料',
              style: TextStyle(
                fontSize: SizeConfig.titleTextDefaultSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: Obx(() => Column(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: InkWell(
                                        onTap: controller.onImage1Clicked,
                                        child: controller
                                                .imagesObxAvator.value.isEmpty
                                            ? Container(
                                                decoration: const BoxDecoration(
                                                  color: MyColors.textGreyColor,
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                decoration: const BoxDecoration(
                                                  color: MyColors.textGreyColor,
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: controller
                                                        .imagesObxAvator.value
                                                        .startsWith('http')
                                                    ? CachedNetworkImage(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        imageUrl: controller
                                                            .imagesObxAvator
                                                            .value)
                                                    : loadImageByPath(
                                                        controller
                                                            .imagesObxAvator
                                                            .value,
                                                        double.infinity,
                                                        double.infinity,
                                                      ),
                                              ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Flexible(
                                            child: InkWell(
                                              onTap: controller.onImage2Clicked,
                                              child: controller.imagesObxValue1
                                                      .value.isEmpty
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: MyColors
                                                            .textGreyColor,
                                                        border: const Border(
                                                          right: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        color: MyColors
                                                            .textGreyColor,
                                                        border: const Border(
                                                          right: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      child: controller
                                                              .imagesObxValue1
                                                              .value
                                                              .startsWith(
                                                                  'http')
                                                          ? CachedNetworkImage(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              imageUrl: controller
                                                                  .imagesObxValue1
                                                                  .value,
                                                            )
                                                          : loadImageByPath(
                                                              controller
                                                                  .imagesObxValue1
                                                                  .value,
                                                              double.infinity,
                                                              double.infinity,
                                                            ),
                                                    ),
                                            ),
                                          ),
                                          Flexible(
                                            child: InkWell(
                                              onTap: controller.onImage3Clicked,
                                              child: controller.imagesObxValue2
                                                      .value.isEmpty
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: MyColors
                                                            .textGreyColor,
                                                        border: const Border(
                                                          right: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        color: MyColors
                                                            .textGreyColor,
                                                        border: const Border(
                                                          right: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.white,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      child: controller
                                                              .imagesObxValue2
                                                              .value
                                                              .startsWith(
                                                                  'http')
                                                          ? CachedNetworkImage(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              imageUrl: controller
                                                                  .imagesObxValue2
                                                                  .value,
                                                            )
                                                          : loadImageByPath(
                                                              controller
                                                                  .imagesObxValue2
                                                                  .value,
                                                              double.infinity,
                                                              double.infinity,
                                                            ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: controller.onImage4Clicked,
                                        child: controller
                                                .imagesObxValue3.value.isEmpty
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: MyColors.textGreyColor,
                                                  border: const Border(
                                                    right: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: MyColors.textGreyColor,
                                                  border: const Border(
                                                    right: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: controller
                                                        .imagesObxValue3.value
                                                        .startsWith('http')
                                                    ? CachedNetworkImage(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        imageUrl: controller
                                                            .imagesObxValue3
                                                            .value,
                                                      )
                                                    : loadImageByPath(
                                                        controller
                                                            .imagesObxValue3
                                                            .value,
                                                        double.infinity,
                                                        double.infinity,
                                                      ),
                                              ),
                                      ),
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: controller.onImage5Clicked,
                                          child: controller
                                                  .imagesObxValue4.value.isEmpty
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        MyColors.textGreyColor,
                                                    border: const Border(
                                                      right: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        MyColors.textGreyColor,
                                                    border: const Border(
                                                      right: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: controller
                                                          .imagesObxValue4.value
                                                          .startsWith('http')
                                                      ? CachedNetworkImage(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          imageUrl: controller
                                                              .imagesObxValue4
                                                              .value,
                                                        )
                                                      : loadImageByPath(
                                                          controller
                                                              .imagesObxValue4
                                                              .value,
                                                          double.infinity,
                                                          double.infinity,
                                                        ),
                                                ),
                                        )),
                                    Flexible(
                                      flex: 1,
                                      child: InkWell(
                                        child: InkWell(
                                          onTap: controller.onImage6Clicked,
                                          child: controller
                                                  .imagesObxValue5.value.isEmpty
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        MyColors.textGreyColor,
                                                    border: const Border(
                                                      right: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        MyColors.textGreyColor,
                                                    border: const Border(
                                                      right: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                      bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: controller
                                                          .imagesObxValue5.value
                                                          .startsWith('http')
                                                      ? CachedNetworkImage(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          imageUrl: controller
                                                              .imagesObxValue5
                                                              .value,
                                                        )
                                                      : loadImageByPath(
                                                          controller
                                                              .imagesObxValue5
                                                              .value,
                                                          double.infinity,
                                                          double.infinity,
                                                        ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              GetBuilder<EditInfoController>(
                builder: (controller) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(left: 30),
                    sliver: SliverList.builder(
                      itemBuilder: (context, index) {
                        return _buildItem(index);
                      },
                      itemCount: controller.listData.length,
                    ),
                  );
                },
                id: controller.listId,
              ),
            ],
          ),
        )
      ],
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
                  width: 100,
                  child: Text(
                    controller.listData[index].title,
                    style: const TextStyle(
                        color: MyColors.textGreyColor, fontSize: 14),
                  ),
                ),
                Expanded(
                  child: index != 1
                      ? Text(
                          controller.listData[index].content.isEmpty
                              ? controller.listData[index].hintText
                              : controller.listData[index].content,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        )
                      : controller.listData[index].content.isNotEmpty
                          ? AudioWave(
                              height: 20,
                              width: 90,
                              spacing: 2.5,
                              animation: false,
                              bars: [
                                AudioWaveBar(
                                    heightFactor: 0.2, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.3, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.4, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.4, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.1, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.9, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.2, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.3, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.2, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.4, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.8, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.4, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.3, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.2, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 1.0, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.5, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.6, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.7, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.3, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.2, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.4, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.4, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 0.7, color: Colors.black),
                                AudioWaveBar(
                                    heightFactor: 1.0, color: Colors.black),
                              ],
                            )
                          : Text(
                              controller.listData[index].content.isEmpty
                                  ? controller.listData[index].hintText
                                  : controller.listData[index].content,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
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
