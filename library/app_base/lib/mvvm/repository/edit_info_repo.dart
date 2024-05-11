import 'package:app_base/exports.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';

class EditInfoRepo extends BaseRepo{

  Future<AResponse<dynamic>> editUserInfo(Map<String,dynamic> map){
    return requestOnFuture(Api.editUserInf0,method: Method.put,params: map);
  }
}