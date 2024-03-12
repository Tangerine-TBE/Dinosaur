import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/shake/pages/share/share_controller.dart';

class SharePage extends BaseEmptyPage<ShareController> {
  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: Text('Share page'),
    );
  }
}
