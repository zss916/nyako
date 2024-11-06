import 'package:nyako/generated/json/rtm_msg_entity.g.dart';

import '../generated/json/base/json_field.dart';

@JsonSerializable()
class RTMText {
  RTMText();

  factory RTMText.fromJson(Map<String, dynamic> json) => $RTMTextFromJson(json);

  Map<String, dynamic> toJson() => $RTMTextToJson(this);

  int? destructTime;
  String? extra;
  String? messageContent;
  String? msgId;
  // type text = 10
  // type gift = 11
  // type call = 12
  // type imge = 13
  // type voice = 14
  // type video = 15
  // type severImge = 20//服务器图片消息
  // type severVoice = 21 //服务器语音消息
  // type  = 24 //AIA下发的视频
  // type  = 25 //AIB
  // type = 23    服务器会发送begincall
  int? type;
  RTMUser? userInfo;
}

@JsonSerializable()
class RTMUser {
  RTMUser();

  factory RTMUser.fromJson(Map<String, dynamic> json) => $RTMUserFromJson(json);

  Map<String, dynamic> toJson() => $RTMUserToJson(this);

  String? name;
  String? portrait;
  String? uid;
  String? virtualId;
  int? auth;

  /**
   * 真实uid
   */
  // @SerializedName("uid") var uid:String,
  /**
   * 展示给用户看的uid
   */
  // @SerializedName("virtualId") var virtualId:String = "",
  /**
   * 头像地址
   */
  // @SerializedName("portrait") var portrait:String,
  /**
   * 名称
   */
  // @SerializedName("name") var name:String
}

@JsonSerializable()
class RTMMsgText {
  static const int typeCode = 10;
  RTMMsgText();

  factory RTMMsgText.fromJson(Map<String, dynamic> json) =>
      $RTMMsgTextFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgTextToJson(this);

  String? extra;
  String? text;
}

@JsonSerializable()
class RTMMsgVoice {
  // type voice = 14
  // type severVoice = 21 //服务器语音消息
  static const List<int> typeCodes = [14, 21];
  RTMMsgVoice();

  factory RTMMsgVoice.fromJson(Map<String, dynamic> json) =>
      $RTMMsgVoiceFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgVoiceToJson(this);
  String? extra;
  String? voiceUrl;
  int? duration;

  int? destructTime;
  String? messageContent;
  String? msgId;
  RTMUser? userInfo;
}

@JsonSerializable()
class RTMMsgPhoto {
  // type imge = 13
  // type severImge = 20//服务器图片消息
  static const List<int> typeCodes = [13, 20];
  RTMMsgPhoto();

  factory RTMMsgPhoto.fromJson(Map<String, dynamic> json) =>
      $RTMMsgPhotoFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgPhotoToJson(this);
  String? extra;
  String? thumbnailUrl;
  String? imageUrl;
}

@JsonSerializable()
class RTMMsgCallState {
  static const int typeCode = 12;
  RTMMsgCallState();

  factory RTMMsgCallState.fromJson(Map<String, dynamic> json) =>
      $RTMMsgCallStateFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgCallStateToJson(this);
  String? extra;
  String? duration;
  int? statusType;
}

@JsonSerializable()
class RTMMsgGift {
  static const int typeCode = 11;
  RTMMsgGift();

  factory RTMMsgGift.fromJson(Map<String, dynamic> json) =>
      $RTMMsgGiftFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgGiftToJson(this);
  String? extra;
  String? giftId;
  int? quantity;
  int? cost;
  String? sendGiftRecordId;
  String? giftName;
  String? giftImageUrl;

  ///本地
  String? anchorId;
  String? anchorPortrait;
  String? anchorName;
}

@JsonSerializable()
class RTMMsgBeginCall {
  static const int typeCode = 23;
  RTMMsgBeginCall();

  factory RTMMsgBeginCall.fromJson(Map<String, dynamic> json) =>
      $RTMMsgBeginCallFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgBeginCallToJson(this);
  String? channelId;
  int? chargePrice;
  int? propDuration;
  int? remainDiamonds;
  String? extra;
  bool? usedProp;
  String? rtcToken;
  int? isShowDiamondRechargeGuide; // 钻石通话时是否充值引导，0.不引导，1.引导
  int? isShowCardRechargeGuide; // 体验卡通话是否充值引导，0.不引导，1.引导
}

@JsonSerializable()
class RTMMsgAIB {
  static const int typeCode = 25;
  RTMMsgAIB();

  factory RTMMsgAIB.fromJson(Map<String, dynamic> json) =>
      $RTMMsgAIBFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgAIBToJson(this);
  String? extra;
  int? id;
  int? isOnline;
  String? nickname;
  String? portrait;
  String? userId;
}

//{\"callCardCount\":0,\"extra\":\"624ff55eebcc317144526180\",
// \"filename\":\"https://oss.hanilink.com/users/107012498/upload/anchor/upload/video/1505217394515206145.mp4\",
// \"id\":107781256,\"isFollowed\":false,\"isOnline\":1,\"muteStatus\":1,\"nickname\":\"Mary\",
// \"portrait\":\"https://oss.hanilink.com/users_test/107780487/upload/media/2022-03-29/_1648521386627_sendimg.JPEG\",
// \"propDuration\":70000,\"userId\":107780487}
@JsonSerializable()
class RTMMsgAIC {
  static const int typeCode = 24;
  RTMMsgAIC();

  factory RTMMsgAIC.fromJson(Map<String, dynamic> json) =>
      $RTMMsgAICFromJson(json);

  Map<String, dynamic> toJson() => $RTMMsgAICToJson(this);
  String? extra;
  int? callCardCount;
  int? id;
  int? isOnline;
  int? muteStatus;
  int? isCard;
  int? propDuration;
  bool? isFollowed;
  String? nickname;
  String? filename;
  String? portrait;
  String? userId;
}
