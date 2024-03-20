import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/chart/chart_controller.dart';
import 'package:test01/app/src/moudle/test/pages/chart/chart_page.dart';
import 'package:test01/app/src/moudle/test/pages/message/message_controller.dart';
import 'package:test01/app/src/moudle/test/pages/message/message_page.dart';
import 'package:test01/app/src/moudle/test/pages/mine/mine_controller.dart';
import 'package:test01/app/src/moudle/test/pages/mine/mine_page.dart';
import 'package:test01/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:test01/app/src/moudle/test/pages/pet/pet_page.dart';
import 'package:test01/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import '../play/play_page.dart';

class HomeController extends BaseController {
  final selectedTabIndex = 0.obs;
  final _loginRepo = Get.find<LoginRepo>();

  @override
  void onInit() async {
    super.onInit();
    await _loginRepo.login(
      userReqBean: UserReqBean(
          password: '100344',
          application: '',
          organization: '',
          userName: 'tan',
          type: ''),
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == RouteName.playPage) {
      return GetPageRoute(
        settings: settings,
        page: () => const PlayPage(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => PlayController());
          },
        ),
      );
    } else if (settings.name == RouteName.chartPage) {
      return GetPageRoute(
        settings: settings,
        page: () => const ChartPage(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => ChartController());
          },
        ),
      );
    } else if (settings.name == RouteName.minePage) {
      return GetPageRoute(
        settings: settings,
        page: () => const MinePage(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => MineController());
          },
        ),
      );
    } else if (settings.name == RouteName.petPage) {
      return GetPageRoute(
        settings: settings,
        page: () => PetPage(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => PetController());
          },
        ),
      );
    } else if (settings.name == RouteName.message) {
      return GetPageRoute(
        settings: settings,
        page: () => MessagePage(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => MessageController());
          },
        ),
      );
    }
    return null;
  }
}
