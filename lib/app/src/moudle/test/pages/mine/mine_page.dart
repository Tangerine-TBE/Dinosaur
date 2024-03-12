import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/test/pages/mine/mine_controller.dart';

class MinePage extends BaseEmptyPage<MineController>{
  @override
  Widget buildContent(BuildContext context) {
    return Center(child: Text('mine page'),);
  }
}