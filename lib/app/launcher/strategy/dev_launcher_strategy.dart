

import 'package:dinosaur/app/launcher/strategy/template_launcher_strategy.dart';

class  DevLauncherStrategy extends TemplateLauncherStrategy{
  @override
  String get envName => 'dev';

  @override
  String get host => 'http://1.13.6.34:8844';
}