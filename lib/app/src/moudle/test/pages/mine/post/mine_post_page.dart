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
          title:  Text('我的帖子',style: TextStyle(fontSize: 18.sp),),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
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
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('你好呀'),
                  ],
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
              'xxxxxxxxxxxxxxxxx................................................................'),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Icon(
                Icons.message_outlined,
                color: Colors.grey,
                size: 16.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                '1',
                style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
              Icon(
                Icons.hotel_class,
                color: Colors.grey,
                size: 16.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                '3',
                style: TextStyle(
                  color: MyColors.textBlackColor,
                  fontSize: 10.sp,
                ),
              ),
              Expanded(
                child: Text(
                  '浏览 1.0k',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: MyColors.textBlackColor,
                    fontSize: 10.sp,
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
