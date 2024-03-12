import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/moudle/test/pages/pet/pet_controller.dart';

class PetPage extends BaseEmptyPage<PetController>{
  @override
  Widget buildContent(BuildContext context) {
    return Center(child: Text('pet page'),);
  }

}