import 'package:app_base/exports.dart';
import 'package:common/common/network/dio_client.dart';

import '../../network/api.dart';

class EditInfoRepo extends BaseRepo{

  Future<AResponse<dynamic>> editUserInfo({required String path,required Map<String,dynamic> map}){
    return requestOnFuture("${Api.editUserInf0}/$path",method: Method.put,params: map);
  }
}