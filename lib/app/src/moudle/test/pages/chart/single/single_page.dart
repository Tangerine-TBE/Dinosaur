import 'dart:convert';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/chart_bean.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<ChartController>(
        builder: (controller) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return _buildSinglePageItem(
                  index, controller.singleCharManager.data[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12,
              );
            },
            itemCount: controller.singleCharManager.data.length,
          );
        },
        id: controller.singleCharManager.chartListId,
      ),
    );
  }

  _buildSinglePageItem(int index, WaveList item) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                //Todo
                backgroundImage: NetworkImage('https://via.placeholder.com/150/0000F1/808080?Text=Image1'),
              ),
            ),
            SizedBox(
              width: 7,
            ),
            SizedBox(
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                        color: MyColors.textBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.face,
                        size: 12,
                      ),
                      Text(
                        item.viewsNum.toString(),
                        style: TextStyle(
                          color: MyColors.textGreyColor,
                          fontSize: 11,
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
          height: 16,
        ),
        Container(
          height: 138,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffff5e65).withAlpha(60)),
          child: GestureDetector(
            onTap: () {
              controller.singleCharManager.onChartItemClick(index);
            },
            child: AwesomeChartView(
              dataList: <List<int>>[SingleWave.fromJson(jsonDecode(item.actions)).data],
              width: double.infinity,
              height: double.infinity/2,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                controller.singleCharManager.onChartLikeClicked(index);
              },
              child: Image.asset(
                //Todo
                false ? ResName.heart1 : ResName.heart,
                width: 14,
                height: 14,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              item.likesNum.toString(),
              style: TextStyle(
                fontSize: 11,
                //Todo
                color: false
                    ? const Color(0xffff5e65)
                    : MyColors.textBlackColor,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Icon(
              Icons.timer_sharp,
              size: 14,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              item.tags,
              style: TextStyle(
                fontSize: 11,
                color: MyColors.textBlackColor,
              ),
            ),
            SizedBox(
              width: 21,
            ),
            Icon(
              Icons.local_fire_department_outlined,
              size: 14,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              item.kcal.toString(),
              style: TextStyle(
                fontSize: 11,
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
                      //Todo
                      false? ResName.start1 : ResName.start2,
                      width: 14,
                      height: 14,
                    ),
                  ),
                  Text(
                    '收藏',
                    style: TextStyle(
                      fontSize: 11,
                      color: MyColors.textBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Divider(
          color: Colors.grey,
          height: 0.5,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
