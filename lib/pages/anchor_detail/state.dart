part of 'index.dart';

class AnchorState {
  ///用户Vip
  late bool userVip = (UserInfo.to.myDetail!.isVip! == 1);

  int? anchorId = Get.arguments[0];
  late HostDetail host = HostDetail();
  int get lineState => host.lineState();
  String get nickname => (host.nickname ?? "--").convertName;
  bool get canVideo =>
      host.isOnline == 1 &&
      host.isDoNotDisturb == 0 &&
      !AppConstants.isFakeMode;
  String get charge => "${host.charge ?? 0}";
  String get portrait => host.portrait ?? "";
  bool get followed => host.followed == 1;

  late List<HostMedia> medias = []; //相册(图片)

  late List<HostMedia> videos = []; //相册(视频)

  late List<HostMedia> data = []; //相册(视频+图片)

  late List<MomentDetail> moments = []; //动态

  late List<ContributeEntity> contributions = []; //贡献排行榜
}
