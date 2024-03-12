import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/test/pages/test/play_fra2_controller.dart';

class PlayFra2Page extends BaseEmptyPage<PlayFra2Controller>{
  const PlayFra2Page({super.key});
  @override
  Color get background => MyColors.pageBgColor;
  @override
  Widget buildContent(BuildContext context) {
    return Container(color: Colors.transparent,);
  }

}