library repo;

import 'package:app_base/network/template_dio_proxy.dart';

import 'package:common/base/mvvm/repo/api_repository.dart';
import 'package:common/base/mvvm/repo/dio_proxy.dart';
import 'package:common/common/network/dio_client.dart';
import 'package:dio/dio.dart';

// requests

// repos

/// 业务层的base请求仓库
class BaseRepo extends ApiRepository {
  static Map<String, dynamic> xmlHeaders = {
    "Content-Type": "application/xml;charset=UTF-8",
    "Accept": "application/xml,*/*",
  };

  static Map<String, dynamic> jsonHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json,*/*",
  };

  @override
  DioProxy proxy = TemplateDioProxy.get();

  @override
  Future<AResponse<T>> requestOnFuture<T>(
    String path, {
    Method method = Method.get,
    Map<String, dynamic>? params,
    Options? options,
    T? Function(dynamic data)? format,
  }) {
    return super.requestOnFuture(
      path,
      method: method,
      params: params,
      options: options,
      format: format,
    );
  }
}
