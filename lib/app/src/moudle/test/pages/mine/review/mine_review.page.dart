import 'package:app_base/config/size.dart';
import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/util/image.dart';
import 'package:app_base/util/time_utils.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:app_base/widget/listview/smart_refresh_listview.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/review/mine_review_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../play/weight/curved_indicator.dart';

class MineReviewPage extends BaseEmptyPage<MineReviewController> {
  const MineReviewPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffeff1f3),
        centerTitle: false,
        title: const Text(
          '我的评论',
          style: TextStyle(
            fontSize: 18,
            color: MyColors.textBlackColor,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffeff1f3),
            automaticallyImplyLeading: false,
            title: TabBar(
              automaticIndicatorColorAdjustment: true,
              unselectedLabelStyle: const TextStyle(
                  color: MyColors.indicatorNormalTextColor,
                  fontSize: SizeConfig.titleTextDefaultSize),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.indicatorSelectedTextColor,
                  fontSize: 18),
              indicatorColor: MyColors.indicatorColor,
              indicatorPadding: const EdgeInsets.only(bottom: 10),
              indicator: CurvedIndicator(),
              splashFactory: NoSplash.splashFactory,
              dividerHeight: 0,
              overlayColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
              tabs: [
                GetBuilder<MineReviewController>(
                  builder: (controller) {
                    return Tab(
                      text: '评论 ${controller.list.length}',
                    );
                  },
                  id: controller.listId,
                ),
                Tab(
                  text: '回复 0',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildCommentContent(),
              _buildReplyContent(),
            ],
          ),
        ),
      ),
    );
  }

  _buildReplyContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      // child: GetBuilder<MineReviewController>(
      //   builder: (controller) {
      //     return ListView.separated(
      //         itemBuilder: (context, index) {
      //           return _buildItem(index);
      //         },
      //         separatorBuilder: (context, index) {
      //           return const SizedBox();
      //         },
      //         itemCount: controller.list.length);
      //   },
      //   id: controller.listId,
      // ),
    );
  }

  _buildCommentContent() {
    return SafeArea(
      child: Container(
        color: const Color(0xffeff1f3),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
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
                                strokeWidth: 2.0,
                                color: MyColors.themeTextColor);
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
              child: CustomScrollView(
                slivers: [
                  GetBuilder<MineReviewController>(
                    builder: (controller) {
                      return controller.list.isNotEmpty
                          ? SliverList.separated(
                              itemBuilder: (context, index) {
                                return _buildContentItem(
                                    index, controller.list[index]);
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildContentItem(
    int index,
    CommentList item,
  ) {
    return GestureDetector(
      onTap: () {
        controller.naviToDetails(item, index);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: loadImageProvider(User.getUserAvator()),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        User.getUserNickName(),
                        style: TextStyle(
                          color: MyColors.textBlackColor,
                        ),
                      ),
                      Text(
                        timeStampToDayOrHourBefore(item.createTime),
                        style: const TextStyle(
                            color: MyColors.textGreyColor, fontSize: 10),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          controller.onItemMoreClick(item);
                        },
                        child: const Icon(
                          Icons.more_horiz,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(item.content)),
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // controller.naviToDetails();
                  },
                  child: const Icon(
                    Icons.message,
                    size: 14,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: () {
                    controller.onItemLike();
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.heart,
                    size: 14,
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
