import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:app_base/mvvm/repository/details_repo.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import 'package:app_base/mvvm/repository/model_repo.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';
import 'package:app_base/mvvm/repository/push_repo.dart';
import 'package:app_base/mvvm/repository/upload_repo.dart';
import 'package:common/base/route/a_route.dart';
import 'package:dinosaur/app/src/moudle/test/pages/details/details_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/details/details_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/login_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/login_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/pass_world_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/login/pass_world_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/collect/mine_collect_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/collect/mine_collect_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/cutePet/cute_pet_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/cutePet/cute_pet_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/edit/edit_info_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/edit/edit_info_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/faq/faq_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/faq/faq_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/like/mine_like_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/like/mine_like_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/post/mine_post_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/post/mine_post_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/review/mine_review.page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/review/mine_review_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/setting/setting_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/setting/setting_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/push/push_msg_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/push/push_msg_page.dart';
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
import 'package:app_base/config/user.dart';
import '../src/moudle/test/pages/home/home_controller.dart';
import '../src/moudle/test/pages/home/home_page.dart';
import '../src/moudle/test/pages/mine/periodRecord/period_record_controller.dart';
import '../src/moudle/test/pages/mine/periodRecord/period_record_page.dart';

/// 服务项目的页面路由配置
class RouteConfig extends ARoute {
  @override
  String initialRoute =
      User.loginRspBean == null ? RouteName.login : RouteName.homePage;
  @override
  String? loginRoute = RouteName.login;

  @override
  List<GetPage> getPages() => [
        GetPage(
          name: RouteName.editInfo,
          page: () => const EditInfoPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(
                () => EditInfoController(),
              );
            },
          ),
        ),
        GetPage(
          name: RouteName.setting,
          page: () => const SettingPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(
                () => SettingController(),
              );
            },
          ),
        ),
        GetPage(
          name: RouteName.push,
          page: () => const PushMsgPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(
                () => PushMsgController(),
              );
              Get.lazyPut(
                () => PlayRepo(),
              );
              Get.lazyPut(
                () => ModelRepo(),
              );
              Get.lazyPut(
                () => UpLoadRepo(),
              );
            },
          ),
        ),

        GetPage(
          name: RouteName.details,
          page: () => const DetailsPage(),
          binding: BindingsBuilder(
            () {
              var map = Get.arguments;
              PostsList postList = map['item'];
              int index = map['index'];
              Get.lazyPut(
                  () => DetailsController(item: postList, index: index));
              Get.lazyPut(() => DetailsRepo());
            },
          ),
        ),
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
              Map<String, dynamic> maps = Get.arguments;
              Get.lazyPut(
                () => PassWorldController(
                    phone: maps['phone'], expiresIn: maps['expiresIn']),
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
              Get.lazyPut(
                () => PushRepo(),
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
              Get.lazyPut(() => ModelRepo());
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
              Get.lazyPut(() => ModelRepo());
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
        ),
        GetPage(
          name: RouteName.collectView,
          page: (() => const MineCollectPage()),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => MineCollectController());
            },
          ),
        ),
        GetPage(
          name: RouteName.review,
          page: (() => const MineReviewPage()),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => MineReviewController());
            },
          ),
        ),
        GetPage(
          name: RouteName.postView,
          page: (() => const MinePostPage()),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => MinePostController());
            },
          ),
        ),
        GetPage(
          name: RouteName.likeView,
          page: (() => const MineLikePage()),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => MineLikeController());
            },
          ),
        ),
        GetPage(
          name: RouteName.cutePet,
          page: (() => const CutePetPage()),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => CutePetController());
            },
          ),
        ),
        GetPage(
          name: RouteName.faq,
          page: (() => const FaqPage()),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => FaqController());
            },
          ),
        ),
        GetPage(
          name: RouteName.periodRecord,
          page: (() => const PeriodRecordPage()),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => PeriodRecordController());
            },
          ),
        ),
      ];
}
