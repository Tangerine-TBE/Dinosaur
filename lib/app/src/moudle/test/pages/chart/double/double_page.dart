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
class DoublePage extends StatefulWidget {
  final ChartController controller;
  const DoublePage({super.key,required this.controller});

  @override
  State<DoublePage> createState() => _DoublePageState();
}

class _DoublePageState extends State<DoublePage> with AutomaticKeepAliveClientMixin{
  late ChartController controller;
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    controller.doubleCharManager.setRefreshController(RefreshController(initialRefresh: false));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PageStorage(
        bucket: controller.doubleCharManager.pageBucket,
        child: SmartRefresher(
          key: const PageStorageKey<String>('${RouteName.chartPage}Double'),
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
                const Text(
                  '刷新完成',
                  style: TextStyle(color: MyColors.textBlackColor),
                )
              ],
            ),
            waterDropColor: MyColors.themeTextColor,
          ),
          onRefresh: controller.doubleCharManager.getChartList,
          controller: controller.doubleCharManager.refreshController,
          child: PageStorage(
            bucket: controller.doubleCharManager.pageBucket,
            child: CustomScrollView(
              slivers: [GetBuilder<ChartController>(
                builder: (controller) {
                  return SliverList.separated(
                    itemBuilder: (context, index) {
                      return _buildDoublePageItem(
                          index, controller.doubleCharManager.data[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 12,
                      );
                    },
                    itemCount: controller.doubleCharManager.data.length,
                  );
                },
                id: controller.doubleCharManager.chartListId,
              )],
            ),
          ),
        ),
      ),
    );
  }

  _buildDoublePageItem(int index, WaveList item) {
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
              controller.doubleCharManager.onChartItemClick(index);
            },
            child: AwesomeChartView(
              animatedInfoKey: 'double_page_chart$index',
              dataList: <List<int>>[DoubleWave.fromJson(jsonDecode(item.actions)).data1,DoubleWave.fromJson(jsonDecode(item.actions)).data2,],
              width: double.infinity,
              height: 138,
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
                controller.doubleCharManager.onChartLikeClicked(item.id,index,);
              },
              child: Image.asset(
                item.isMyLike?
                ResName.heart1 : ResName.heart,
                width: 14,
                height: 14,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              item.likesNum.toString(),
              style:  TextStyle(
                fontSize: 11,
                color: item.isMyLike?
                const Color(0xffff5e65)
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
              child: InkWell(
                onTap: () {
                  controller.singleCharManager.onChartLinkClicked(item.id,index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      item.isMyFavor? ResName.start1 : ResName.start2,
                      width: 14,
                      height: 14,
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

  @override
  bool get wantKeepAlive => true;
}




