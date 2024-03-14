import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/test/pages/chart/chart_controller.dart';

class ChartPage extends BaseEmptyPage<ChartController>{
  const ChartPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Center(child: Text('Chart Page'),);
  }
}
