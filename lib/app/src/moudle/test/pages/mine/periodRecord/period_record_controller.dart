import 'package:app_base/exports.dart';

class PeriodRecordController extends BaseController{
  final list = <DateTime>[];
  @override
  void onInit(){
    super.onInit();
    _fetchDateTime();
  }

  _fetchDateTime(){
    var now = DateTime.now();
    // for(int i = 1 ; i <= 12; i ++){
    //    list.add(DateTime(now.year,now.month - i));
    // }
    list.add(now);
    // for(int i = 1 ; i <=12; i ++){
    //   list.add(DateTime(now.year,now.month +i));
    // }
  }

}