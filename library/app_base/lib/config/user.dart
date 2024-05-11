import 'package:app_base/mvvm/model/user_bean.dart';

import '../mvvm/model/home_bean.dart';

class User{
   static late LoginWithCodeRspBean loginRspBean;
   static HomeRsp? loginUserInfo;

   static String  getUserAvator(){
      if(loginUserInfo == null){
         return '';
      }else{
         return loginUserInfo!.avator;
      }
   }
   static String getUserNickName(){
      if(loginUserInfo == null){
         return '';
      }else{
         return loginUserInfo!.nickName;
      }
   }
}