import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:dinosaur/app/src/moudle/test/pages/push/push_msg_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

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
              width: 10.w,
            ),
            Text(
              '帖子',
              style: TextStyle(fontSize: 20.sp),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  minWidth: 40.w,
                  height: 30.h,
                  color: MyColors.themeTextColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  onPressed: () {},
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: 40.w,
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
                      height: 2.h,
                    ),
                    const Text('图片'),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_chart_outlined),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Text('波形'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: Obx(
              () => CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () {
                        controller.buildBottomSheet(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 30.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: controller.selectedTag.value.isEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
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
                                      width: 10.w,
                                    ),
                                    const Text('选择一个话题'),
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
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
                                        size: 14.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(controller.selectedTag.value),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.selectedTag.value = '';
                                      },
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        size: 22.w,
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
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          maxLines: null,
                          cursorColor: MyColors.themeTextColor,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: '这一刻的想法...'),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Obx(
                          () => controller.imagePreView(
                              controller.selectedImages, context, 250.w, 0),
                        ),
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
        controller.onBottomSheetItemClicked(item);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
              child: Icon(
                Icons.tag,
                color: Colors.white,
                size: 14.w,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(item.title),
          ],
        ),
      ),
    );
  }
}
