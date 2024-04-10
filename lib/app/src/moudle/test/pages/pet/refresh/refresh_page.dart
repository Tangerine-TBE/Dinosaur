import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/friends_share_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/util/image.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loadmore_listview/loadmore_listview.dart';

class RefreshPage extends StatelessWidget {
  final PetController controller;

  const RefreshPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadMoreListView.customScrollView(
        onLoadMore: controller.refreshManager.loadMoreList,
        loadMoreWidget: Container(
          margin: EdgeInsets.all(20.w),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
          ),
        ),
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
                    banners: controller.refreshManager.listBanners,
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
              return controller.refreshManager.dataList.isNotEmpty
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildItem(index,
                            controller.refreshManager.dataList[index], context),
                        childCount: controller.refreshManager.dataList.length,
                      ),
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
      ),
    );
  }

  _buildItem(int index, PostsList item, BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
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
                  backgroundImage: loadImageProvider(item.userAvator),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.userName,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                        const Icon(Icons.more_horiz),
                      ],
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
                                color: const Color(0xffFF5E65),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: item.topicTitle,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xffFF5E65),
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
                color: const Color(
                  0xff8F9098,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                item.viewsNum.toString(),
                style: TextStyle(
                  color: const Color(0xff8F9098),
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
                      item.likesNum.toString(),
                      style: TextStyle(
                        color: const Color(0xff8F9098),
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
                    controller.naviToDetails(item,index);
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
                            color: const Color(0xff8F9098),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: MyColors.textGreyColor.withOpacity(0.3),
            thickness: 0.3.h,
          ),
        ],
      ),
    );
  }

  _buildContent(int index, PostsList item, BuildContext context) {
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
            controller.imagePreView(item.images.map((e) => e.imageUrl).toList(),
                context, 250.w, index, item.images),
          ],
        ),
      ],
    );
  }
}
