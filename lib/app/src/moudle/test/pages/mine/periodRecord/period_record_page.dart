import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/period_record_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/periodRecord/weight/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class PeriodRecordPage extends BaseEmptyPage<PeriodRecordController> {
  const PeriodRecordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    controller.list;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 7,
              children: List.generate(7, (index) => _buildItem(index)),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return DatePicker(
                        height:300,
                        onDateRangeSelected: (value) {},
                        dateTime: controller.list[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                    );
                  },
                  itemCount: controller.list.length),
            ),
          ],
        ),
      ),
    );
  }

  _buildItem(int index) {
    if (index == 0) {
      return Center(
        child: Text('一'),
      );
    } else if (index == 1) {
      return Center(
        child: Text('二'),
      );
    } else if (index == 2) {
      return Center(
        child: Text('三'),
      );
    } else if (index == 3) {
      return Center(
        child: Text('四'),
      );
    } else if (index == 4) {
      return Center(
        child: Text('五'),
      );
    } else if (index == 5) {
      return Center(
        child: Text('六'),
      );
    } else if (index == 6) {
      return Center(
        child: Text('日'),
      );
    }
  }
}
