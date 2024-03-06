import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class test1 extends BaseEmptyPage{
  const test1({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Container(child: Center(child: Text('test1')),);
  }

}