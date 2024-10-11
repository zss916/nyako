import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

HostDetail $HostDetailFromJson(Map<String, dynamic> json) {
  final HostDetail hostDetail = HostDetail();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    hostDetail.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    hostDetail.username = username;
  }
  final int? auth = jsonConvert.convert<int>(json['auth']);
  if (auth != null) {
    hostDetail.auth = auth;
  }
  final String? intro = jsonConvert.convert<String>(json['intro']);
  if (intro != null) {
    hostDetail.intro = intro;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    hostDetail.portrait = portrait;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    hostDetail.nickname = nickname;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    hostDetail.areaCode = areaCode;
  }
  final int? isDoNotDisturb = jsonConvert.convert<int>(json['isDoNotDisturb']);
  if (isDoNotDisturb != null) {
    hostDetail.isDoNotDisturb = isDoNotDisturb;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    hostDetail.createdAt = createdAt;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    hostDetail.isOnline = isOnline;
  }
  final int? customOnline = jsonConvert.convert<int>(json['customOnline']);
  if (customOnline != null) {
    hostDetail.customOnline = customOnline;
  }
  final String? customVideoId =
      jsonConvert.convert<String>(json['customVideoId']);
  if (customVideoId != null) {
    hostDetail.customVideoId = customVideoId;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    hostDetail.gender = gender;
  }
  final int? country = jsonConvert.convert<int>(json['country']);
  if (country != null) {
    hostDetail.country = country;
  }
  final int? charge = jsonConvert.convert<int>(json['charge']);
  if (charge != null) {
    hostDetail.charge = charge;
  }
  final int? followed = jsonConvert.convert<int>(json['followed']);
  if (followed != null) {
    hostDetail.followed = followed;
  }
  final int? followCount = jsonConvert.convert<int>(json['followCount']);
  if (followCount != null) {
    hostDetail.followCount = followCount;
  }
  final int? connectRate = jsonConvert.convert<int>(json['connectRate']);
  if (connectRate != null) {
    hostDetail.connectRate = connectRate;
  }
  final String? video = jsonConvert.convert<String>(json['video']);
  if (video != null) {
    hostDetail.video = video;
  }
  final int? birthday = jsonConvert.convert<int>(json['birthday']);
  if (birthday != null) {
    hostDetail.birthday = birthday;
  }
  final int? expLevel = jsonConvert.convert<int>(json['expLevel']);
  if (expLevel != null) {
    hostDetail.expLevel = expLevel;
  }
  final int? heatValue = jsonConvert.convert<int>(json['heatValue']);
  if (heatValue != null) {
    hostDetail.heatValue = heatValue;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    hostDetail.updatedAt = updatedAt;
  }
  final List<HostMedia>? medias = (json['medias'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<HostMedia>(e) as HostMedia)
      .toList();
  if (medias != null) {
    hostDetail.medias = medias;
  }
  final List<HostMedia>? videos = (json['videos'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<HostMedia>(e) as HostMedia)
      .toList();
  if (videos != null) {
    hostDetail.videos = videos;
  }
  final AreaData? area = jsonConvert.convert<AreaData>(json['area']);
  if (area != null) {
    hostDetail.area = area;
  }
  final List<HostTag>? tags = (json['tags'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<HostTag>(e) as HostTag)
      .toList();
  if (tags != null) {
    hostDetail.tags = tags;
  }
  final bool? isCurrentVideo =
      jsonConvert.convert<bool>(json['isCurrentVideo']);
  if (isCurrentVideo != null) {
    hostDetail.isCurrentVideo = isCurrentVideo;
  }
  return hostDetail;
}

Map<String, dynamic> $HostDetailToJson(HostDetail entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['auth'] = entity.auth;
  data['intro'] = entity.intro;
  data['portrait'] = entity.portrait;
  data['nickname'] = entity.nickname;
  data['areaCode'] = entity.areaCode;
  data['isDoNotDisturb'] = entity.isDoNotDisturb;
  data['createdAt'] = entity.createdAt;
  data['isOnline'] = entity.isOnline;
  data['customOnline'] = entity.customOnline;
  data['customVideoId'] = entity.customVideoId;
  data['gender'] = entity.gender;
  data['country'] = entity.country;
  data['charge'] = entity.charge;
  data['followed'] = entity.followed;
  data['followCount'] = entity.followCount;
  data['connectRate'] = entity.connectRate;
  data['video'] = entity.video;
  data['birthday'] = entity.birthday;
  data['expLevel'] = entity.expLevel;
  data['heatValue'] = entity.heatValue;
  data['updatedAt'] = entity.updatedAt;
  data['medias'] = entity.medias?.map((v) => v.toJson()).toList();
  data['videos'] = entity.videos?.map((v) => v.toJson()).toList();
  data['area'] = entity.area?.toJson();
  data['tags'] = entity.tags?.map((v) => v.toJson()).toList();
  data['isCurrentVideo'] = entity.isCurrentVideo;
  return data;
}

extension HostDetailExtension on HostDetail {
  HostDetail copyWith({
    String? userId,
    String? username,
    int? auth,
    String? intro,
    String? portrait,
    String? nickname,
    int? areaCode,
    int? isDoNotDisturb,
    int? createdAt,
    int? isOnline,
    int? customOnline,
    String? customVideoId,
    int? gender,
    int? country,
    int? charge,
    int? followed,
    int? followCount,
    int? connectRate,
    String? video,
    int? birthday,
    int? expLevel,
    int? heatValue,
    int? updatedAt,
    List<HostMedia>? medias,
    List<HostMedia>? videos,
    AreaData? area,
    List<HostTag>? tags,
    bool? isCurrentVideo,
  }) {
    return HostDetail()
      ..userId = userId ?? this.userId
      ..username = username ?? this.username
      ..auth = auth ?? this.auth
      ..intro = intro ?? this.intro
      ..portrait = portrait ?? this.portrait
      ..nickname = nickname ?? this.nickname
      ..areaCode = areaCode ?? this.areaCode
      ..isDoNotDisturb = isDoNotDisturb ?? this.isDoNotDisturb
      ..createdAt = createdAt ?? this.createdAt
      ..isOnline = isOnline ?? this.isOnline
      ..customOnline = customOnline ?? this.customOnline
      ..customVideoId = customVideoId ?? this.customVideoId
      ..gender = gender ?? this.gender
      ..country = country ?? this.country
      ..charge = charge ?? this.charge
      ..followed = followed ?? this.followed
      ..followCount = followCount ?? this.followCount
      ..connectRate = connectRate ?? this.connectRate
      ..video = video ?? this.video
      ..birthday = birthday ?? this.birthday
      ..expLevel = expLevel ?? this.expLevel
      ..heatValue = heatValue ?? this.heatValue
      ..updatedAt = updatedAt ?? this.updatedAt
      ..medias = medias ?? this.medias
      ..videos = videos ?? this.videos
      ..area = area ?? this.area
      ..tags = tags ?? this.tags
      ..isCurrentVideo = isCurrentVideo ?? this.isCurrentVideo;
  }
}

HostMedia $HostMediaFromJson(Map<String, dynamic> json) {
  final HostMedia hostMedia = HostMedia();
  final int? mid = jsonConvert.convert<int>(json['mid']);
  if (mid != null) {
    hostMedia.mid = mid;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    hostMedia.userId = userId;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    hostMedia.path = path;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    hostMedia.type = type;
  }
  final int? selected = jsonConvert.convert<int>(json['selected']);
  if (selected != null) {
    hostMedia.selected = selected;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    hostMedia.cover = cover;
  }
  final int? locked = jsonConvert.convert<int>(json['locked']);
  if (locked != null) {
    hostMedia.locked = locked;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    hostMedia.diamonds = diamonds;
  }
  final int? likeCount = jsonConvert.convert<int>(json['likeCount']);
  if (likeCount != null) {
    hostMedia.likeCount = likeCount;
  }
  final int? unlockCount = jsonConvert.convert<int>(json['unlockCount']);
  if (unlockCount != null) {
    hostMedia.unlockCount = unlockCount;
  }
  final int? playCount = jsonConvert.convert<int>(json['playCount']);
  if (playCount != null) {
    hostMedia.playCount = playCount;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    hostMedia.status = status;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    hostMedia.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    hostMedia.updatedAt = updatedAt;
  }
  final dynamic isPay = json['isPay'];
  if (isPay != null) {
    hostMedia.isPay = isPay;
  }
  final int? vipVisible = jsonConvert.convert<int>(json['vipVisible']);
  if (vipVisible != null) {
    hostMedia.vipVisible = vipVisible;
  }
  final bool? isSelected = jsonConvert.convert<bool>(json['isSelected']);
  if (isSelected != null) {
    hostMedia.isSelected = isSelected;
  }
  return hostMedia;
}

Map<String, dynamic> $HostMediaToJson(HostMedia entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['mid'] = entity.mid;
  data['userId'] = entity.userId;
  data['path'] = entity.path;
  data['type'] = entity.type;
  data['selected'] = entity.selected;
  data['cover'] = entity.cover;
  data['locked'] = entity.locked;
  data['diamonds'] = entity.diamonds;
  data['likeCount'] = entity.likeCount;
  data['unlockCount'] = entity.unlockCount;
  data['playCount'] = entity.playCount;
  data['status'] = entity.status;
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['isPay'] = entity.isPay;
  data['vipVisible'] = entity.vipVisible;
  data['isSelected'] = entity.isSelected;
  return data;
}

extension HostMediaExtension on HostMedia {
  HostMedia copyWith({
    int? mid,
    int? userId,
    String? path,
    int? type,
    int? selected,
    String? cover,
    int? locked,
    int? diamonds,
    int? likeCount,
    int? unlockCount,
    int? playCount,
    int? status,
    int? createdAt,
    int? updatedAt,
    dynamic isPay,
    int? vipVisible,
    bool? isSelected,
  }) {
    return HostMedia()
      ..mid = mid ?? this.mid
      ..userId = userId ?? this.userId
      ..path = path ?? this.path
      ..type = type ?? this.type
      ..selected = selected ?? this.selected
      ..cover = cover ?? this.cover
      ..locked = locked ?? this.locked
      ..diamonds = diamonds ?? this.diamonds
      ..likeCount = likeCount ?? this.likeCount
      ..unlockCount = unlockCount ?? this.unlockCount
      ..playCount = playCount ?? this.playCount
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..isPay = isPay ?? this.isPay
      ..vipVisible = vipVisible ?? this.vipVisible
      ..isSelected = isSelected ?? this.isSelected;
  }
}

HostTag $HostTagFromJson(Map<String, dynamic> json) {
  final HostTag hostTag = HostTag();
  final String? tagValue = jsonConvert.convert<String>(json['tagValue']);
  if (tagValue != null) {
    hostTag.tagValue = tagValue;
  }
  return hostTag;
}

Map<String, dynamic> $HostTagToJson(HostTag entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tagValue'] = entity.tagValue;
  return data;
}

extension HostTagExtension on HostTag {
  HostTag copyWith({
    String? tagValue,
  }) {
    return HostTag()..tagValue = tagValue ?? this.tagValue;
  }
}
