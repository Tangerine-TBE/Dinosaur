import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/review/mine_review_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

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
                  color: MyColors.indicatorNormalTextColor, fontSize: 16),
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

  _buildItem(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ]),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: loadImageProvider(''),
              ),
              SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('你好呀'),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              'xxxxxxxxxxxxxxxxx................................................................'),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(
                Icons.message_outlined,
                color: Colors.grey,
                size: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '1',
                style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontSize: 10,
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Icon(
                Icons.hotel_class,
                color: Colors.grey,
                size: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '3',
                style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontSize: 10,
                ),
              ),
              Expanded(
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
