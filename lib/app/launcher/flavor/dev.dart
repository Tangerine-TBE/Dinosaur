import 'package:test01/app/launcher/app_launcher.dart';
import 'package:test01/app/launcher/strategy/dev_launcher_strategy.dart';

void main(){
  AppLauncher.launch(DevLauncherStrategy());
}