import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/shake/pages/scanner/scanner_controller.dart';

class ScannerPage extends BaseEmptyPage<ScannerController>{
  const ScannerPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Center(child: Text('Scanner page'),);
  }

}