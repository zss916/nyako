import 'package:flutter/services.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/some/web_page.dart';
import 'package:nyako/services/user_info.dart';

class AiHelp {
  AiHelp._internal();

  static final AiHelp _instance = AiHelp._internal();

  static AiHelp get instance => _instance;

  Future<void> enterMinAIHelp(int entrance) async {
    String path = await Http.instance.post<String>(NetPath.getAiHelp);
    int level = UserInfo.to.myDetail?.userBalance?.userLevel ?? 0;
    int totalRecharge = UserInfo.to.myDetail?.userBalance?.totalRecharge ?? 0;
    _openAIHelpWebPage(args: {
      "level": level,
      "totalRecharge": totalRecharge,
      "entranceType": entrance,
    }, path: path);
  }

  Future<void> enterOrderAIHelp(String orderInfo) async {
    String path = await Http.instance.post<String>(NetPath.getAiHelp);
    int level = UserInfo.to.myDetail?.userBalance?.userLevel ?? 0;
    int totalRecharge = UserInfo.to.myDetail?.userBalance?.totalRecharge ?? 0;
    _openAIHelpWebPage(args: {
      "level": level,
      "totalRecharge": totalRecharge,
      "orderInfo": orderInfo,
    }, path: path);
  }

  Future _openAIHelpWebPage(
      {Map<String, dynamic>? args, required String path}) async {
    try {
      var user = UserInfo.to.userLogin;

      //todo  该域名找服务端配置，测试时可能需翻墙
      String url = path;
      //String url = "https://help.${AppConstants.aiHelpHost}.org${path}";
      /* url +=
          "?mode=showConversation&conversationIntent=1&alwaysShowHumanSupportButtonInBotPage=true";
      url += "&language=${Get.locale?.languageCode ?? 'en'}";
      url += "&applicationName=${AppInfoService.to.channelName}";
      url += "&userId=${user?.username ?? ""}";
      url += "&userName=${user?.nickname ?? ""}";
      url += "&countryCode=${Get.deviceLocale?.countryCode ?? ''}";*/

      Map<String, dynamic> argsMap = {};

      argsMap['created'] = user?.created ?? 0;
      if (args != null && args.isNotEmpty) {
        argsMap.addAll(args);
      }

      url += "&customData={";
      List argKeys = argsMap.keys.toList();
      for (int i = 0; i < argKeys.length; i++) {
        String key = argKeys[i];
        String value = '${argsMap[key]}';
        url += '"$key":"$value"';
        if (i < argKeys.length - 1) {
          url += ',';
        }
      }
      url += "}";
      // 打开App 内部Web页面
      WebPage.startMe(url, isAiHelp: true);
    } on PlatformException catch (_) {}
  }
}
