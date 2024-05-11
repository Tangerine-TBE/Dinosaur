import 'package:app_base/config/size.dart';
import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/post/mine_post_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MinePostPage extends BaseEmptyPage<MinePostController> {
  const MinePostPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffeff1f3),
        appBar: AppBar(
          backgroundColor: const Color(0xffeff1f3),
          centerTitle: false,
          title: const Text(
            '我的帖子',
            style: TextStyle(
              fontSize: SizeConfig.titleTextDefaultSize,
            ),
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return _buildItem(index);
            },
            separatorBuilder: (context, index) {
              return SizedBox();
            },
            itemCount: controller.postList.length));
  }

  _buildItem(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Colors.white,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.list[index].userName),
                  ],
                ),
              ),
              Icon(Icons.arrow_drop_down),
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
