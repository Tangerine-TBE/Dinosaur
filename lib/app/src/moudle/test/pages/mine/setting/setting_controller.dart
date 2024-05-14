import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/setting_bean.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:app_base/mvvm/repository/setting_repo.dart';
import 'package:get/get.dart';

enum SettingKey {
  allowToBother,
  allowToPublic,
  petMessageNotify,
  chartMessageNotify,
  botherMessageNotify,
  subscribeMessageNotify,
  chatPrivateMessageNotify,
}

class SettingController extends BaseController {
  final allowToBother = false.obs;
  final allowToPublic = false.obs;

  final petMessageNotify = false.obs;
  final chartMessageNotify = false.obs;
  final botherMessageNotify = false.obs;
  final subscribeMessageNotify = false.obs;
  final chatPrivateMessageNotify = false.obs;
  final _repo = Get.find<LoginRepo>();
  final _settingRepo = Get.find<SettingRepo>();

  @override
  void onReady() {
    super.onReady();

    _fetchSettingInfo();
  }

  _fetchSettingInfo() async {
    final response = await _settingRepo.getSettingInfo(
      params: {
        'userId': User.loginRspBean!.userId,
      },
    );
    if (response.isSuccess) {
      if (response.data != null) {
        if (response.data!.data != null) {
          GetSettingRsp data = response.data!.data!;
          List<Setting> settings = data.settings;
          for (var i in settings) {
            i.key.save(i.value);
            if (i.key == SettingKey.allowToBother.toString()) {
              allowToBother.value = i.value == '1';
            } else if (i.key == SettingKey.botherMessageNotify.toString()) {
              botherMessageNotify.value = i.value == '1';
            } else if (i.key ==
                SettingKey.chatPrivateMessageNotify.toString()) {
              chatPrivateMessageNotify.value = i.value == '1';
            } else if (i.key == SettingKey.subscribeMessageNotify.toString()) {
              subscribeMessageNotify.value = i.value == '1';
            } else if (i.key == SettingKey.chartMessageNotify.toString()) {
              chartMessageNotify.value = i.value == '1';
            } else if (i.key == SettingKey.petMessageNotify.toString()) {
              petMessageNotify.value = i.value == '1';
            } else  {
              allowToPublic.value = i.value == '1';
            }
          }
        }
      }
    } else {
      allowToBother.value = SettingKey.allowToBother.toString().read == null
          ? false
          : SettingKey.allowToBother.toString().read == '1'
              ? true
              : false;
      botherMessageNotify.value = SettingKey.botherMessageNotify.toString().read == null
          ? false
          : SettingKey.botherMessageNotify.toString().read == '1'
          ? true
          : false;
      chatPrivateMessageNotify.value = SettingKey.chatPrivateMessageNotify.toString().read == null
          ? false
          : SettingKey.chatPrivateMessageNotify.toString().read == '1'
          ? true
          : false;
      subscribeMessageNotify.value = SettingKey.subscribeMessageNotify.toString().read == null
          ? false
          : SettingKey.subscribeMessageNotify.toString().read == '1'
          ? true
          : false;
      chartMessageNotify.value = SettingKey.chartMessageNotify.toString().read == null
          ? false
          : SettingKey.chartMessageNotify.toString().read == '1'
          ? true
          : false;
      petMessageNotify.value = SettingKey.petMessageNotify.toString().read == null
          ? false
          : SettingKey.petMessageNotify.toString().read == '1'
          ? true
          : false;
      allowToPublic.value = SettingKey.allowToPublic.toString().read == null
          ? false
          : SettingKey.allowToPublic.toString().read == '1'
          ? true
          : false;
    }
  }

  saveSettingInfo(String key, String value) {
    Setting setting = Setting(value: value, key: key);
    SaveSettingReq saveSettingReq = SaveSettingReq(
        settings: <Setting>[setting], userId: User.loginRspBean!.userId);
    key.save(value);
    _settingRepo.saveSettingInfo(saveSettingReq: saveSettingReq);
  }

  onLogOutClicked() async {
    final response = await _repo.logOut(
        bean: LogoutReqBean(accessToken: User.loginRspBean!.accessToken));
    if (response.isSuccess) {
      Get.offAllNamed(RouteName.login);
    }
  }
}
