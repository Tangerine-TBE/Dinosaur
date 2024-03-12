import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/shake/pages/play/play_controller.dart';

class PlayPage extends BaseEmptyPage<PlayController>{
  @override
  Widget buildContent(BuildContext context
      ) {
    return Center(child: Text("play page"),);
  }
}
