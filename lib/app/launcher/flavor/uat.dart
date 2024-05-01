import 'package:dinosaur/app/launcher/app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../strategy/uat_launcher_strategy.dart';

main()  {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  AppLauncher.launch(UatLauncherStrategy());
}