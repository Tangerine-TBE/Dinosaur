import 'package:app_base/exports.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';
import '../../network/response/up_load_repsonse.dart';

class UpLoadRepo extends BaseRepo{
    Future<AResponse<UploadResponse>> getUploadAuth() {
        return requestOnFuture(Api.upLoadFile, params: {"bucketName": "cxw-user"},
            method: Method.post,
            format: (data) => UploadResponse.fromJson(data));
    }

}