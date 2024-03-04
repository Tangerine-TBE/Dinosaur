
 import 'package:test01/app/launcher/strategy/template_launcher_strategy.dart';

class  DevLauncherStrategy extends TemplateLauncherStrategy{
  @override
  String get envName => 'dev';

  @override
  String get host => '';
}