import 'package:common/base/mvvm/repo/dio_proxy.dart';
import 'package:dio/dio.dart';

import '../config/build_config.dart';
import 'interceptor/sign_interceptor.dart';

class TemplateDioProxy extends DioProxy {
  static TemplateDioProxy? _instance;

  factory TemplateDioProxy.get() => _getInstance();

  static _getInstance() {
    return _instance ??= TemplateDioProxy._init();
  }

  TemplateDioProxy._init() {
    super.install();
  }

  @override
  String host = BuildConfig.host;

  @override
  String proxy = BuildConfig.proxy;

  @override
  String proxyPort = BuildConfig.proxyPort;

  @override
  Map<String, dynamic> loadDefaultHeader() {
    return {
      // "signType": "MD5",
      // "clientId": "2",
      // "typ": "JDBC",
    };
  }

  @override
  List<Interceptor> loadInterceptors() => [
        SignInterceptor(),
      ];
}
