import 'dart:convert';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/util/image.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../weight/loadmore_listview.dart';
import '../../chart/weight/awesome_chart.dart';

class RefreshPage extends StatelessWidget {
  final PetController controller;

  const RefreshPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() =>
          LoadMoreListView.customScrollView(
            onLoadMore:controller.refreshManager.canLoadMore.value? controller.refreshManager.loadMoreList:null,
            loadMoreWidget:controller.refreshManager.canLoadMore.value ?Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(MyColors.themeTextColor),
              ),
            ):null,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.only(right: 18, left: 18, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BannerCarousel.fullScreen(
                        animation: true,
                        height: 106,
                        banners: controller.refreshManager.listBanners,
                        showIndicator: true,
                        indicatorBottom: false,
                        borderRadius: 10,
                        disableColor: const Color(0xffFFFFFF).withOpacity(0.5),
                        activeColor: const Color(0xffFFFFFF),
                        customizedIndicators: const IndicatorModel.animation(
                          width: 5,
                          height: 5,
                          spaceBetween: 4,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              GetBuilder<PetController>(
                builder: (controller) {
                  return controller.refreshManager.dataList.isNotEmpty
                      ? SliverList.builder(
                    itemBuilder: (context, index) {
                      return _buildItem(index,
                          controller.refreshManager.dataList[index], context);
                    },
                    itemCount: controller.refreshManager.dataList.length,
                  )
                      : const SliverFillRemaining(
                    child: SizedBox(
                      child: NoDataWidget(
                        title: '暂无记录',
                      ),
                    ),
                  );
                },
                id: controller.refreshManager.listId,
              ),
            ],
          )
      ),
    );
  }

  _buildItem(int index, PostsList item, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: double.infinity,
      padding: const EdgeInsets.only(left: 18, right: 18,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundImage: loadImageProvider(item.userAvator),radius: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.userName,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                            onTap: () {
                              controller.refreshManager.showBottomSheet();
                            },
                            child: const Icon(Icons.more_horiz)),
                      ],
                    ),
                    Visibility(
                      visible: item.topicTitle.isNotEmpty,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xffFF5E65).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '#',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xffFF5E65),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: item.topicTitle,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xffFF5E65),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildContent(index, item, context),
          Row(
            children: [
              SizedBox(width: 50),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 22,
                color: const Color(
                  0xff8F9098,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                item.viewsNum.toString(),
                style: TextStyle(
                  color: const Color(0xff8F9098),
                  fontSize: 10,
                ),
              ),
              SizedBox(
                width: 122,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      ResName.lovely1,
                      width: 22,
                      height: 22,
                    ),
                    Text(
                      item.likesNum.toString(),
                      style: TextStyle(
                        color: const Color(0xff8F9098),
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.naviToDetails(item, index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.message,
                        size: 22,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '评论',
                        style: TextStyle(
                            color: const Color(0xff8F9098),
                            fontSize: 11,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
            color: MyColors.textGreyColor.withOpacity(0.3),
            thickness: 0.3,
          ),
        ],
      ),
    );
  }

  _buildContent(int index, PostsList item, BuildContext context) {
    // 区分内容
    bool showFullText = false;
    final textPainter = TextPainter(
      text: TextSpan(
        text: item.content,
        style: TextStyle(color: MyColors.textBlackColor, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );
    textPainter.layout(maxWidth: 250);
    if (textPainter.didExceedMaxLines) {
      showFullText = true;
    } else {
      showFullText = false;
    }
    return Row(
      children: [
        SizedBox(
          width: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.content.isNotEmpty)
              SizedBox(
                  width: 250,
                  child: GestureDetector(
                    onTap: () {
                      if (showFullText) {
                        controller.naviToDetails(item, index);
                      }
                    },
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: item.content,
                            style: TextStyle(
                                color: MyColors.textBlackColor,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )),
            if (item.content.isNotEmpty && showFullText)
              InkWell(
                onTap: () {
                  controller.naviToDetails(item, index);
                },
                child: Text(
                  '全文',
                  style: TextStyle(color: Colors.pink, fontSize: 12),
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (item.images.isNotEmpty)
              Column(
                children: [
                  controller.imagePreView(
                      item.images.map((e) => e.imageUrl).toList(),
                      context,
                      250,
                      index,
                      item.images,'refresh'),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            if (item.waves.isNotEmpty && item.waves[0].actions != '[]')
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          MyColors.themeTextColor.withOpacity(0.3),
                          MyColors.themeTextColor.withOpacity(0.5),
                        ])),
                    padding: EdgeInsets.only(top: 10, right: 4, left: 4),
                    child: AwesomeChartView(
                      dataList: <List<int>>[
                        List<int>.from(
                            jsonDecode(item.waves[0].actions) ?? '[]')
                      ],
                      width: 250,
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }
}
