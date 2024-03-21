import 'dart:ui';

import 'package:get/get.dart';

import 'msg_cn.dart';
import 'msg_en.dart';

/// 多語言表
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': msgEN,
        'zh_CN': msgCN,
      };

  static void toEN() {
    Get.updateLocale(const Locale('en', 'US'));
  }

  static void toCN() {
    Get.updateLocale(const Locale('zh', 'CN'));
  }


  static void switchLanguage() {
    if (Get.locale?.languageCode == 'en') {
      // SaveKey.language.save('zh');
      toCN();
    } else {
      // SaveKey.language.save('en');
      toEN();
    }
  }
}

/// 多語言key
class MsgKey {
  ///通用
  static const String agreeText = 'agreeText';
  static const String cancelText = 'cancelText';
  static const String confirmText = 'confirmText';
  static const String deleteText = 'deleteText';
  static const String selectDateRange = 'selectDateRange';
  ///启动页面
  static const String skinText = 'skinText';
  static const String entryText = 'entryText';

  static const String registerSuccess = 'registerSuccess';

  ///隱私政策
  static const String protocolPageTitle = 'protocolPageTitle';
  static const String protocolPageContent = 'protocolPageContent';

  /// 登陆页面与注册页面提示
  static const String agreementErrorToast = 'agreementErrorToast';
  static const String loginWithOutAccount = 'loginWithOutAccount';
  static const String loginWithOutPassword = 'loginWithOutPassword';
  static const String registerWithOutAccount = 'registerWithOutAccount';
  static const String registerWithOutAuthCode = 'registerWithOutAuthCode';
  static const String registerWithOutPassword = 'registerWithOutPassword';
  static const String registerPasswordNotSame = 'registerPasswordNotSame';
  static const String loginWithOutPatientCard = 'loginWithOutPatientCard';
  static const String registerPasswordNotRespect = 'registerPasswordNotRespect';
  static const String registerPasswordLength = 'registerPasswordLength';
  ///註冊界面控件文字
  static const String registerRetryAutoCode = 'registerRetryAutoCode';
  static const String registerSendAutoCode = 'registerSendAutoCode';
  static const String registerAuthCodeHint = 'registerAuthCodeHint';
  static const String registerPasswordHint = 'registerPasswordHint';
  static const String registerRePasswordHint = 'registerRePasswordHint';
  static const String registerPhoneNumHint = 'registerPhoneNumHint';
  static const String registerAuthCode = 'registerAuthCode';
  static const String registerPhoneNum = 'registerPhoneNum';
  static const String registerPassword = 'registerPassword';
  static const String registerRePassword = 'registerRePassword';
  static const String register = 'register';
  static const String registerHasAccount = 'registerHasAccount';
  static const String registerLoginNow = 'registerLoginNow';

  ///登陸界面控件文字
  static const String loginPhoneHint = 'loginPhoneHint';
  static const String loginPatientHint = 'loginPatientHint';
  static const String loginPasswordHint = 'loginPasswordHint';
  static const String login = 'login';
  static const String loginUnregister = 'loginUnregister';
  static const String loginRegisterNow = 'loginRegisterNow';
  static const String loginByOtherWay = 'loginByOtherWay';
  static const String loginTextUnRegister = 'loginTextUnregister';
  static const String loginTextRegisterNow = 'loginTetRegisterNow';
  static const String loginTextForgotPassword = 'loginTextForgotPassword';

  ///預定詳情界面
  static const String bookingDetailTipText = 'bookingDetailTipText';
  static const String bookingDetailChoosePatient = 'bookingDetailChoosePatient';
  static const String bookingDetailChoosePersonTip =
      'bookingDetailChoosePersonTip';
  static const String bookingDetailNull = 'bookingDetailNull';

  ///忘記密碼界面
  static const String forgotPhoneTitle = 'forgotPhoneTitle';
  static const String forgotPhoneHint = 'forgotPhoneHint';
  static const String forgotAuthCode = 'forgetAuthCode';

  ///驗證碼輸入界面
  static const String authCodeInputError = 'authCodeInputError';
  static const String authCodeInputTitle = 'authCodeInputTitle';
  static const String authCodeDidNotTitle = 'authCodeDidNotTitle';
  static const String authCodeSendCode = 'authCodeSendCode';

