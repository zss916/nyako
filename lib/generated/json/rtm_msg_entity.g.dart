import 'package:nyako/agora/rtm_msg_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

RTMText $RTMTextFromJson(Map<String, dynamic> json) {
  final RTMText rTMText = RTMText();
  final int? destructTime = jsonConvert.convert<int>(json['destructTime']);
  if (destructTime != null) {
    rTMText.destructTime = destructTime;
  }
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMText.extra = extra;
  }
  final String? messageContent =
      jsonConvert.convert<String>(json['messageContent']);
  if (messageContent != null) {
    rTMText.messageContent = messageContent;
  }
  final String? msgId = jsonConvert.convert<String>(json['msgId']);
  if (msgId != null) {
    rTMText.msgId = msgId;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    rTMText.type = type;
  }
  final RTMUser? userInfo = jsonConvert.convert<RTMUser>(json['userInfo']);
  if (userInfo != null) {
    rTMText.userInfo = userInfo;
  }
  return rTMText;
}

Map<String, dynamic> $RTMTextToJson(RTMText entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['destructTime'] = entity.destructTime;
  data['extra'] = entity.extra;
  data['messageContent'] = entity.messageContent;
  data['msgId'] = entity.msgId;
  data['type'] = entity.type;
  data['userInfo'] = entity.userInfo?.toJson();
  return data;
}

extension RTMTextExtension on RTMText {
  RTMText copyWith({
    int? destructTime,
    String? extra,
    String? messageContent,
    String? msgId,
    int? type,
    RTMUser? userInfo,
  }) {
    return RTMText()
      ..destructTime = destructTime ?? this.destructTime
      ..extra = extra ?? this.extra
      ..messageContent = messageContent ?? this.messageContent
      ..msgId = msgId ?? this.msgId
      ..type = type ?? this.type
      ..userInfo = userInfo ?? this.userInfo;
  }
}

RTMUser $RTMUserFromJson(Map<String, dynamic> json) {
  final RTMUser rTMUser = RTMUser();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    rTMUser.name = name;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    rTMUser.portrait = portrait;
  }
  final String? uid = jsonConvert.convert<String>(json['uid']);
  if (uid != null) {
    rTMUser.uid = uid;
  }
  final String? virtualId = jsonConvert.convert<String>(json['virtualId']);
  if (virtualId != null) {
    rTMUser.virtualId = virtualId;
  }
  final int? auth = jsonConvert.convert<int>(json['auth']);
  if (auth != null) {
    rTMUser.auth = auth;
  }
  return rTMUser;
}

Map<String, dynamic> $RTMUserToJson(RTMUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['portrait'] = entity.portrait;
  data['uid'] = entity.uid;
  data['virtualId'] = entity.virtualId;
  data['auth'] = entity.auth;
  return data;
}

extension RTMUserExtension on RTMUser {
  RTMUser copyWith({
    String? name,
    String? portrait,
    String? uid,
    String? virtualId,
    int? auth,
  }) {
    return RTMUser()
      ..name = name ?? this.name
      ..portrait = portrait ?? this.portrait
      ..uid = uid ?? this.uid
      ..virtualId = virtualId ?? this.virtualId
      ..auth = auth ?? this.auth;
  }
}

RTMMsgText $RTMMsgTextFromJson(Map<String, dynamic> json) {
  final RTMMsgText rTMMsgText = RTMMsgText();
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgText.extra = extra;
  }
  final String? text = jsonConvert.convert<String>(json['text']);
  if (text != null) {
    rTMMsgText.text = text;
  }
  return rTMMsgText;
}

Map<String, dynamic> $RTMMsgTextToJson(RTMMsgText entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['extra'] = entity.extra;
  data['text'] = entity.text;
  return data;
}

extension RTMMsgTextExtension on RTMMsgText {
  RTMMsgText copyWith({
    String? extra,
    String? text,
  }) {
    return RTMMsgText()
      ..extra = extra ?? this.extra
      ..text = text ?? this.text;
  }
}

