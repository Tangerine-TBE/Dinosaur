import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:crypto/crypto.dart';
import 'package:app_base/config/user.dart';

class SignInterceptor extends dio.Interceptor {
  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    var token = User.loginRspBean?.accessToken ??'';
    var header = {
      "Authorization": "Bearer $token",
    };
    options.headers.addAll(header);
    super.onRequest(options, handler);
  }

  String generateMD5(String data) {
    Uint8List content = const Utf8Encoder().convert(data);
    Digest digest = md5.convert(content);
    return digest.toString();
  }
}
