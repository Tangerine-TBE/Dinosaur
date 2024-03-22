import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/test/pages/center/center_details_controller.dart';

class CenterDetailsPage extends BaseEmptyPage<CenterDetailsController>{
  const CenterDetailsPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return  Center(child: Text(controller.topCenterList.subtitle),);
  }
}