RTMMsgVoice $RTMMsgVoiceFromJson(Map<String, dynamic> json) {
  final RTMMsgVoice rTMMsgVoice = RTMMsgVoice();
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgVoice.extra = extra;
  }
  final String? voiceUrl = jsonConvert.convert<String>(json['voiceUrl']);
  if (voiceUrl != null) {
    rTMMsgVoice.voiceUrl = voiceUrl;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    rTMMsgVoice.duration = duration;
  }
  final int? destructTime = jsonConvert.convert<int>(json['destructTime']);
  if (destructTime != null) {
    rTMMsgVoice.destructTime = destructTime;
  }
  final String? messageContent =
      jsonConvert.convert<String>(json['messageContent']);
  if (messageContent != null) {
    rTMMsgVoice.messageContent = messageContent;
  }
  final String? msgId = jsonConvert.convert<String>(json['msgId']);
  if (msgId != null) {
    rTMMsgVoice.msgId = msgId;
  }
  final RTMUser? userInfo = jsonConvert.convert<RTMUser>(json['userInfo']);
  if (userInfo != null) {
    rTMMsgVoice.userInfo = userInfo;
  }
  return rTMMsgVoice;
}

Map<String, dynamic> $RTMMsgVoiceToJson(RTMMsgVoice entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['extra'] = entity.extra;
  data['voiceUrl'] = entity.voiceUrl;
  data['duration'] = entity.duration;
  data['destructTime'] = entity.destructTime;
  data['messageContent'] = entity.messageContent;
  data['msgId'] = entity.msgId;
  data['userInfo'] = entity.userInfo?.toJson();
  return data;
}

extension RTMMsgVoiceExtension on RTMMsgVoice {
  RTMMsgVoice copyWith({
    String? extra,
    String? voiceUrl,
    int? duration,
    int? destructTime,
    String? messageContent,
    String? msgId,
    RTMUser? userInfo,
  }) {
    return RTMMsgVoice()
      ..extra = extra ?? this.extra
      ..voiceUrl = voiceUrl ?? this.voiceUrl
      ..duration = duration ?? this.duration
      ..destructTime = destructTime ?? this.destructTime
      ..messageContent = messageContent ?? this.messageContent
      ..msgId = msgId ?? this.msgId
      ..userInfo = userInfo ?? this.userInfo;
  }
}

RTMMsgPhoto $RTMMsgPhotoFromJson(Map<String, dynamic> json) {
  final RTMMsgPhoto rTMMsgPhoto = RTMMsgPhoto();
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgPhoto.extra = extra;
  }
  final String? thumbnailUrl =
      jsonConvert.convert<String>(json['thumbnailUrl']);
  if (thumbnailUrl != null) {
    rTMMsgPhoto.thumbnailUrl = thumbnailUrl;
  }
  final String? imageUrl = jsonConvert.convert<String>(json['imageUrl']);
  if (imageUrl != null) {
    rTMMsgPhoto.imageUrl = imageUrl;
  }
  return rTMMsgPhoto;
}

Map<String, dynamic> $RTMMsgPhotoToJson(RTMMsgPhoto entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['extra'] = entity.extra;
  data['thumbnailUrl'] = entity.thumbnailUrl;
  data['imageUrl'] = entity.imageUrl;
  return data;
}

extension RTMMsgPhotoExtension on RTMMsgPhoto {
  RTMMsgPhoto copyWith({
    String? extra,
    String? thumbnailUrl,
    String? imageUrl,
  }) {
    return RTMMsgPhoto()
      ..extra = extra ?? this.extra
      ..thumbnailUrl = thumbnailUrl ?? this.thumbnailUrl
      ..imageUrl = imageUrl ?? this.imageUrl;
  }
}

RTMMsgCallState $RTMMsgCallStateFromJson(Map<String, dynamic> json) {
  final RTMMsgCallState rTMMsgCallState = RTMMsgCallState();
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgCallState.extra = extra;
  }
  final String? duration = jsonConvert.convert<String>(json['duration']);
  if (duration != null) {
    rTMMsgCallState.duration = duration;
  }
  final int? statusType = jsonConvert.convert<int>(json['statusType']);
  if (statusType != null) {
    rTMMsgCallState.statusType = statusType;
  }
  return rTMMsgCallState;
}

