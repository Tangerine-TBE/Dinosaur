import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageViewPage extends BaseEmptyPage<ImageViewController> {
  final String tagString ;
  const ImageViewPage({super.key,required this.tagString});
  @override
  String? get tag => tagString;
  @override
  Widget buildContent(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: (){logE('msg');},
        child: Center(
          child: Hero(
            tag: controller.tag,
            child: Image.network(controller.url,fit: BoxFit.contain,width: double.infinity,),
          ),
        ),
      ),
    );
  }
}