  ///重置密碼
  static const String resetCipherTitle = 'resetCipherTitle';
  static const String resetCipherHint = 'resetCipherHint';
  static const String resetReCipherTitle = 'resetReCipherTitle';
  static const String resetReCipherHint = 'resetReCipherHint';
  static const String resetTitle = 'resetTitle';
  static const String resetCipherButton = 'resetCipherButton';

  /// 頁面標題
  static const String appBarTitleBooking = 'appBarTitleBooking';
  static const String appBarTitleDoctors = 'appBarTitleDoctors';
  static const String appBarTitleBookingDetail = 'appBarTitleBookingDetail';
  static const String appBarTitleReport = 'appBarTitleReport';
  static const String appBarTitleWaitingQueue = 'appBarTitleWaitingQueue';
  static const String appBarTitleDoctorDetail = 'appBarTitleDoctorDetail';
  static const String appBarTitleOnlinePay = 'appBarTitleOnlinePay';
  static const String appBarTitleReportQuery = 'appBarTitleReportQuery';
  static const String appbarTitleDetail = 'appbarTitleDetail';
  static const String paymentRequireFail = 'paymentRequireFail';

  static const String doctorDetailsMoreDos = 'doctorDetailsMoreDos';
  static const String doctorDetailsDosInfo = 'doctorDetailsDosInfo';
  static const String doctorDetailsDosRange = 'doctorDetailsDosRange';
  static const String doctorDetailsRest = 'doctorDetailsRest';
  static const String doctor_list_reset = 'doctor_list_reset';
  static const String introduce_text = 'introduce_text';

  /// 首頁
  static const String homeNavBar_home = 'homeNavBar_1';
  static const String homeNavBar_booking = 'homeNavBar_2';
  static const String homeNavBar_notification = 'homeNavBar_3';
  static const String homeNavBar_mine = 'homeNavBar_4';
  static const String home_hospital_info = 'home_hospital_info';
  static const String home_more_info = 'home_more_info';
  static const String home_health_education = 'home_health_education';
  static const String home_health_body_check = 'home_health_body_check';
  static const String home_health_xxxx_info = 'home_health_xxxx_info';

  static const String bookingRecordTile = 'bookingDetailTile';

  static const String bookingRecordPatient = 'bookingRecordPatient';
  static const String waitForPay = 'waitForPay';
  static const String paid = 'paid';
  static const String checkDetails = 'checkDetails';
  static const String checkTime = 'checkTime';
  static const String checkAmount = 'checkAmount';
  static const String didNotMatch = 'didNotMatch';
  static const String checkType = 'checkType';
  static const String payDetail = 'payDetail';
  static const String payWay = 'payWay';
  static const String payId = 'payId';
  static const String payTime = 'payTime';
  static const String payStatus = 'payStatus';
  static const String didNotPay = 'didNotPay';
  static const String paySelf = 'paySelf';
  static const String paidSelf = 'paidSelf';
  static const String paidSuccess = 'paidSuccess';
  static const String padiSuccessTips = 'padiSuccessTips';
  static const String checkWait = 'checkWait';
  static const String checked = 'checked';
  static const String checkState = 'checkState';
  static const String appBarTitleInformation = 'appBarTitleInformation';
  static const String name = 'name';
  static const String bir = 'bir';
  static const String idNo = 'idNo';
  static const String patient = 'pataint';
  static const String relation = 'relation';
  static const String patientRelation = 'patientRelation';
  static const String exitPatient = 'exitPatient';
  static const String myPatientCard = 'myPatientCard';
  static const String queueNum = 'queueNum';
  static const String currentNum ='currentNum';


  /// 歡迎頁
  static const String welcome_title = 'welcome_title';
  static const String welcome_login = 'welcome_login';
  static const String welcome_register = 'welcome_register';

  /// 預約
  static const String bookingTab_1 = 'bookingTab_1';
  static const String bookingTab_2 = 'bookingTab_2';

  /// 醫生列表
  static const String doctorListTab_1 = 'doctorListTab_1';

  /// 預約詳情
  static const String bookingDetail_department = 'bookingDetail_department';
  static const String bookingDetail_doctor = 'bookingDetail_doctor';
  static const String bookingDetail_date = 'bookingDetail_date';
  static const String bookingDetail_time = 'bookingDetail_time';
  static const String bookingDetail_patient_name = 'bookingDetail_patient_name';
  static const String bookingDetail_confirm = 'bookingDetail_confirm';

