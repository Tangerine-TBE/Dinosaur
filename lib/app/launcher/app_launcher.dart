import 'dart:convert';

import 'package:app_base/constant/constants.dart';
import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:test01/app/launcher/strategy/template_launcher_strategy.dart';

import '../config/route_config.dart';
import '../src/app.dart';

class AppLauncher {
  static launch(
    TemplateLauncherStrategy launcherStrategy,
  ) async {
    await Storage.init();

    BuildConfig.envName = launcherStrategy.envName;
    BuildConfig.host = launcherStrategy.host;
    runApp(App(launcherStrategy, RouteConfig()));
  }
}
