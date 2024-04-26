import 'dart:io';

import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/user_bean.dart';
import 'package:dinosaur/app/launcher/strategy/template_launcher_strategy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_base/config/user.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../config/route_config.dart';
import '../src/app.dart';

class AppLauncher {
  static launch(
    TemplateLauncherStrategy launcherStrategy,
  ) async {
    await Storage.init();
    //加载本地缓存信息
    var info = SaveKey.userInfo.read;
    if(info != null){
      User.loginRspBean = LoginRspBean.fromJson(SaveKey.userInfo.read);
    }
    BuildConfig.envName = launcherStrategy.envName;
    BuildConfig.host = launcherStrategy.host;

    runApp(App(launcherStrategy, RouteConfig()));
    logE(User.loginRspBean?.toJson().toString());
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:Brightness.dark ,
         );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }
}