Map<String, dynamic> $RTMMsgCallStateToJson(RTMMsgCallState entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['extra'] = entity.extra;
  data['duration'] = entity.duration;
  data['statusType'] = entity.statusType;
  return data;
}

extension RTMMsgCallStateExtension on RTMMsgCallState {
  RTMMsgCallState copyWith({
    String? extra,
    String? duration,
    int? statusType,
  }) {
    return RTMMsgCallState()
      ..extra = extra ?? this.extra
      ..duration = duration ?? this.duration
      ..statusType = statusType ?? this.statusType;
  }
}

RTMMsgGift $RTMMsgGiftFromJson(Map<String, dynamic> json) {
  final RTMMsgGift rTMMsgGift = RTMMsgGift();
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgGift.extra = extra;
  }
  final String? giftId = jsonConvert.convert<String>(json['giftId']);
  if (giftId != null) {
    rTMMsgGift.giftId = giftId;
  }
  final int? quantity = jsonConvert.convert<int>(json['quantity']);
  if (quantity != null) {
    rTMMsgGift.quantity = quantity;
  }
  final int? cost = jsonConvert.convert<int>(json['cost']);
  if (cost != null) {
    rTMMsgGift.cost = cost;
  }
  final String? sendGiftRecordId =
      jsonConvert.convert<String>(json['sendGiftRecordId']);
  if (sendGiftRecordId != null) {
    rTMMsgGift.sendGiftRecordId = sendGiftRecordId;
  }
  final String? giftName = jsonConvert.convert<String>(json['giftName']);
  if (giftName != null) {
    rTMMsgGift.giftName = giftName;
  }
  final String? giftImageUrl =
      jsonConvert.convert<String>(json['giftImageUrl']);
  if (giftImageUrl != null) {
    rTMMsgGift.giftImageUrl = giftImageUrl;
  }
  final String? anchorId = jsonConvert.convert<String>(json['anchorId']);
  if (anchorId != null) {
    rTMMsgGift.anchorId = anchorId;
  }
  final String? anchorPortrait =
      jsonConvert.convert<String>(json['anchorPortrait']);
  if (anchorPortrait != null) {
    rTMMsgGift.anchorPortrait = anchorPortrait;
  }
  final String? anchorName = jsonConvert.convert<String>(json['anchorName']);
  if (anchorName != null) {
    rTMMsgGift.anchorName = anchorName;
  }
  return rTMMsgGift;
}

Map<String, dynamic> $RTMMsgGiftToJson(RTMMsgGift entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['extra'] = entity.extra;
  data['giftId'] = entity.giftId;
  data['quantity'] = entity.quantity;
  data['cost'] = entity.cost;
  data['sendGiftRecordId'] = entity.sendGiftRecordId;
  data['giftName'] = entity.giftName;
  data['giftImageUrl'] = entity.giftImageUrl;
  data['anchorId'] = entity.anchorId;
  data['anchorPortrait'] = entity.anchorPortrait;
  data['anchorName'] = entity.anchorName;
  return data;
}

extension RTMMsgGiftExtension on RTMMsgGift {
  RTMMsgGift copyWith({
    String? extra,
    String? giftId,
    int? quantity,
    int? cost,
    String? sendGiftRecordId,
    String? giftName,
    String? giftImageUrl,
    String? anchorId,
    String? anchorPortrait,
    String? anchorName,
  }) {
    return RTMMsgGift()
      ..extra = extra ?? this.extra
      ..giftId = giftId ?? this.giftId
      ..quantity = quantity ?? this.quantity
      ..cost = cost ?? this.cost
      ..sendGiftRecordId = sendGiftRecordId ?? this.sendGiftRecordId
      ..giftName = giftName ?? this.giftName
      ..giftImageUrl = giftImageUrl ?? this.giftImageUrl
      ..anchorId = anchorId ?? this.anchorId
      ..anchorPortrait = anchorPortrait ?? this.anchorPortrait
      ..anchorName = anchorName ?? this.anchorName;
  }
}

