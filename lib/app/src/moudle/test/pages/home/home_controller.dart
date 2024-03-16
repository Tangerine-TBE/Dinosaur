import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/test/pages/play/play_controller.dart';

import '../play/play_page.dart';
import '../test/test_controller.dart';
import '../test/test_pages.dart';
import '../test1/test1.dart';
import '../test1/test1Controller.dart';
import '../test2/test2.dart';
import '../test2/test2Controller.dart';

class HomeController extends BaseController {
  final selectedTabIndex = 0.obs;

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == RouteName.playPage) {
      return GetPageRoute(
        settings: settings,
        page: () => const PlayPage(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(()=>PlayController());

          },
        ),
      );
    }  else if (settings.name == RouteName.test1Page) {
      return GetPageRoute(
        settings: settings,
        page: () => const test1(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => Test1Controller());
          },
        ),
      );
    } else if (settings.name == RouteName.test2Page) {
      return GetPageRoute(
        settings: settings,
        page: () => const test2(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => Test2Controller());
          },
        ),
      );
    }
    return null;
  }
}
