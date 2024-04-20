import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:get/get.dart';

class SettingController extends BaseController {
  final allowToBother = false.obs;
  final allowToPublic = false.obs;

  final petMessageNotify = false.obs;
  final chartMessageNotify = false.obs;
  final botherMessageNotify = false.obs;
  final subscribeMessageNotify = false.obs;
  final chatPrivateMessageNotify = false.obs;
  final _repo = Get.find<LoginRepo>();
  onLogOutClicked() async{

    final response = await   _repo.logOut(bean: LogoutReqBean(accessToken: User.loginRspBean!.accessToken));
    if(response.isSuccess){
     Get.offAllNamed(RouteName.login);
    }
  }



}