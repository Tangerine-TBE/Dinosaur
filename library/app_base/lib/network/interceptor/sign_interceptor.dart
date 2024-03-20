import 'dart:convert';
import 'dart:typed_data';

import 'package:app_base/config/save_key.dart';
import 'package:app_base/exports.dart';
import 'package:dio/dio.dart' as dio;
import '../../constant/constants.dart';
import '../api.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';

class SignInterceptor extends dio.Interceptor {
  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    var header = {
      "Authorization": "Bearer ",

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
