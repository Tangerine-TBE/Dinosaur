import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/faq/faq_page_second_content_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FaqPageSecondContent
    extends BaseEmptyPage<FaqPageSecondContentController> {
  const FaqPageSecondContent({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            controller.content,
          ),
        ),
      ),
    );
  }
}
