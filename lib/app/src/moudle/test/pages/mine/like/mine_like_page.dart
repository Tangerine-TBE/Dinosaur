import 'dart:convert';

import 'package:app_base/config/size.dart';
import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/util/image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/like/mine_like_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../chart/weight/awesome_chart.dart';

class MineLikePage extends BaseEmptyPage<MineLikeController> {
  const MineLikePage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffeff1f3),
        centerTitle: false,
        title: const Text(
          '我的点赞',
          style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
        ),
      ),
      body: GetBuilder<MineLikeController>(
        builder: (controller) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return _buildItem(index, controller.list[index], context);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: controller.list.length);
        },id: controller.listId,
      ),
    );
  }

  _buildItem(int index, PostsList item, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.naviToDetails(item, index);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
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
                    backgroundImage: loadImageProvider(User.getUserAvator()),
                    radius: 20,
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
                            User.getUserNickName(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                              onTap: () {
                                controller.showBottomSheet();
                              },
                              child: const Icon(Icons.more_horiz)),
                        ],
                      ),
                      Visibility(
                        visible: item.topicTitle.isNotEmpty,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 4),
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
            if (item.content.isNotEmpty)
              SizedBox(
                height: 10,
              ),
            _buildContent(index, item, context),
            Row(
              children: [
                SizedBox(width: 50),
                Icon(
                  Icons.chat,
                  size: 14,
                  color: const Color(
                    0xff8F9098,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  item.commentsNum.toString(),
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
                      Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: MyColors.textGreyColor,
                      ),
                      Text(
                        item.favorsNum.toString(),
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
                        Text(
                          '浏览',
                          style: TextStyle(
                              color: const Color(0xff8F9098),
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          item.viewsNum.toString(),
                          style: TextStyle(
                              color: const Color(0xff8F9098),
                              fontSize: 8,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              color: MyColors.textGreyColor.withOpacity(0.3),
              thickness: 0.3,
            ),
          ],
        ),
      ),
    );
  }

  _buildContent(int index, PostsList item, BuildContext context) {
    // 区分内容
    bool showFullText = false;
    final textPainter = TextPainter(
      text: TextSpan(
        text: item.content,
        style: TextStyle(
            color: MyColors.textBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
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
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
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
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
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
                      item.images,
                      'refresh'),
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
                      animatedInfoKey: 'refresh_page_chart$index',
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