RTMMsgBeginCall $RTMMsgBeginCallFromJson(Map<String, dynamic> json) {
  final RTMMsgBeginCall rTMMsgBeginCall = RTMMsgBeginCall();
  final String? channelId = jsonConvert.convert<String>(json['channelId']);
  if (channelId != null) {
    rTMMsgBeginCall.channelId = channelId;
  }
  final int? chargePrice = jsonConvert.convert<int>(json['chargePrice']);
  if (chargePrice != null) {
    rTMMsgBeginCall.chargePrice = chargePrice;
  }
  final int? propDuration = jsonConvert.convert<int>(json['propDuration']);
  if (propDuration != null) {
    rTMMsgBeginCall.propDuration = propDuration;
  }
  final int? remainDiamonds = jsonConvert.convert<int>(json['remainDiamonds']);
  if (remainDiamonds != null) {
    rTMMsgBeginCall.remainDiamonds = remainDiamonds;
  }
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgBeginCall.extra = extra;
  }
  final bool? usedProp = jsonConvert.convert<bool>(json['usedProp']);
  if (usedProp != null) {
    rTMMsgBeginCall.usedProp = usedProp;
  }
  final String? rtcToken = jsonConvert.convert<String>(json['rtcToken']);
  if (rtcToken != null) {
    rTMMsgBeginCall.rtcToken = rtcToken;
  }
  final int? isShowDiamondRechargeGuide =
      jsonConvert.convert<int>(json['isShowDiamondRechargeGuide']);
  if (isShowDiamondRechargeGuide != null) {
    rTMMsgBeginCall.isShowDiamondRechargeGuide = isShowDiamondRechargeGuide;
  }
  final int? isShowCardRechargeGuide =
      jsonConvert.convert<int>(json['isShowCardRechargeGuide']);
  if (isShowCardRechargeGuide != null) {
    rTMMsgBeginCall.isShowCardRechargeGuide = isShowCardRechargeGuide;
  }
  return rTMMsgBeginCall;
}

Map<String, dynamic> $RTMMsgBeginCallToJson(RTMMsgBeginCall entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['channelId'] = entity.channelId;
  data['chargePrice'] = entity.chargePrice;
  data['propDuration'] = entity.propDuration;
  data['remainDiamonds'] = entity.remainDiamonds;
  data['extra'] = entity.extra;
  data['usedProp'] = entity.usedProp;
  data['rtcToken'] = entity.rtcToken;
  data['isShowDiamondRechargeGuide'] = entity.isShowDiamondRechargeGuide;
  data['isShowCardRechargeGuide'] = entity.isShowCardRechargeGuide;
  return data;
}

extension RTMMsgBeginCallExtension on RTMMsgBeginCall {
  RTMMsgBeginCall copyWith({
    String? channelId,
    int? chargePrice,
    int? propDuration,
    int? remainDiamonds,
    String? extra,
    bool? usedProp,
    String? rtcToken,
    int? isShowDiamondRechargeGuide,
    int? isShowCardRechargeGuide,
  }) {
    return RTMMsgBeginCall()
      ..channelId = channelId ?? this.channelId
      ..chargePrice = chargePrice ?? this.chargePrice
      ..propDuration = propDuration ?? this.propDuration
      ..remainDiamonds = remainDiamonds ?? this.remainDiamonds
      ..extra = extra ?? this.extra
      ..usedProp = usedProp ?? this.usedProp
      ..rtcToken = rtcToken ?? this.rtcToken
      ..isShowDiamondRechargeGuide =
          isShowDiamondRechargeGuide ?? this.isShowDiamondRechargeGuide
      ..isShowCardRechargeGuide =
          isShowCardRechargeGuide ?? this.isShowCardRechargeGuide;
  }
}

RTMMsgAIB $RTMMsgAIBFromJson(Map<String, dynamic> json) {
  final RTMMsgAIB rTMMsgAIB = RTMMsgAIB();
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgAIB.extra = extra;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    rTMMsgAIB.id = id;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    rTMMsgAIB.isOnline = isOnline;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    rTMMsgAIB.nickname = nickname;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    rTMMsgAIB.portrait = portrait;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    rTMMsgAIB.userId = userId;
  }
  return rTMMsgAIB;
}

