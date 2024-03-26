import 'package:app_base/exports.dart';
import 'package:get/get.dart';

class MessageController extends BaseController {
  late FriendPageManager friendPageManager;
  late MsgPageManager msgPageManager;
  late NotifyPageManager notifyPageManager;
  final currentPageIndex = 0.obs;

  @override
  void onInit() {
    msgPageManager = MsgPageManager(controller: this);
    friendPageManager = FriendPageManager(controller: this);
    notifyPageManager = NotifyPageManager(controller: this);
    msgPageManager.init();
    super.onInit();
  }

  onPageChanged(int index) {
    if (index == 1) {
      friendPageManager.init();
    } else {
      notifyPageManager.init();
    }
  }

  onSearchClicked() {
    navigateTo(RouteName.search);
  }
}

class FriendPageManager {
  final msgDataListId = 1;
  final data = <String>[];
  final dataSize = 0.obs;
  final MessageController controller;
  bool isInit = false;

  FriendPageManager({required this.controller});

  init() {
    if (!isInit) {
      getFriendList();
      isInit = true;
    }
  }

  getFriendList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.dismiss();
  }

  onFriendItemClicked(int index) {
    //Todo 点击单个朋友
  }
  onFvkClicked(){

  }
  onWeekClicked(){

  }
}

class MsgPageManager {
  final msgDataListId = 2;
  final data = <String>[];
  bool isInit = false;
  final MessageController controller;

  MsgPageManager({required this.controller});

  init() {
    if (!isInit) {
      getMsgList();
      isInit = true;
    }
  }

  getMsgList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.dismiss();
  }

  onMsgItemClicked() {
    //Todo
  }

  onFvkClicked() {}
  onWeekClicked(){}
}

class NotifyPageManager {
  final msgDataListId = 3;

  final MessageController controller;
  bool isInit = false;

  NotifyPageManager({required this.controller});

  init() {
    if (!isInit) {
      getNotifyList();
      isInit = true;
    }
  }

  getNotifyList() async {
    controller.showLoading(userInteraction: false);
    await Future.delayed(const Duration(seconds: 2));
    controller.dismiss();
  }

  onNotifyItemClicked() {
    //Todo
  }
}
