import 'package:test01/app/launcher/app_launcher.dart';
import '../strategy/uat_launcher_strategy.dart';

void main(){
  AppLauncher.launch(UatLauncherStrategy());
}