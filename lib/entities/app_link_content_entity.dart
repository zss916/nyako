import 'package:nyako/generated/json/base/json_field.dart';
import 'package:nyako/utils/app_extends.dart';

import '../generated/json/app_link_content_entity.g.dart';

@JsonSerializable()
class LinkContent {
  LinkContent();

  factory LinkContent.fromJson(Map<String, dynamic> json) =>
      $LinkContentFromJson(json);

  Map<String, dynamic> toJson() => $LinkContentToJson(this);
  //  "createdAt":1665457419925,
  //  "updatedAt":1665457419925,
  //  "rid":1579669028683915265,
  //  "userId":107805636,
  //  "classifyId":0,
  //  "status":0,
  //  "title":"",
  //  "tag":"",
  //  "favoritesCount":0,
  //  "likesCount":0,
  //  "paths":"https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/test/awss3/107805636/upload/6accf0e4756b0a6023a0739067d1c02c.jpg",
  //  "content":"fddfghkkl",
  //  "nickname":"hdhdh",
  //  "gender":1,
  //  "intro":"滴哦pls匿名了哦or匿名ing哦哦or明明哦OMG你弟弟心狠哦破给你您给我你定名额你摸",
  //  "portrait":"https://oss.hanilink.com/images/default1.png",
  //  "fansCount":null,
  //  "followCount":null,
  //  "collectCount":null,
  //  "isCollect":0,
  //  "isLike":0,
  //  "pathArray":[
  //      "https://s3-hanilink-com.s3.ap-southeast-1.amazonaws.com/users/test/awss3/107805636/upload/6accf0e4756b0a6023a0739067d1c02c.jpg"
  //  ]
  int? createdAt;
  int? updatedAt;
  String? rid;
  String? userId;
  int? classifyId;
  int? status;
  String? title;
  String? tag;
  int? favoritesCount;
  int? likesCount;
  String? paths;
  String? content;
  String? nickname;
  int? gender;
  String? intro;
  String? portrait;
  int? fansCount;
  int? followCount;
  int? collectCount;
  int? isCollect;
  int? isLike;
  List<String>? pathArray;

  String get showPortrait => portrait ?? "";

  String get dynamicStartTime => dateFormat(createdAt ?? 0, formatStr: 'MM/dd');

  String get dynamicTime => dateFormat(createdAt ?? 0, formatStr: 'yyyy/MM/dd');

  List<String> get showArray =>
      (pathArray ?? [])..removeWhere((element) => element == "null");
}
