import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:app_base/network/response/model_response.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';

class ModelRepo extends BaseRepo {
  Future<AResponse<dynamic>> sendModel({required RecordReq recordReq}) {
    return requestOnFuture(
      Api.sendRecord,
      method: Method.post,
      params: recordReq.toJson(),
    );
  }

  Future<AResponse<ModelResponse>> getModel({required ModelReq recordReq}) {
    return requestOnFuture(
      Api.getModel,
      method: Method.post,
      params: recordReq.toJson(),
      format: (data) => ModelResponse.fromJson(data),
    );
  }
}
