
 import 'package:test01/app/launcher/strategy/template_launcher_strategy.dart';

class  DevLauncherStrategy extends TemplateLauncherStrategy{
  @override
  String get envName => 'dev';

  @override
  String get host => 'http://127.0.0.1:4523/m1/3578732-0-default';
}