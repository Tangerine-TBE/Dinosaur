import 'dart:math';

import 'package:app_base/exports.dart';

class ChartController extends BaseController{
  final list = <int>[];
  @override
  void onInit() {
    super.onInit();
    list.addAll(List.generate(20, (index) => Random().nextInt(1023)));
  }

}
