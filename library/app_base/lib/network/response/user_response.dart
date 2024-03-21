/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
library;


import 'package:common/base/mvvm/repo/api_repository.dart';

import '../../mvvm/model/user_bean.dart';




class LoginUserResponse with DataHolder<UserRspBean>{
    LoginUserResponse.fromJson(Map<String, dynamic> map) {
        convert(map, (data) => UserRspBean.fromJson(data));
    }
}


