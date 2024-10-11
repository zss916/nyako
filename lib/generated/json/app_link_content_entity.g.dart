import 'package:oliapro/entities/app_link_content_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

LinkContent $LinkContentFromJson(Map<String, dynamic> json) {
  final LinkContent linkContent = LinkContent();
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    linkContent.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    linkContent.updatedAt = updatedAt;
  }
  final String? rid = jsonConvert.convert<String>(json['rid']);
  if (rid != null) {
    linkContent.rid = rid;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    linkContent.userId = userId;
  }
  final int? classifyId = jsonConvert.convert<int>(json['classifyId']);
  if (classifyId != null) {
    linkContent.classifyId = classifyId;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    linkContent.status = status;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    linkContent.title = title;
  }
  final String? tag = jsonConvert.convert<String>(json['tag']);
  if (tag != null) {
    linkContent.tag = tag;
  }
  final int? favoritesCount = jsonConvert.convert<int>(json['favoritesCount']);
  if (favoritesCount != null) {
    linkContent.favoritesCount = favoritesCount;
  }
  final int? likesCount = jsonConvert.convert<int>(json['likesCount']);
  if (likesCount != null) {
    linkContent.likesCount = likesCount;
  }
  final String? paths = jsonConvert.convert<String>(json['paths']);
  if (paths != null) {
    linkContent.paths = paths;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    linkContent.content = content;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    linkContent.nickname = nickname;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    linkContent.gender = gender;
  }
  final String? intro = jsonConvert.convert<String>(json['intro']);
  if (intro != null) {
    linkContent.intro = intro;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    linkContent.portrait = portrait;
  }
  final int? fansCount = jsonConvert.convert<int>(json['fansCount']);
  if (fansCount != null) {
    linkContent.fansCount = fansCount;
  }
  final int? followCount = jsonConvert.convert<int>(json['followCount']);
  if (followCount != null) {
    linkContent.followCount = followCount;
  }
  final int? collectCount = jsonConvert.convert<int>(json['collectCount']);
  if (collectCount != null) {
    linkContent.collectCount = collectCount;
  }
  final int? isCollect = jsonConvert.convert<int>(json['isCollect']);
  if (isCollect != null) {
    linkContent.isCollect = isCollect;
  }
  final int? isLike = jsonConvert.convert<int>(json['isLike']);
  if (isLike != null) {
    linkContent.isLike = isLike;
  }
  final List<String>? pathArray = (json['pathArray'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (pathArray != null) {
    linkContent.pathArray = pathArray;
  }
  return linkContent;
}

Map<String, dynamic> $LinkContentToJson(LinkContent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['rid'] = entity.rid;
  data['userId'] = entity.userId;
  data['classifyId'] = entity.classifyId;
  data['status'] = entity.status;
  data['title'] = entity.title;
  data['tag'] = entity.tag;
  data['favoritesCount'] = entity.favoritesCount;
  data['likesCount'] = entity.likesCount;
  data['paths'] = entity.paths;
  data['content'] = entity.content;
  data['nickname'] = entity.nickname;
  data['gender'] = entity.gender;
  data['intro'] = entity.intro;
  data['portrait'] = entity.portrait;
  data['fansCount'] = entity.fansCount;
  data['followCount'] = entity.followCount;
  data['collectCount'] = entity.collectCount;
  data['isCollect'] = entity.isCollect;
  data['isLike'] = entity.isLike;
  data['pathArray'] = entity.pathArray;
  return data;
}

extension LinkContentExtension on LinkContent {
  LinkContent copyWith({
    int? createdAt,
    int? updatedAt,
    String? rid,
    String? userId,
    int? classifyId,
    int? status,
    String? title,
    String? tag,
    int? favoritesCount,
    int? likesCount,
    String? paths,
    String? content,
    String? nickname,
    int? gender,
    String? intro,
    String? portrait,
    int? fansCount,
    int? followCount,
    int? collectCount,
    int? isCollect,
    int? isLike,
    List<String>? pathArray,
  }) {
    return LinkContent()
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..rid = rid ?? this.rid
      ..userId = userId ?? this.userId
      ..classifyId = classifyId ?? this.classifyId
      ..status = status ?? this.status
      ..title = title ?? this.title
      ..tag = tag ?? this.tag
      ..favoritesCount = favoritesCount ?? this.favoritesCount
      ..likesCount = likesCount ?? this.likesCount
      ..paths = paths ?? this.paths
      ..content = content ?? this.content
      ..nickname = nickname ?? this.nickname
      ..gender = gender ?? this.gender
      ..intro = intro ?? this.intro
      ..portrait = portrait ?? this.portrait
      ..fansCount = fansCount ?? this.fansCount
      ..followCount = followCount ?? this.followCount
      ..collectCount = collectCount ?? this.collectCount
      ..isCollect = isCollect ?? this.isCollect
      ..isLike = isLike ?? this.isLike
      ..pathArray = pathArray ?? this.pathArray;
  }
}
