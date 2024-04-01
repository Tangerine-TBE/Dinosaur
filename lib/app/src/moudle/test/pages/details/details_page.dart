import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/details/details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsPage extends BaseEmptyPage<DetailsController> {
  const DetailsPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cardViewBgColor,
      appBar: AppBar(
        backgroundColor: MyColors.cardViewBgColor,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 38.h,
          child: Row(
            children: [
              BackButton(),
              SizedBox(
                width: 10.w,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(controller.item.avatar),
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
                    '2024-4-1 11:52:42',
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
                    '18 参与 | 1.2k 浏览',
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 50.w),
                    child: Text(controller.item.content)),
                Image.network(
                  controller.item.avatar,
                  width: double.infinity,
                  fit: BoxFit.contain,
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
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            sliver: SliverList.list(
              children: [
                _buildContentItem(),
                SizedBox(height: 20.h,),
                _buildContentItem(),
                SizedBox(height: 20.h,),     _buildContentItem(),
                SizedBox(height: 20.h,),     _buildContentItem(),
                SizedBox(height: 20.h,),     _buildContentItem(),
                SizedBox(height: 20.h,),     _buildContentItem(),
                SizedBox(height: 20.h,),     _buildContentItem(),
                SizedBox(height: 20.h,),     _buildContentItem(),
                SizedBox(height: 20.h,),     _buildContentItem(),
                SizedBox(height: 20.h,),

              ],
            ),
          )
        ],
      ),
    );
  }

  _buildContentItem() {
    return Container(
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
                  backgroundImage: NetworkImage(controller.item.avatar),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '我和我的猫咪们',
                      style: TextStyle(
                        color: MyColors.textBlackColor,
                      ),
                    ),
                    Text(
                      '5分钟前',
                      style: TextStyle(
                          color: MyColors.textGreyColor, fontSize: 10.sp),
                    ),
                  ],
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.more_horiz,
                          size: 20.w,
                        ))),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text('人都哪里去了')),
          Row(
            children: [
              Icon(
                Icons.message,
                size: 14.w,
              ),
              SizedBox(
                width: 40.w,
              ),
              FaIcon(
                FontAwesomeIcons.heart,
                size: 14.w,
              ),
            ],
          )
        ],
      ),
    );
  }
}
