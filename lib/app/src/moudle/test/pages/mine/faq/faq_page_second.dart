import 'dart:collection';

import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/faq/faq_page_second_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FaqPageSecond extends BaseEmptyPage<FaqPageSecondController> {
  const FaqPageSecond({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: SizeConfig.titleTextDefaultSize,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          itemBuilder: (context,index){
            List<String> titles =  controller.content.keys.toList();
            List<String> contents =  controller.content.values.toList();
           return _buildItem(titles[index],contents[index]);
          },
          separatorBuilder: (context,index){
          return const Divider();
          },
          itemCount: controller.content.keys.length,
        ),
      ),
    );
  }
  _buildItem(String title,String content){
   return InkWell(
      onTap: () {
        controller.onItemClicked({title:content});
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: Text(title),
      ),
    );
  }
}
