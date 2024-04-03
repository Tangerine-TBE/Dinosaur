import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:app_base/mvvm/repository/play_repo.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/chart/chart_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/message/message_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/mine_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/mine_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_controller.dart';
import 'package:dinosaur/app/src/moudle/test/pages/pet/pet_page.dart';
import 'package:dinosaur/app/src/moudle/test/pages/play/play_controller.dart';
import 'package:app_base/mvvm/repository/login_repo.dart';
import '../play/play_page.dart';

class HomeController extends BaseController {
  final selectedTabIndex = 0.obs;
  final _loginRepo = Get.find<LoginRepo>();

  @override
  void onInit() async {
    super.onInit();
    // await _loginRepo.login(
    //   userReqBean: UserReqBean(
    //       password: '100344',
    //       application: '',
    //       organization: '',
    //       userName: 'tan',
    //       type: ''),
    // );
  }
  toImageView(String url,String tag){
    Get.lazyPut(
          () => ImageViewController(url: url,tag: tag,),tag: tag
    );
    final Route route =
    MaterialPageRoute(builder: (context) =>  ImageViewPage(tagString: tag,));
    Navigator.of(Get.context!).push(route);
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
            Get.lazyPut(() => PlayRepo());
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
        page: () => const PetPage(),
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
        page: () => const MessagePage(),
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
