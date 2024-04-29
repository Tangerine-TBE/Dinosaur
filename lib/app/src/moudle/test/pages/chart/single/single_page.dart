import 'dart:convert';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/chart_bean.dart';
import 'package:app_base/widget/listview/smart_load_more_listview.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../weight/awesome_chart.dart';
import 'package:get/get.dart';

class SinglePage extends StatelessWidget {
  final ChartController controller;

  const SinglePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    controller.singleCharManager.setRefreshController(RefreshController(initialRefresh: false));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(
          refresh: SizedBox(
            width: 25.0,
            height: 25.0,
            child: defaultTargetPlatform == TargetPlatform.iOS
                ? CupertinoActivityIndicator(
              color: MyColors.themeTextColor,
            )
                : CircularProgressIndicator(
                strokeWidth: 2.0, color: MyColors.themeTextColor),
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
              Text(
                '刷新完成',
                style: TextStyle(color: MyColors.textBlackColor),
              )
            ],
          ),
          waterDropColor: MyColors.themeTextColor,
        ),
        onRefresh: controller.singleCharManager.getChartList,
        controller: controller.singleCharManager.refreshController,
        child: CustomScrollView(
          slivers: [GetBuilder<ChartController>(
            builder: (controller) {
              return SliverList.separated(
                itemBuilder: (context, index) {
                  return _buildSinglePageItem(
                      index, controller.singleCharManager.data[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: controller.singleCharManager.data.length,
              );
            },
            id: controller.singleCharManager.chartListId,
          )],
        ),
      ),
    );
  }

  _buildSinglePageItem(int index, WaveList item) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150/0000F1/808080?Text=Image1'),
              ),
            ),
            const SizedBox(
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
                    style: const TextStyle(
                        color: MyColors.textBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.face,
                        size: 12,
                      ),
                      Text(
                        item.viewsNum.toString(),
                        style: const TextStyle(
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
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 138,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        const SizedBox(
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
            const SizedBox(
              width: 4,
            ),
            Text(
              item.likesNum.toString(),
              style: const TextStyle(
                fontSize: 11,
                //Todo
                color: false
                    ? Color(0xffff5e65)
                    : MyColors.textBlackColor,
              ),
            ),
            const SizedBox(
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
