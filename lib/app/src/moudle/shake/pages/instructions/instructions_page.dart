import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/shake/pages/instructions/instructions_controller.dart';

class InstructionsPage extends BaseEmptyPage<InstructionsController>{
  @override
  Widget buildContent(BuildContext context) {
    return Center(child: Text('Instructions page'),);
  }

}