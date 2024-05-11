import 'package:app_base/mvvm/model/home_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class HomeResponse extends DataHolder<HomeRsp> {
  HomeResponse.fromJson(Map<dynamic, dynamic> json) {
    convert(
      json,
      (data) => HomeRsp.fromJson(data),
    );
  }
}
