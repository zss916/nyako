import 'package:oliapro/entities/app_moment_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

MomentDetail $MomentDetailFromJson(Map<String, dynamic> json) {
  final MomentDetail momentDetail = MomentDetail();
  final String? momentId = jsonConvert.convert<String>(json['momentId']);
  if (momentId != null) {
    momentDetail.momentId = momentId;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    momentDetail.userId = userId;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    momentDetail.content = content;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    momentDetail.username = username;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    momentDetail.createdAt = createdAt;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    momentDetail.portrait = portrait;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    momentDetail.nickname = nickname;
  }
  final int? isDoNotDisturb = jsonConvert.convert<int>(json['isDoNotDisturb']);
  if (isDoNotDisturb != null) {
    momentDetail.isDoNotDisturb = isDoNotDisturb;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    momentDetail.isOnline = isOnline;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    momentDetail.gender = gender;
  }
  final int? birthday = jsonConvert.convert<int>(json['birthday']);
  if (birthday != null) {
    momentDetail.birthday = birthday;
  }
  final int? charge = jsonConvert.convert<int>(json['charge']);
  if (charge != null) {
    momentDetail.charge = charge;
  }
  final int? followed = jsonConvert.convert<int>(json['followed']);
  if (followed != null) {
    momentDetail.followed = followed;
  }
  final int? followCount = jsonConvert.convert<int>(json['followCount']);
  if (followCount != null) {
    momentDetail.followCount = followCount;
  }
  final int? praised = jsonConvert.convert<int>(json['praised']);
  if (praised != null) {
    momentDetail.praised = praised;
  }
  final int? praiseCount = jsonConvert.convert<int>(json['praiseCount']);
  if (praiseCount != null) {
    momentDetail.praiseCount = praiseCount;
  }
  final List<MomentMedia>? medias = (json['medias'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<MomentMedia>(e) as MomentMedia)
      .toList();
  if (medias != null) {
    momentDetail.medias = medias;
  }
  return momentDetail;
}

Map<String, dynamic> $MomentDetailToJson(MomentDetail entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['momentId'] = entity.momentId;
  data['userId'] = entity.userId;
  data['content'] = entity.content;
  data['username'] = entity.username;
  data['createdAt'] = entity.createdAt;
  data['portrait'] = entity.portrait;
  data['nickname'] = entity.nickname;
  data['isDoNotDisturb'] = entity.isDoNotDisturb;
  data['isOnline'] = entity.isOnline;
  data['gender'] = entity.gender;
  data['birthday'] = entity.birthday;
  data['charge'] = entity.charge;
  data['followed'] = entity.followed;
  data['followCount'] = entity.followCount;
  data['praised'] = entity.praised;
  data['praiseCount'] = entity.praiseCount;
  data['medias'] = entity.medias?.map((v) => v.toJson()).toList();
  return data;
}

extension MomentDetailExtension on MomentDetail {
  MomentDetail copyWith({
    String? momentId,
    String? userId,
    String? content,
    String? username,
    int? createdAt,
    String? portrait,
    String? nickname,
    int? isDoNotDisturb,
    int? isOnline,
    int? gender,
    int? birthday,
    int? charge,
    int? followed,
    int? followCount,
    int? praised,
    int? praiseCount,
    List<MomentMedia>? medias,
  }) {
    return MomentDetail()
      ..momentId = momentId ?? this.momentId
      ..userId = userId ?? this.userId
      ..content = content ?? this.content
      ..username = username ?? this.username
      ..createdAt = createdAt ?? this.createdAt
      ..portrait = portrait ?? this.portrait
      ..nickname = nickname ?? this.nickname
      ..isDoNotDisturb = isDoNotDisturb ?? this.isDoNotDisturb
      ..isOnline = isOnline ?? this.isOnline
      ..gender = gender ?? this.gender
      ..birthday = birthday ?? this.birthday
      ..charge = charge ?? this.charge
      ..followed = followed ?? this.followed
      ..followCount = followCount ?? this.followCount
      ..praised = praised ?? this.praised
      ..praiseCount = praiseCount ?? this.praiseCount
      ..medias = medias ?? this.medias;
  }
}

MomentMedia $MomentMediaFromJson(Map<String, dynamic> json) {
  final MomentMedia momentMedia = MomentMedia();
  final String? mediaId = jsonConvert.convert<String>(json['mediaId']);
  if (mediaId != null) {
    momentMedia.mediaId = mediaId;
  }
  final String? mediaUrl = jsonConvert.convert<String>(json['mediaUrl']);
  if (mediaUrl != null) {
    momentMedia.mediaUrl = mediaUrl;
  }
  final String? screenshotUrl =
      jsonConvert.convert<String>(json['screenshotUrl']);
  if (screenshotUrl != null) {
    momentMedia.screenshotUrl = screenshotUrl;
  }
  final int? mediaType = jsonConvert.convert<int>(json['mediaType']);
  if (mediaType != null) {
    momentMedia.mediaType = mediaType;
  }
  return momentMedia;
}

Map<String, dynamic> $MomentMediaToJson(MomentMedia entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mediaId'] = entity.mediaId;
  data['mediaUrl'] = entity.mediaUrl;
  data['screenshotUrl'] = entity.screenshotUrl;
  data['mediaType'] = entity.mediaType;
  return data;
}

extension MomentMediaExtension on MomentMedia {
  MomentMedia copyWith({
    String? mediaId,
    String? mediaUrl,
    String? screenshotUrl,
    int? mediaType,
    String? localPath,
    int? uploadState,
  }) {
    return MomentMedia()
      ..mediaId = mediaId ?? this.mediaId
      ..mediaUrl = mediaUrl ?? this.mediaUrl
      ..screenshotUrl = screenshotUrl ?? this.screenshotUrl
      ..mediaType = mediaType ?? this.mediaType
      ..localPath = localPath ?? this.localPath
      ..uploadState = uploadState ?? this.uploadState;
  }
}
