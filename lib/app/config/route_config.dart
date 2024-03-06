import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:common/base/route/a_route.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/pages/home/home_controller.dart';
import 'package:test01/app/src/pages/home/home_page.dart';
import 'package:test01/app/src/pages/play/play_page.dart';
import 'package:test01/app/src/pages/test/test_controller.dart';
import 'package:test01/app/src/pages/test/test_pages.dart';

import '../src/pages/play/play_fra1_controller.dart';
import '../src/pages/play/play_fra2_controller.dart';


/// 服务项目的页面路由配置
class RouteConfig extends ARoute {
  @override
  String initialRoute = RouteName.homePage;

  @override
  String? loginRoute;

  @override
  List<GetPage> getPages() => [
        GetPage(
          name: RouteName.testPage,
          page: () => const TestPages(),
          binding: BindingsBuilder(
            () {
              Get.put(TestController());
            },
          ),
        ),
        GetPage(
          name: RouteName.mainPage,
          page: () => const PlayPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => PlayFra1Controller());
              Get.lazyPut(() => PlayFra2Controller());

            },
          ),
        ),
        GetPage(
          name: RouteName.homePage,
          page: () => const HomePage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => HomeController());
            },
          ),
        )
      ];
}
