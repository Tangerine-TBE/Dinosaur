
import 'package:app_base/config/route_name.dart';
import 'package:app_base/exports.dart';
import 'package:common/base/route/a_route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 服务项目的页面路由配置
class RouteConfig extends ARoute {
  @override
  String initialRoute = '';

  @override
  String? loginRoute;

  @override
  List<GetPage> getPages() => [
    ];
}
