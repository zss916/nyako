class Environment {
  static const String env = String.fromEnvironment('env', defaultValue: '');

  static const bool openGooglePay =
      bool.fromEnvironment('openGooglePay', defaultValue: true);

  static const bool isOpenOnlinePlugin =
      bool.fromEnvironment('otherOnlinePlugin', defaultValue: true);

  static const int appMode = int.fromEnvironment('appMode', defaultValue: 0);

  static const bool haveTestLogin =
      bool.fromEnvironment('haveTestLogin', defaultValue: false);

  static const bool openShowAiv =
      bool.fromEnvironment('openShowAiv', defaultValue: false);

  static const bool showLogger =
      bool.fromEnvironment('showLogger', defaultValue: false);

  static const bool openSettingTest =
      bool.fromEnvironment('openSettingTest', defaultValue: false);

  static const bool isTestMode =
      bool.fromEnvironment('isTestMode', defaultValue: false);
}
