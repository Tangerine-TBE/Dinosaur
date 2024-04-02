import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/friends_share_bean.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CommonPage extends StatelessWidget {
  final PetController controller;

  const CommonPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
                  child: BannerCarousel.fullScreen(
                    animation: true,
                    height: 106.h,
                    banners: controller.commonManager.listBanners,
                    showIndicator: true,
                    indicatorBottom: false,
                    borderRadius: 10.w,
                    disableColor: const Color(0xffFFFFFF).withOpacity(0.5),
                    activeColor: const Color(0xffFFFFFF),
                    customizedIndicators: IndicatorModel.animation(
                      width: 5.w,
                      height: 5.w,
                      spaceBetween: 4.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          GetBuilder<PetController>(
            builder: (controller) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildItem(
                      index, controller.commonManager.dataList[index], context),
                  childCount: controller.commonManager.dataList.length,
                ),
              );
            },
            id: controller.commonManager.listId,
          )
        ],
      ),
    );
  }

  _buildItem(int index, Recommon item, BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(top: 32.h, left: 18.w, right: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(item.avatar),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.userName,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xffFF5E65).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '#',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Color(0xffFF5E65),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              text: item.title,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Color(0xffFF5E65),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildContent(index, item, context),
          SizedBox(
            height: 20.w,
          ),
          Row(
            children: [
              SizedBox(width: 50.w),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 22.w,
                color: Color(
                  0xff8F9098,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                item.viewNum,
                style: TextStyle(
                  color: Color(0xff8F9098),
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(
                width: 122.w,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      ResName.lovely1,
                      width: 22.w,
                      height: 22.w,
                    ),
                    Text(
                      item.likeNUm,
                      style: TextStyle(
                        color: Color(0xff8F9098),
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.naviToDetails(item);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.message,
                        size: 22.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '评论',
                        style: TextStyle(
                            color: Color(0xff8F9098),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildContent(int index, Recommon item, BuildContext context) {
    // 区分内容
    return Row(
      children: [
        SizedBox(
          width: 50.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(item.content),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                controller.naviToImageView(item.avatar);
              },
              child: controller.imagePreView(
                index < 9
                    ? List.generate(index + 1, (index) => item.avatar)
                    : <String>[item.avatar],
                context,
                250.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
