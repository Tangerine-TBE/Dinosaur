import 'package:dinosaur/app/launcher/strategy/template_launcher_strategy.dart';

class  UatLauncherStrategy extends TemplateLauncherStrategy{
  @override
  String get envName => 'uat';
  @override
  String get host => 'https://open.miaoaiot.com';
}