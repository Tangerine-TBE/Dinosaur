import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';

class ImageViewController extends BaseController{
  final String url;
  final String tag;
  ImageViewController({required this.url,required this.tag});
  @override
  void onInit() {
    super.onInit();
  }
}