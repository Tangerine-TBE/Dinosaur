import 'package:app_base/ble/ble_tools.dart';
import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test01/app/src/pages/test/test_controller.dart';

class TestPages extends BaseEmptyPage<TestController> {
  const TestPages({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      child: Center(
        child: MaterialButton(
          child: Text('test'),
          onPressed: () {
            BleTools().checkBleAvailable();
          },
        ),
      ),
    );
  }
}
