import 'package:app_base/config/size.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/cutePet/cute_pet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CutePetPage extends BaseEmptyPage<CutePetController>{
  const CutePetPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('我的萌宠',style: TextStyle(fontSize: SizeConfig.titleTextDefaultSize,),),

      ),
    );
  }

}