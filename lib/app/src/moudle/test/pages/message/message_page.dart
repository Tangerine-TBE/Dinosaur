import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_controller.dart';

class MessagePage extends BaseEmptyPage<MessageController>{
  @override
  Widget buildContent(BuildContext context) {

    return Center(child: Text('message page'),);
  }
}
