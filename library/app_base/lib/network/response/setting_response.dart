import 'dart:ui';

import 'package:app_base/mvvm/model/setting_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class GetSettingInfoResponse extends DataHolder<GetSettingRsp> {
  GetSettingInfoResponse.fromJson(dynamic map) {
    convert(
      map,
      (data) => GetSettingRsp.fromJson(data),
    );
  }
}
