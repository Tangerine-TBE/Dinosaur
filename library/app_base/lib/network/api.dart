class Api {
  static const String appSecret= "y7bUVUsTZ4WufEnF";
  static const String testUrl = "/getSupportCityString";
  // profile
  static const String me = "me/profile";
  //登陆
  static const String loginUrl_Get = 'login';
  //注册
  static const String register_Post = 'user/register';

  //重置密碼 --註冊
  static const String forget_Post = 'user/forgetPassword';
  //訂單信息請求
  static const String payInfo_Post = 'order/pay';
  //驗證碼請求 --需要token驗證
  static const String verificationUser_Post = 'user/verificationCode';
  //我的-註銷
  static const String wipeOut_Put = 'user/cancel';
  //验证码请求 --不需要token驗證
  static const String verification_Post= 'smslog/verificationCode';
  //重置密碼 --我的
  static const String resetPassword_Put ='user/resetPassword';
  //退出登陸 --我的
  static const String logout_Get ='user/logout';
  //獲取就診人列表
  static const String patientList_Get ='patientcard/getList';
  //添加一個就診人
  static const String addPatient_Post = 'patientcard/bind';
  //確認添加一個就這人
  static const String submitBind_Put = 'patientcard/submitBind';
  //查询所有医生的相关数据
  static const String query_all_dcotor_info = 'doctor/getList';
  //查询所有科室的相关数据
  static const String query_all_department_info = 'department/getList';
  //就诊人图片添加
  static const String addPatientPic_put= 'user/update';
  //就诊人关系
  static const String patientRelation_Get = 'patientcard/getRelationList';
  //获取我的信息
  static const String mineInfo_Get ='user/get';

  //獲取字典信息
  static const String sysdictInfo_Get = 'sysdict/getList';
  //删除就诊卡
  static const String patientCardDelete_delete = 'patientcard/delete';
}



