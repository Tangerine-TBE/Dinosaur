import 'dart:ui';

import 'package:get/get.dart';

import 'msg_cn.dart';
import 'msg_en.dart';

/// 多語言表
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
      };

  static void toEN() {
    Get.updateLocale(const Locale('en', 'US'));
  }

  static void toCN() {
    Get.updateLocale(const Locale('zh', 'CN'));
  }


  static void switchLanguage() {
    if (Get.locale?.languageCode == 'en') {
      // SaveKey.language.save('zh');
      toCN();
    } else {
      // SaveKey.language.save('en');
      toEN();
    }
  }
}

/// 多語言key
class MsgKey {
  static const String protocolPageContent = 'protocolPageContent';
}
