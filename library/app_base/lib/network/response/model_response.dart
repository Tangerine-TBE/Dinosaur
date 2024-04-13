
import 'package:app_base/mvvm/model/record_bean.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class ModelResponse extends DataHolder<ModelRsp>{
  ModelResponse.fromJson(Map<String,dynamic> map){
    convert(map, (data) => ModelRsp.fromJson(data));
  }
}