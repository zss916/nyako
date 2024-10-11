part of 'index.dart';

class MineSate {
  InfoDetail? myDetail = UserInfo.to.myDetail;
  String get followedNum => (myDetail?.followingCount ?? 0).toString();
  String get nickName => myDetail?.nickname ?? "--";
  String get portrait => myDetail?.portrait ?? "";
  String get username => myDetail?.username ?? "--";
  String? get inviterCode => (myDetail?.inviterCode);
  bool get isVip => myDetail?.isVip == 1;
  int get endTime => myDetail?.vipEndTime ?? 0;
  int get propCount => myDetail?.propCount ?? 0;

  ///总道具卡
  int get totalPropCount =>
      (myDetail?.propCount ?? 0) + (UserInfo.to.getChatCardNum());

  ///
  int get remainDiamonds => myDetail?.userBalance?.remainDiamonds ?? 0;
  bool get isBindGoogle => myDetail?.boundGoogle == 1;
  bool get showGender => myDetail?.gender != null;
  bool get isMan => myDetail?.gender == 1;
  int get createdAt => myDetail?.createdAt ?? 0;
  bool get isTimeOut => myDetail?.isTimeOut() ?? false;
  var num = 0.obs;
  var dnd = false.obs;

  bool get hasSignFrame => UserInfo.to.hasSignFrame;

  String get showVipEndTime => Get.isInd
      ? dateFormat((myDetail?.vipEndTime ?? 0),
          formatStr: Get.isEn ? "dd/MM/yyyy" : 'yyyy.MM.dd')
      : Tr.app_time_end.trArgs([
          dateFormat((myDetail?.vipEndTime ?? 0),
              formatStr: Get.isEn ? "dd/MM/yyyy" : 'yyyy.MM.dd')
        ]);
}
