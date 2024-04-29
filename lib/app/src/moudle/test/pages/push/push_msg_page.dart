import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:dinosaur/app/src/moudle/test/pages/push/push_msg_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../chart/weight/awesome_chart.dart';

class PushMsgPage extends BaseEmptyPage<PushMsgController> {
  const PushMsgPage({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cardViewBgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: MyColors.cardViewBgColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const BackButton(),
            SizedBox(
              width: 10,
            ),
            Text(
              '帖子',
              style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  minWidth: 40,
                  height: 30,
                  color: MyColors.themeTextColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    controller.onPushClicked();
                  },
                  child: const Text(
                    '发布',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomAppBar(
        height: kToolbarHeight,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: () {
                  controller.onPicSelectClicked();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.picture_in_picture_alt),
                    SizedBox(
                      height: 2,
                    ),
                    const Text('图片'),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  controller.buildWaveBottomSheet(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_chart_outlined),
                    SizedBox(
                      height: 2,
                    ),
                    const Text('波形'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: Obx(
              () => CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () {
                        controller.buildTagsBottomSheet(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: controller.selectedTag.value.isEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.purple,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.add),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    const Text('选择一个话题'),
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black),
                                      child: Icon(
                                        Icons.tag,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(controller.selectedTag.value),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.selectedTag.value = '';
                                      },
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SliverVisibility(
                    visible: controller.selectedTag.value.isEmpty,
                    sliver: GetBuilder<PushMsgController>(
                      builder: (controller) {
                        return SliverList.builder(
                          itemBuilder: (context, index) {
                            return _buildOptionItem(
                                controller.tagList[index], index, context);
                          },
                          itemCount: controller.tagList.length,
                        );
                      },
                      id: controller.tagListId,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: TextField(
                            controller: controller.editingController,
                            maxLines: null,
                            cursorColor: MyColors.themeTextColor,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '这一刻的想法...'),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GetBuilder<PushMsgController>(
                          builder: (controller) {
                            return controller.imagePreView(
                                controller.selectedImagesObx,
                                context,
                                300,
                                0);
                          },
                          id: controller.imagesListId,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Obx(() => Visibility(
                                visible: controller.selectedWave.isNotEmpty,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 10,
                                      bottom: 10,
                                      right: 10,
                                      left: 10,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: AwesomeChartView(
                                          dataList: <List<int>>[
                                            controller.selectedWave
                                          ],
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          controller.onDeleteWave();
                                        },
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
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

  _buildOptionItem(TopicList item, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.onBottomSheetTagItemClicked(item);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
              child: Icon(
                Icons.tag,
                color: Colors.white,
                size: 14,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(item.title),
          ],
        ),
      ),
    );
  }
}
