import 'package:app_base/mvvm/model/top_pic_center.dart';
import 'package:common/base/mvvm/repo/api_repository.dart';

class CenterResponse with DataHolder<TopicCenterRsp> {
  CenterResponse.fromJson(Map<String, dynamic> map) {
    convert(map, (data) => TopicCenterRsp.fromJson(data));
  }

}
class CenterCreateResponse with DataHolder<TopiCenterCreateRsp>{
  CenterCreateResponse.fromJson(Map<String,dynamic> map){
    convert(map, (data) => TopiCenterCreateRsp.fromJson(data));
  }
}
