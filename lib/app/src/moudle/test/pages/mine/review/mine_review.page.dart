import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/review/mine_review_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../play/weight/curved_indicator.dart';

class MineReviewPage extends BaseEmptyPage<MineReviewController> {
  const MineReviewPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
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
            automaticallyImplyLeading: false,
            title: TabBar(
              automaticIndicatorColorAdjustment: true,
              unselectedLabelStyle: TextStyle(
                  color: MyColors.indicatorNormalTextColor,
                  fontSize: SizeConfig.titleTextDefaultSize),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.indicatorSelectedTextColor,
                  fontSize: 18),
              indicatorColor: MyColors.indicatorColor,
              indicatorPadding: EdgeInsets.only(bottom: 10),
              indicator: CurvedIndicator(),
              splashFactory: NoSplash.splashFactory,
              dividerHeight: 0,
              overlayColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
              tabs: [
                Tab(
                  text: '评论0',
                ),
                Tab(
                  text: '回复0',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildReplyContent(),
              _buildCommentContent(),
            ],
          ),
        ),
      ),
    );
  }

  _buildReplyContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return _buildItem(index);
          },
          separatorBuilder: (context, index) {
            return const SizedBox();
          },
          itemCount: controller.postList.length),
    );
  }

  _buildCommentContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return _buildItem(index);
          },
          separatorBuilder: (context, index) {
            return const SizedBox();
          },
          itemCount: controller.postList.length),
    );
  }

  _buildItem(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: loadImageProvider(controller.list[index].userAvator),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.list[index].userName),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //Todo 向下箭头按下后
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(controller.list[index].content),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(
                Icons.message_outlined,
                color: Colors.grey,
                size: 16,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                controller.list[index].commentsNum,
                style: const TextStyle(
                  color: MyColors.textBlackColor,
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              const Icon(
                Icons.hotel_class,
                color: Colors.grey,
                size: 16,
              ),
              const SizedBox(
                width: 10,
              ),
              //接口缺收藏数
              const Text(
                '3',
                style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontSize: 10,
                ),
              ),
              //Todo 接口缺浏览数
              const Expanded(
                child: Text(
                  '浏览 1.0k',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: MyColors.textBlackColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
