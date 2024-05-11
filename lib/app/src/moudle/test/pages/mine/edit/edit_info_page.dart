import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
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
                                        child: controller.images[0].isEmpty
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
                                                child: controller.images[0]
                                                        .startsWith('http')
                                                    ? CachedNetworkImage(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        imageUrl: controller
                                                            .images[0],
                                                      )
                                                    : loadImageByPath(
                                                        controller.images[0],
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
                                              child: controller
                                                      .images[1].isEmpty
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
                                                      child: controller.images[1]
                                                          .startsWith('http')
                                                          ? CachedNetworkImage(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        imageUrl: controller
                                                            .images[1],
                                                      )
                                                          : loadImageByPath(
                                                        controller.images[1],
                                                        double.infinity,
                                                        double.infinity,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Flexible(
                                            child: InkWell(
                                              onTap: controller.onImage3Clicked,
                                              child: controller
                                                      .images[2].isEmpty
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
                                                      child: controller.images[2]
                                                          .startsWith('http')
                                                          ? CachedNetworkImage(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        imageUrl: controller
                                                            .images[2],
                                                      )
                                                          : loadImageByPath(
                                                        controller.images[2],
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
                                        child: controller.images[3].isEmpty
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
                                                child: controller.images[3]
                                                    .startsWith('http')
                                                    ? CachedNetworkImage(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  imageUrl: controller
                                                      .images[3],
                                                )
                                                    : loadImageByPath(
                                                  controller.images[3],
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
                                          child: controller.images[4].isEmpty
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
                                                  child: controller.images[4]
                                                      .startsWith('http')
                                                      ? CachedNetworkImage(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    imageUrl: controller
                                                        .images[4],
                                                  )
                                                      : loadImageByPath(
                                                    controller.images[4],
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
                                          child: controller.images[5].isEmpty
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
                                                  child:controller.images[5]
                                                      .startsWith('http')
                                                      ? CachedNetworkImage(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    imageUrl: controller
                                                        .images[5],
                                                  )
                                                      : loadImageByPath(
                                                    controller.images[5],
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
                  child: Text(
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
