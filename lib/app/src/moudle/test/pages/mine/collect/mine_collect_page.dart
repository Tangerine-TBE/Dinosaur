import 'dart:convert';
import 'package:app_base/config/size.dart';
import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/util/image.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:app_base/widget/listview/smart_load_more_listview.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/collect/mine_collect_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../chart/weight/awesome_chart.dart';

class MineCollectPage extends BaseEmptyPage<MineCollectController> {
  const MineCollectPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffeff1f3),
        appBar: AppBar(
          backgroundColor: const Color(0xffeff1f3),
          centerTitle: false,
          title: const Text(
            '我的收藏',
            style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize),
          ),
        ),
      body: SafeArea(
        child: Obx(
              () => SmartRefresher(
            onRefresh: () async {
              controller.loadMoreList(true);
            },
            onLoading: () async {
              controller.loadMoreList(false);
            },
            header: WaterDropHeader(
              refresh: SizedBox(
                width: 25.0,
                height: 25.0,
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoActivityIndicator(
                  color: MyColors.themeTextColor,
                )
                    : StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return CircularProgressIndicator(
                        strokeWidth: 2.0, color: MyColors.themeTextColor);
                  },
                ),
              ),
              complete: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.done,
                    color: Colors.black,
                  ),
                  Container(
                    width: 15.0,
                  ),
                  const Text(
                    '刷新完成',
                    style: TextStyle(color: MyColors.textBlackColor),
                  )
                ],
              ),
              waterDropColor: MyColors.themeTextColor,
            ),
            enablePullDown: true,
            enablePullUp: controller.canLoadMore.value,
            footer: CustomFooter(
              builder: (context, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("上拉加载");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("加载失败！点击重试！");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("松手,加载更多!");
                } else {
                  body = const Text("没有更多数据了!");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: controller.refreshController,
            child: CustomScrollView(slivers: [
              GetBuilder<MineCollectController>(
                builder: (controller) {
                  return controller.list.isNotEmpty
                      ? SliverList.separated(
                    itemBuilder: (context, index) {
                      return _buildItem(
                          index, controller.list[index], context);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.list.length,
                  )
                      : const SliverFillRemaining(
                    child: SizedBox(
                      child: NoDataWidget(
                        title: '暂无记录',
                      ),
                    ),
                  );
                },
                id: controller.listId,
              )

            ],),
          ),
        ),
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            User.getUserNickName(),
                            style: const TextStyle(
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
                          const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xffFF5E65).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: '#',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xffFF5E65),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: item.topicTitle,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xffFF5E65),
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
            if(item.content.isNotEmpty)
              const SizedBox(height: 10,),
            _buildContent(index, item, context),
            Row(
              children: [
                const SizedBox(width: 50),
                const Icon(
                  Icons.chat,
                  size: 14,
                  color: Color(
                    0xff8F9098,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  item.commentsNum.toString(),
                  style: const TextStyle(
                    color: Color(0xff8F9098),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  width: 122,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 14,
                        color: MyColors.textGreyColor,),
                      Text(
                        item.favorsNum.toString(),
                        style: const TextStyle(
                          color: Color(0xff8F9098),
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

                        const Text(
                          '浏览',
                          style: TextStyle(
                              color: Color(0xff8F9098),
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          item.viewsNum.toString(),
                          style: const TextStyle(
                              color: Color(0xff8F9098),
                              fontSize: 8,
                              fontWeight: FontWeight.w500),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
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
        style: TextStyle(color: MyColors.textBlackColor,
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
                  style: TextStyle(color: Colors.pink,
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
