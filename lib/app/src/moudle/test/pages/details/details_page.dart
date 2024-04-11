import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/util/image.dart';
import 'package:app_base/util/time_utils.dart';
import 'package:dinosaur/app/src/moudle/test/pages/details/details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsPage extends BaseEmptyPage<DetailsController> {
  const DetailsPage({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.cardViewBgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: MyColors.cardViewBgColor,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 38.h,
          child: Row(
            children: [
              const BackButton(),
              SizedBox(
                width: 10.w,
              ),
              CircleAvatar(
                backgroundImage: loadImageProvider(controller.item.userAvator),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.item.userName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: MyColors.textBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    timeStampToDateString(controller.item.createTime),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: MyColors.textGreyColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${controller.item.participantNum} 参与 | ${controller.item.viewsNum} 浏览',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          if(controller.focusNode.hasFocus){
            controller.focusNode.unfocus();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 50.w),
                            child: Text(controller.item.content)),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.w),
                          child: controller.imagePreView(
                              controller.item.images
                                  .map((e) => e.imageUrl)
                                  .toList(),
                              context,
                              250.w,
                              controller.index,
                              controller.item.images),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('------  全部评论  ------'),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<DetailsController>(builder: (controller) {
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      sliver: SliverList.separated(
                        itemBuilder: (context, index) {
                          return _buildContentItem(index, controller.list[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20.h,);
                        },
                        itemCount: controller.list.length,
                      ),
                    );
                  },id: controller.listId,)
                ],
              ),
            ),
            SafeArea(
              child: Container(
                color: const Color(0xFFF4F4F4),
                padding: EdgeInsets.only(
                    left: 16.w, top: 10.h, bottom: 10.h, right: 16.w),
                child: Obx(
                  () => Column(
                    children: [
                      Visibility(
                        visible: controller.showSend.value && controller.selectedCommentItem != null,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: loadImageProvider(''),
                              radius: 10.w,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(controller.selectedCommentItem?.content ?? ''),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(fontSize: 16.sp),
                              focusNode: controller.focusNode,
                              controller: controller.editTextController,
                              cursorColor: MyColors.textBlackColor,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: '请输入评论的内容',
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10, right: 10),
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    color: Colors.black, //边线颜色为白色
                                    width: 1, //边线宽度为2
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderRadius: BorderRadius.circular(10.w),
                                  borderSide: const BorderSide(
                                    color: Colors.black, //边线颜色为白色
                                    width: 1, //边线宽度为2
                                  ),
                                ),
                              ),
                              minLines: 1,
                              maxLines: 5,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            width: 80.w,
                            child: !controller.showSend.value
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          controller.onInputLike();
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.heart_broken_rounded,
                                              size: 20.w,
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                  color: MyColors.textGreyColor,
                                                  fontSize: 12.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          controller.onInputCollect();
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.hotel_class,
                                              size: 20.w,
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                  color: MyColors.textGreyColor,
                                                  fontSize: 12.sp),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : MaterialButton(
                                    color: MyColors.themeTextColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.w),
                                        side: const BorderSide(
                                            color: MyColors.textBlackColor)),
                                    onPressed: () {
                                      controller.onInputSubmit();
                                    },
                                    child: const Text('发送'),
                                  ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildContentItem(int index, CommentList item,) {
    return GestureDetector(
      onTap: () {
        controller.onItemComment(item);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        loadImageProvider(controller.item.userAvator),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '我和我的猫咪们',
                        style: TextStyle(
                          color: MyColors.textBlackColor,
                        ),
                      ),
                      Text(
                          timeStampToDayOrHourBefore(item.createTime),
                        style: TextStyle(
                            color: MyColors.textGreyColor, fontSize: 10.sp),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          controller.onItemMoreClick(item);
                        },
                        child: Icon(
                          Icons.more_horiz,
                          size: 20.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Text(item.content)),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.onItemComment(item);
                  },
                  child: Icon(
                    Icons.message,
                    size: 14.w,
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                InkWell(
                  onTap: () {
                    controller.onItemLike();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.heart,
                    size: 14.w,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
