import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/faq/faq_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FaqPage extends BaseEmptyPage<FaqController> {
  const FaqPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '常见问题',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        shadowColor: null,
        elevation: 0,
        color: Colors.transparent,
        height: kToolbarHeight,
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('联系我们'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('问题反馈'),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<FaqController>(
            builder: (controller) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return _buildItem(index);
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: CupertinoColors.systemGrey2,
                  );
                },
                itemCount: controller.list.length,
              );
            },
          ),
        ),
      ),
    );
  }

  _buildItem(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: Text(controller.list[index].title),
      ),
    );
  }
}
