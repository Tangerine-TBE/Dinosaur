import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/register/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends BaseEmptyPage<RegisterController>{
  const RegisterPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return const Center(child: Text('注册界面'),);
  }

}