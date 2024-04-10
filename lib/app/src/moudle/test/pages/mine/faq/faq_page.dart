import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class FaqPage extends BaseEmptyPage<BaseController>{
  const FaqPage({super.key});

  @override
  Widget buildContent(BuildContext context) {

    return Center(child: const Text('faqPage'));
  }

}