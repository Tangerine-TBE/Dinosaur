import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/shake/pages/sideIt/side_it_controller.dart';

class SideItPage extends BaseEmptyPage<SideItController>{
  @override
  Widget buildContent(BuildContext context) {
    return Center(child:  Text('side it'),);
  }

}