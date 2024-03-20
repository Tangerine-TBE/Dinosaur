abstract class JsonResponse{
  dynamic decode(Map<String, dynamic> json) {
    final data = json['data'];
    if (data == null || data.isEmpty) {
      /*如果data == null 代表本次请求可能是失败的或者返回的body中没有data字段*/
      return null;
    } else {
      return json['data'];
    }
  }
  dynamic decodeList(Map<String,dynamic> json){
    final data = json['rows'];
    if(data == null || data.isEmpty){
      return [];
    }else{
      return data;
    }
  }


}