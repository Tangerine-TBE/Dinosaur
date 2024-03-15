import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/test/pages/custom/custom_model_controller.dart';

class CustomModelPage extends BaseEmptyPage<CustomModelController> {
  const CustomModelPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return const Text('text');
  }
}
