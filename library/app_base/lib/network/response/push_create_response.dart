import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class PushCreateResponse with DataHolder<PostsList> {
  PushCreateResponse.fromJson(Map<dynamic, dynamic> map) {
    convert(map, (data) => PostsList.fromJson(data));
  }
}