  /// 預約結果
  static const String bookingResult_success = 'bookingResult_success';
  static const String bookingResult_message = 'bookingResult_message';
  static const String bookingResult_records = 'bookingResult_records';
  static const String bookingResult_redirect_home =
      'bookingResult_redirect_home';

  /// 報告查詢
  static const String reportTab_1 = 'reportQueryTab_1';
  static const String reportTab_2 = 'reportQueryTab_2';
  static const String reportFilter_1 = 'reportFilter_1';
  static const String reportFilter_2 = 'reportFilter_2';
  static const String reportFilter_3 = 'reportFilter_3';
  static const String reportFilter_4 = 'reportFilter_4';
  static const String reportProject = 'reportProject';
  static const String reportDepartment = 'reportDepartment';
  static const String reportDate = 'reportDate';

  /// 我的
  static const String mine_1 = 'mine_1';
  static const String mine_logout = 'logout';
  static const String mine_current_patient = 'mine_current_patient';
  static const String mine_card_no = 'mine_card_no';
  static const String mine_booking_records = 'mine_booking_records';
  static const String mine_payment_records = 'mine_payment_records';
  static const String mine_medical_records = 'mine_report_records';
  static const String mine_patient_management = 'mine_patients';
  static const String mineResetPassword = 'mineResetPassword';
  static const String mineLogOut = 'mineLogOut';
  static const String mineInstruction = 'mineInstruction';

  ///add & update patient
  static const String addUpdatePatientTitle = 'addUpdatePatientTitle';
  static const String addPatientTitle = 'addPatientTitle';
  static const String updatePatientTitle = 'updatePatientTitle';
  static const String patientNameTitle = 'patientNameTitle';
  static const String patientNameHintText = 'patientNameHintText';
  static const String patientIdCardTitle = 'patientIdCardTitle';
  static const String patientIdCardHint = 'patientIdCardHint';
  static const String patientCardNumber = 'patientCardNumber';
  static const String patientCardNumberHint = 'patientCardNumberHint';
  static const String patientBirDayTitle = 'patientBirDayTitle';
  static const String patientBirDayHint = 'patientBirDayHint';
  static const String patientTextTitle = 'patientTextTitle';
  static const String patientBtnTitle = 'patientBtnTitle';

  static const String cardType04 = 'cardType04';
  static const String cardType05 = 'cardType05';
  static const String cardType06 = 'cardType06';
  static const String cardType07 = 'cardType07';
  static const String cardType99 = 'cardType99';

  static const String updateInput01 = 'updateInput01';
  static const String updateInput02 = 'updateInput02';
  static const String updateInput03 = 'updateInput03';
  static const String updateInput04 = 'updateInput04';
  static const String updateInput05 = 'updateInput05';

  static const String takePhoto = 'takePhoto';
  static const String selectPhoto = 'selectPhoto';

  static const String patientManagerAddTitle = 'patientManagerAddTitle';
  static const String patientManagerAgeTitle = 'patientAgeTitle';
  static const String patientManagerDefaultTitle = 'patientDefaultTitle';

  /// 設置
  static const String setting_language = 'setting_language';
  static const String patientManagerUnAgree = 'patientUnAgree';
  static const String patientManagerTitle = 'patientTitle';

  ///註銷
  static const String wipeOutTitle = 'wipeOutTitle';
  static const String wipeOutContent = 'wipeOutContent';
  static const String logOutTitle = 'logoutTitle';
  static const String logOutContent = 'logOutContent';

  static const String today = 'today';
  static const String monday = 'monday';
  static const String tuesday = 'tuesday';
  static const String wednesday = 'wednesday';
  static const String thursday = 'thursday';
  static const String friday = 'friday';
  static const String saturday = 'saturday';
  static const String sunday = 'sunday';
  static const String registerPasswordNotNull = 'registerPasswordNotNull';
  static const String qRCode = 'qRCode';
  static const String ok = 'ok';
  static const String readPrivacy = 'readPrivacy';
  static const String privacy ='privacy';

  static const String amount = 'amount';
}
