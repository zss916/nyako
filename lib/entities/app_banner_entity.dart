import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:nyako/generated/json/base/json_field.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/services/app_info_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/json/app_banner_entity.g.dart';

@JsonSerializable()
class BannerBean {
  BannerBean();

  factory BannerBean.fromJson(Map<String, dynamic> json) =>
      $BannerBeanFromJson(json);

  Map<String, dynamic> toJson() => $BannerBeanToJson(this);

  int? updatedAt;
  int? category;
  int? bid;
  String? link;
  int? ranking;
  int? type;
  String? title;
  String? appName;
  String? cover;
  int? target;
  int? createdAt;
  int? areaCode;

  clickBanner() async {
    if (link?.contains("/vip") == true) {
      sheetToVip(path: ChargePath.home_banner_recharge);
    } else if (link?.contains("play.google.com") == true) {
      //打开google play
      String? packageName = link?.split("=").last;
      if (packageName != null) {
        LaunchReview.launch(androidAppId: packageName);
      }
    } else if (link?.contains("/#") == true) {
    } else if (target == 0) {
      if (await canLaunchUrl(Uri.parse(link ?? ""))) {
        launchUrl(Uri.parse(link ?? ""));
      }
    } else if (target == 1) {
      if (link?.contains("/user?id") == true) {
        String? anchorId = link?.split("=").last;
        ARoutes.toAnchorDetail(anchorId);
      } else if (link?.contains("/pay") == true) {
        ARoutes.toRecharge();
      } else if (link?.contains("/feedback") == true) {
        ARoutes.toReport();
      } else if (link?.contains("/whatsApp=") == true) {
        String? whatsappid = link?.split("=").last;
        if (whatsappid != null) {
          final info = await PackageInfo.fromPlatform();
          if (GetPlatform.isIOS) {
            String url =
                "https://wa.me/$whatsappid/?text=AppName:${info.appName},appVersion:${AppInfoService.to.version},System:iOS${AppInfoService.to.appSystemVersionKey},uid:${UserInfo.to.uid}";
            if (await canLaunchUrl(Uri.parse(url))) {
              launchUrl(Uri.parse(url));
            }
          } else if (GetPlatform.isAndroid) {
            String url =
                "https://wa.me/$whatsappid/?text=AppName:${info.appName},appVersion:${AppInfoService.to.version},System:Android${AppInfoService.to.appSystemVersionKey},uid:${UserInfo.to.uid}";
            if (await canLaunchUrl(Uri.parse(url))) {
              launchUrl(Uri.parse(url));
            }
          }
        }
      } else if (link?.contains("/shareApp") == true) {
        ARoutes.toShare();
      } else if (link?.contains("/playbubble") == true) {
        // PlayTool.globalShowPlayBubble(guideId: 4);
      } else if (link?.contains("/playforest") == true) {
        // PlayTool.globalShowPlayForest(guideId: 4);
      } else if (link?.contains("/playtracecar") == true) {
        // PlayTool.globalShowPlayTraceCar(guideId: 4);
      } else if (link?.contains("/playluckynum") == true) {
        // PlayTool.globalShowPlayLuckyNum(guideId: 4);
      }
    }
  }
}
