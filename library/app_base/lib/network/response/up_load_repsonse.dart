
import 'package:common/base/mvvm/repo/api_repository.dart';

import '../../mvvm/model/oss_auth_bean.dart';

class UploadResponse with DataHolder<OssAuthBean> {
  UploadResponse.fromJson(Map<dynamic, dynamic> map) {
    convert(
      map,
      (data) => OssAuthBean.fromJson(data),
    );
  }
}