Map<String, dynamic> $RTMMsgAIBToJson(RTMMsgAIB entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['extra'] = entity.extra;
  data['id'] = entity.id;
  data['isOnline'] = entity.isOnline;
  data['nickname'] = entity.nickname;
  data['portrait'] = entity.portrait;
  data['userId'] = entity.userId;
  return data;
}

extension RTMMsgAIBExtension on RTMMsgAIB {
  RTMMsgAIB copyWith({
    String? extra,
    int? id,
    int? isOnline,
    String? nickname,
    String? portrait,
    String? userId,
  }) {
    return RTMMsgAIB()
      ..extra = extra ?? this.extra
      ..id = id ?? this.id
      ..isOnline = isOnline ?? this.isOnline
      ..nickname = nickname ?? this.nickname
      ..portrait = portrait ?? this.portrait
      ..userId = userId ?? this.userId;
  }
}

RTMMsgAIC $RTMMsgAICFromJson(Map<String, dynamic> json) {
  final RTMMsgAIC rTMMsgAIC = RTMMsgAIC();
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rTMMsgAIC.extra = extra;
  }
  final int? callCardCount = jsonConvert.convert<int>(json['callCardCount']);
  if (callCardCount != null) {
    rTMMsgAIC.callCardCount = callCardCount;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    rTMMsgAIC.id = id;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    rTMMsgAIC.isOnline = isOnline;
  }
  final int? muteStatus = jsonConvert.convert<int>(json['muteStatus']);
  if (muteStatus != null) {
    rTMMsgAIC.muteStatus = muteStatus;
  }
  final int? isCard = jsonConvert.convert<int>(json['isCard']);
  if (isCard != null) {
    rTMMsgAIC.isCard = isCard;
  }
  final int? propDuration = jsonConvert.convert<int>(json['propDuration']);
  if (propDuration != null) {
    rTMMsgAIC.propDuration = propDuration;
  }
  final bool? isFollowed = jsonConvert.convert<bool>(json['isFollowed']);
  if (isFollowed != null) {
    rTMMsgAIC.isFollowed = isFollowed;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    rTMMsgAIC.nickname = nickname;
  }
  final String? filename = jsonConvert.convert<String>(json['filename']);
  if (filename != null) {
    rTMMsgAIC.filename = filename;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    rTMMsgAIC.portrait = portrait;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    rTMMsgAIC.userId = userId;
  }
  return rTMMsgAIC;
}

Map<String, dynamic> $RTMMsgAICToJson(RTMMsgAIC entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['extra'] = entity.extra;
  data['callCardCount'] = entity.callCardCount;
  data['id'] = entity.id;
  data['isOnline'] = entity.isOnline;
  data['muteStatus'] = entity.muteStatus;
  data['isCard'] = entity.isCard;
  data['propDuration'] = entity.propDuration;
  data['isFollowed'] = entity.isFollowed;
  data['nickname'] = entity.nickname;
  data['filename'] = entity.filename;
  data['portrait'] = entity.portrait;
  data['userId'] = entity.userId;
  return data;
}

extension RTMMsgAICExtension on RTMMsgAIC {
  RTMMsgAIC copyWith({
    String? extra,
    int? callCardCount,
    int? id,
    int? isOnline,
    int? muteStatus,
    int? isCard,
    int? propDuration,
    bool? isFollowed,
    String? nickname,
    String? filename,
    String? portrait,
    String? userId,
  }) {
    return RTMMsgAIC()
      ..extra = extra ?? this.extra
      ..callCardCount = callCardCount ?? this.callCardCount
      ..id = id ?? this.id
      ..isOnline = isOnline ?? this.isOnline
      ..muteStatus = muteStatus ?? this.muteStatus
      ..isCard = isCard ?? this.isCard
      ..propDuration = propDuration ?? this.propDuration
      ..isFollowed = isFollowed ?? this.isFollowed
      ..nickname = nickname ?? this.nickname
      ..filename = filename ?? this.filename
      ..portrait = portrait ?? this.portrait
      ..userId = userId ?? this.userId;
  }
}
