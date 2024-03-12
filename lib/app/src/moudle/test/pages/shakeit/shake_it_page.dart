import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/shake/pages/shakeit/shake_it_controller.dart';

class ShakeItPage extends BaseEmptyPage<ShakeItController>{
  @override
  Widget buildContent(BuildContext context
      ) {
    return Center(child:  Text('Shake it'),);
  }
}
