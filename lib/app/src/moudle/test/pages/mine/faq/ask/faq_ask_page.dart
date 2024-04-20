import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/faq/ask/faq_ask_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FaqAskPage extends BaseEmptyPage<FaqAskController> {
  const FaqAskPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff1f3),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          '问题反馈',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Color(0xffeff1f3),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
                color: Colors.white,
              ),
              child: TextField(
                cursorColor: Colors.black,
                maxLines: null,
                style: TextStyle(
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  hintText: '请描述你的问题并提交问题截图，帮助我们更快定位您的问题',
                  hintStyle: TextStyle(fontSize: 12),
                  hintMaxLines: 2,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '联系方式',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
                color: Colors.white,
              ),
              child: TextField(
                cursorColor: Colors.black,
                maxLines: null,
                style: TextStyle(
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  hintText: '请输入手机号、微信号或电子邮件地址，以便我们联系您。',
                  hintStyle: TextStyle(fontSize: 12),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                color: MyColors.themeTextColor,
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  '提交',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
