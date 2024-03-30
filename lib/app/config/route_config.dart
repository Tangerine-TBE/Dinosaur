import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:common/base/route/a_route.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/login_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/login_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/pass_world_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/pass_world_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/register/register_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/register/register_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/search/search_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/search/search_page.dart';
import 'package:get/get.dart';
import 'package:dinosaur/app/src/moudle/test/pages/center/center_details_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/center/center_detial_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/custom/custom_model_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/custom/custom_model_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/model/model_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/model/model_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/scan/scan_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/scan/scan_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/shakeit/shake_it_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/shakeit/shake_it_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/sideIt/side_it_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/sideIt/side_it_page.dart';

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
      name: RouteName.search,
      page: () => const SearchPage(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut(
                () => SearchFriController(),
          );

        },
      ),
    ),
        GetPage(
          name: RouteName.register,
          page: () => const RegisterPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(
                () => RegisterController(),
              );
              Get.lazyPut(
                () => LoginRepo(),
              );
            },
          ),
        ),

        GetPage(
          name: RouteName.passWorld,
          page: () => const PassWorldPage(),
          binding: BindingsBuilder(
            () {
              String phone = Get.arguments;
              Get.lazyPut(
                () => PassWorldController(phone: phone),
              );
              Get.lazyPut(
                () => LoginRepo(),
              );
            },
          ),
        ),

        GetPage(
          name: RouteName.centerDetailsPage,
          page: () => const CenterDetailsPage(),
          binding: BindingsBuilder(
            () {
              TopicList topicList = Get.arguments;
              Get.lazyPut(
                () => CenterDetailsController(topCenterList: topicList),
              );
            },
          ),
        ),
        GetPage(
          name: RouteName.login,
          page: () => const LoginPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => LoginController());
              Get.lazyPut(() => LoginRepo());
            },
          ),
        ),

        GetPage(
          name: RouteName.homePage,
          page: () => const HomePage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => HomeController());
              Get.lazyPut(() => LoginRepo());
            },
          ),
        ),
        // GetPage(
        //   name: RouteName.chartPage,
        //   page: () => const ChartPage(),
        //   binding: BindingsBuilder(
        //     () {
        //       Get.lazyPut(() => ChartController());
        //     },
        //   ),
        // ),
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
        ),
        GetPage(
          name: RouteName.customPage,
          page: () => const CustomModelPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => CustomModelController());
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
