/// 策略模式启动后，全局存放环境变量
/// 必须留空，在app中赋值
class BuildConfig {
  static String envName = '';
  static bool isDebug = false;
  static String host = '';
  static String mediwayRoute = '';
  static int calendarRange = 7;

  static String proxy = '';
  static String proxyPort = '';
}
