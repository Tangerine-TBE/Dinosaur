import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/char_bean.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../weight/awesome_chart.dart';
import 'package:get/get.dart';

class SinglePage extends StatelessWidget {
  final ChartController controller;

  const SinglePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GetBuilder<ChartController>(
        builder: (controller) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return _buildSinglePageItem(
                  index, controller.singleCharManager.data[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount: controller.singleCharManager.data.length,
          );
        },
        id: controller.singleCharManager.chartListId,
      ),
    );
  }

  _buildSinglePageItem(int index, SingleList item) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: CircleAvatar(
                backgroundImage: NetworkImage(item.userPic),
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            SizedBox(
              height: 40.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.userName,
                    style: TextStyle(
                        color: MyColors.textBlackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.face,
                        size: 12,
                      ),
                      Text(
                        item.userFar,
                        style: TextStyle(
                          color: MyColors.textGreyColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
          height: 138.h,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.w),
              color: const Color(0xffff5e65).withAlpha(60)),
          child: GestureDetector(
            onTap: () {
              controller.singleCharManager.onChartItemClick(index);
            },
            child: AwesomeChartView(
              dataList: <List<int>>[item.data],
              width: double.infinity,
              height: double.infinity/2,
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                controller.singleCharManager.onChartLikeClicked(index);
              },
              child: Image.asset(
                item.like ? ResName.heart1 : ResName.heart,
                width: 14.w,
                height: 14.w,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              item.likeNum,
              style: TextStyle(
                fontSize: 11.sp,
                color: item.like
                    ? const Color(0xffff5e65)
                    : MyColors.textBlackColor,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Icon(
              Icons.timer_sharp,
              size: 14.w,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              item.timeAdvice,
              style: TextStyle(
                fontSize: 11.sp,
                color: MyColors.textBlackColor,
              ),
            ),
            SizedBox(
              width: 21.w,
            ),
            Icon(
              Icons.local_fire_department_outlined,
              size: 14.w,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              item.kcal,
              style: TextStyle(
                fontSize: 11.sp,
                color: MyColors.textBlackColor,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      controller.singleCharManager.onChartLinkClicked(index);
                    },
                    child: Image.asset(
                      item.link ? ResName.start1 : ResName.start2,
                      width: 14.w,
                      height: 14.w,
                    ),
                  ),
                  Text(
                    '收藏',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: MyColors.textBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        Divider(
          color: Colors.grey,
          height: 0.5.h,
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
