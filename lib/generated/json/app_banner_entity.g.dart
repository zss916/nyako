import 'package:nyako/entities/app_banner_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

BannerBean $BannerBeanFromJson(Map<String, dynamic> json) {
  final BannerBean bannerBean = BannerBean();
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    bannerBean.updatedAt = updatedAt;
  }
  final int? category = jsonConvert.convert<int>(json['category']);
  if (category != null) {
    bannerBean.category = category;
  }
  final int? bid = jsonConvert.convert<int>(json['bid']);
  if (bid != null) {
    bannerBean.bid = bid;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    bannerBean.link = link;
  }
  final int? ranking = jsonConvert.convert<int>(json['ranking']);
  if (ranking != null) {
    bannerBean.ranking = ranking;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    bannerBean.type = type;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    bannerBean.title = title;
  }
  final String? appName = jsonConvert.convert<String>(json['appName']);
  if (appName != null) {
    bannerBean.appName = appName;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    bannerBean.cover = cover;
  }
  final int? target = jsonConvert.convert<int>(json['target']);
  if (target != null) {
    bannerBean.target = target;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    bannerBean.createdAt = createdAt;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    bannerBean.areaCode = areaCode;
  }
  return bannerBean;
}

Map<String, dynamic> $BannerBeanToJson(BannerBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['updatedAt'] = entity.updatedAt;
  data['category'] = entity.category;
  data['bid'] = entity.bid;
  data['link'] = entity.link;
  data['ranking'] = entity.ranking;
  data['type'] = entity.type;
  data['title'] = entity.title;
  data['appName'] = entity.appName;
  data['cover'] = entity.cover;
  data['target'] = entity.target;
  data['createdAt'] = entity.createdAt;
  data['areaCode'] = entity.areaCode;
  return data;
}

extension BannerBeanExtension on BannerBean {
  BannerBean copyWith({
    int? updatedAt,
    int? category,
    int? bid,
    String? link,
    int? ranking,
    int? type,
    String? title,
    String? appName,
    String? cover,
    int? target,
    int? createdAt,
    int? areaCode,
  }) {
    return BannerBean()
      ..updatedAt = updatedAt ?? this.updatedAt
      ..category = category ?? this.category
      ..bid = bid ?? this.bid
      ..link = link ?? this.link
      ..ranking = ranking ?? this.ranking
      ..type = type ?? this.type
      ..title = title ?? this.title
      ..appName = appName ?? this.appName
      ..cover = cover ?? this.cover
      ..target = target ?? this.target
      ..createdAt = createdAt ?? this.createdAt
      ..areaCode = areaCode ?? this.areaCode;
  }
}
