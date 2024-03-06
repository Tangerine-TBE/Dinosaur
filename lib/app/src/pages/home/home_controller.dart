import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test01/app/src/pages/play/play_page.dart';
import 'package:test01/app/src/pages/test/test_pages.dart';

import '../play/play_fra1_controller.dart';
import '../play/play_fra2_controller.dart';
import '../test/test_controller.dart';

class HomeController extends BaseController{
  final selectedTabIndex = 0.obs;
  Route? onGenerateRoute(RouteSettings settings){
    if(settings.name == RouteName.playPage){
      return GetPageRoute(
        settings: settings,
        page: ()=> const PlayPage(),
        transition: Transition.noTransition,
        binding: BindingsBuilder(
              () {
            Get.lazyPut(() => PlayFra1Controller());
            Get.lazyPut(() => PlayFra2Controller());
          },
        ),
      );
    }else if(settings.name == RouteName.testPage){
      return GetPageRoute(
        settings: settings,
        page: ()=>const TestPages(),
        transition: Transition.noTransition,

        binding: BindingsBuilder(
              () {
            Get.put(TestController());
          },
        ),
      );
    }
    return null;
  }

}