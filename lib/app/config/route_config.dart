import 'dart:ffi';

import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:common/base/route/a_route.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/moudle/shake/pages/scanner/scanner_controller.dart';
import 'package:test01/app/src/moudle/test/pages/chart/chart_controller.dart';
import 'package:test01/app/src/moudle/test/pages/chart/chart_page.dart';
import 'package:test01/app/src/moudle/test/pages/model/model_controller.dart';
import 'package:test01/app/src/moudle/test/pages/model/model_page.dart';
import 'package:test01/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:test01/app/src/moudle/test/pages/play/play_page.dart';
import 'package:test01/app/src/moudle/test/pages/scan/scan_controller.dart';
import 'package:test01/app/src/moudle/test/pages/scan/scan_page.dart';
import 'package:test01/app/src/moudle/test/pages/shakeit/shake_it_controller.dart';
import 'package:test01/app/src/moudle/test/pages/shakeit/shake_it_page.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/side_it_controller.dart';
import 'package:test01/app/src/moudle/test/pages/sideIt/side_it_page.dart';

import '../src/moudle/test/pages/home/home_controller.dart';
import '../src/moudle/test/pages/home/home_page.dart';

/// 服务项目的页面路由配置
class RouteConfig extends ARoute {
  @override
  String initialRoute = RouteName.homePage;
  // String initialRoute = RouteName.modelPage;

  @override
  String? loginRoute;

  @override
  List<GetPage> getPages() => [
        GetPage(
          name: RouteName.homePage,
          page: () => const HomePage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => HomeController());
            },
          ),
        ),
        GetPage(
          name: RouteName.chartPage,
          page: () => const ChartPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => ChartController());
            },
          ),
        ),
        GetPage(
          name: RouteName.scanPage,
          page: () => const ScanPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => ScanController());
            },
          ),
        ),
        GetPage(
          name: RouteName.sidePage,
          page: () => const SideItPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => SideItController());
            },
          ),
        ),
        GetPage(
          name: RouteName.shakePage,
          page: () => const ShakeItPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(
                () => ShakeItController(),
              );
            },
          ),
        ),
        GetPage(
          name: RouteName.modelPage,
          page: () => const ModelPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => ModelController());
            },
          ),
        )
        //     GetPage(
        //       name: RouteName.mainPage,
        //       page: () => const MainPage(),
        //       binding: BindingsBuilder(
        //         () {
        //           Get.lazyPut(
        //             () => MainController(),
        //           );
        //         },
        //       ),
        //     ),
        //     GetPage(
        //       name: RouteName.scanPage,
        //       page: () => const ScannerPage(),
        //       binding: BindingsBuilder(
        //         () {
        //           Get.lazyPut(
        //             () => ScannerController(),
        //           );
        //         },
        //       ),
        //     ),
        //     GetPage(
        //       name: RouteName.instructionsPage,
        //       page: () => InstructionsPage(),
        //       binding: BindingsBuilder(
        //         () {
        //           Get.lazyPut(
        //             () => InstructionsController(),
        //           );
        //         },
        //       ),
        //     ),
        //     GetPage(
        //       name: RouteName.playPage,
        //       page: () => PlayPage(),
        //       binding: BindingsBuilder(
        //         () {
        //           Get.lazyPut(
        //             () => InstructionsController(),
        //           );
        //         },
        //       ),
        //     ),
        // GetPage(
        //   name: RouteName.shakeItPage,
        //   page: () => PlayPage(),
        //   binding: BindingsBuilder(
        //         () {
        //       Get.lazyPut(
        //             () => ShakeItPage(),
        //       );
        //     },
        //   ),
        // ),
      ];
}
