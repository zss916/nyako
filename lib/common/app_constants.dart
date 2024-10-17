import 'package:get/get_utils/src/platform/platform.dart';
import 'package:oliapro/utils/environment.dart';

class AppConstants {
  // flutter dart 混淆
  // flutter build apk --obfuscate --split-debug-info=/<project-name>/<directory>
  // flutter build apk --obfuscate --split-debug-info=./obfuse
  // flutter build appbundle --obfuscate --split-debug-info=./obfuse

  /// 线上模式true(手动)
  static bool openGooglePay = Environment.openGooglePay;
  static bool isOpenOnlinePlugin = Environment.isOpenOnlinePlugin;

  static bool isSemantics = false;

  ///发包要注意改成: false （手动）
  static bool isTestMode = Environment.isTestMode;
  static bool haveTestLogin = Environment.haveTestLogin;
  static bool openSettingTest = Environment.openSettingTest;
  static bool openShowAiv = Environment.openShowAiv;
  static bool showLogger = Environment.showLogger;

  static bool openShowRtm = false;

  static bool openShowCall = false;

  /// adjust默认值，(上线放开)
  static String adjustId = '';

  static String adjustEventKey = '';

  ///appName
  static const appName = 'Nyako';
  static const channelName = 'olialite';

  /// 个人隐私和协议
  static const privacyPolicy = "https://api.olialite.org/pages/privacy.html";
  static const agreement = "https://api.olialite.org/pages/agreement.html";

  ///删除账号
/*  static const deleteURL =
      "https://user-delete.olialite.org/#/logoff?api=api.olialite.org&amp;t=d";*/

  ///aiHelp 的host
  static const aiHelpHost = "olialite";

  ///当前是审核模式？(接口控制)
  static bool isFakeMode = false;

  /// 0正常模式，1安卓审核模式，2苹果审核模式
  /// 正常模式：底部先首页后匹配，首页分热门主播、在线主播、关注
  /// 安卓审核模式：去掉了匹配，隐藏打电话按钮
  /// 苹果审核模式：底部先匹配，后首页。首页分动态、关注
  static int get appMode {
    if (AppConstants.isFakeMode) {
      if (GetPlatform.isAndroid) {
        return 1;
      } else if (GetPlatform.isIOS) {
        return 2;
      }
    } else {
      return 0;
    }
    return 0;
  }

  static const giftsJson = "giftsJson"; //
  static const testModeStyle = "testModeStyle"; //
  static const blackList = "blackList"; //
  static const hadShowDragTip = "hadShowDragTip"; //
  static const hadShowMatchDragTip = "hadShowMatchDragTip"; //
  static const hadShowHomeDiscoverDragTip = "hadShowHomeDiscoverDragTip";
  static const systemId = "9999"; //
  // 为了ios审核，加上这个聊天对象，方便做UGC
  static const serviceId = "10000"; //

  ///是否匹配中,用于是否显示被叫页面
  static bool isMatching = isMatch;

  ///是否VIP pay+
  static bool isVIPPay = false;

  ///是否快捷 pay+
  static bool isQuickPay = false;

  ///是否匹配
  static bool isMatch = false;

  ///是否 pay channel
  static bool isChannelPay = false;

  ///是否 被呼叫
  static bool isBeCall = false;

  ///是否 在被叫页面的权限页面
  static bool isBeCallPermission = false;

  ///是否 开启 facebook login
  static bool openFacebookLogin = true;

  static bool isCreatePayOrder = false;

  static String fontsRegular = 'NotoSans-Regular';
  static String fontsBold = 'NotoSans-Bold';
}
