import 'package:common/base/app/base_material_app.dart';
import 'package:common/common/widget/loading/g_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_base/exports.dart';
import 'package:dinosaur/app/launcher/strategy/template_launcher_strategy.dart';

class App extends BaseMaterialApp<TemplateLauncherStrategy> {
  App(super.launcherStrategy, super.route, {super.key});

  @override
  void buildConfig(TemplateLauncherStrategy launcherStrategy) {}

  @override
  GetMaterialApp buildApp(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          // 安装loading
          child = GLoading.instance.init(context, child);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: child);
        },
        theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        translations: Messages(),
        popGesture: true,
        getPages: route.getPages(),
        initialRoute: route.initialRoute,
        defaultTransition: Transition.rightToLeftWithFade,
      );
}
