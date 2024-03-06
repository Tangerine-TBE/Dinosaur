import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:common/base/route/a_route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test01/app/src/pages/peo/main_page.dart';
import 'package:test01/app/src/pages/test/test_controller.dart';
import 'package:test01/app/src/pages/test/test_pages.dart';

/// 服务项目的页面路由配置
class RouteConfig extends ARoute {
  @override
  String initialRoute = RouteName.testPage;

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
          page: () => MainPage(),
          binding: BindingsBuilder(
            () {},
          ),
        ),
      ];
}
