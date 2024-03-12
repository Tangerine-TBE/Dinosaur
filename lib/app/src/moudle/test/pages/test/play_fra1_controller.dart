import 'package:app_base/exports.dart';
import 'package:share_plus/share_plus.dart';

class PlayFra1Controller extends BaseController{
    String getText(){
      return "nihao";
    }
    void onSharePress(){
      Share.share('你好啊',subject: 'Look');
    }
}
