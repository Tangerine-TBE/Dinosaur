import 'package:app_base/mvvm/model/user_bean.dart';

import '../mvvm/model/home_bean.dart';

class User{
   static  LoginWithCodeRspBean? loginRspBean;
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
   static String getUserId(){
      if(loginUserInfo == null){
         return '';
      }else{
         return loginUserInfo!.id;
      }
   }
   static int getUserFansCount(){
      if(loginUserInfo == null){
         return 0;
      }else{
         return loginUserInfo!.fansCount;
      }
   }
   static int getUserFavorCount(){
      if(loginUserInfo == null){
         return 0 ;
      }else{
         return loginUserInfo!.favorCount;
      }
   }
   static int getUserLikeCount(){
      if(loginUserInfo == null){
         return 0;
      }else{
         return loginUserInfo!.likeCount;
      }
   }
}