import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/push/push_msg_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PushMsgPage extends BaseEmptyPage<PushMsgController> {
  const PushMsgPage({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cardViewBgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: MyColors.cardViewBgColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const BackButton(),
            SizedBox(
              width: 10.w,
            ),
            Text(
              '帖子',
              style: TextStyle(fontSize: 20.sp),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  minWidth: 40.w,
                  height: 30.h,
                  color: MyColors.themeTextColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  onPressed: () {},
                  child: Text(
                    '发布',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomAppBar(
        height: kToolbarHeight,
        padding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color:Colors.white,

          child: Row(
            children: [
              SizedBox(width: 40.w,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.picture_in_picture_alt),
                  SizedBox(height: 2.h,),
                  Text('图片'),
                ],
              ),
              SizedBox(width: 20.w,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_chart_outlined),
                  SizedBox(height: 2.h,),
                  Text('波形'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildOptionItem(index);
              },
              itemCount: 10,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextField(
                maxLines: null,
                cursorColor: MyColors.themeTextColor,
                decoration: const InputDecoration(border: InputBorder.none,hintText: '这一刻的想法...'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildOptionItem(int index) {
    return index == 0
        ? Container(
            margin: EdgeInsets.only(left: 30.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text('选择一个话题'),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: Icon(
                    Icons.tag,
                    color: Colors.white,
                    size: 14.w,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text('我是帅哥'),
              ],
            ),
          );
  }
}
