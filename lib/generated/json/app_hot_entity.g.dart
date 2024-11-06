import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

UpListData $UpListDataFromJson(Map<String, dynamic> json) {
  final UpListData upListData = UpListData();
  final List<HostDetail>? anchorLists = (json['anchorLists'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<HostDetail>(e) as HostDetail)
      .toList();
  if (anchorLists != null) {
    upListData.anchorLists = anchorLists;
  }
  final List<AreaData>? areaList = (json['areaList'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<AreaData>(e) as AreaData)
      .toList();
  if (areaList != null) {
    upListData.areaList = areaList;
  }
  final int? curAreaCode = jsonConvert.convert<int>(json['curAreaCode']);
  if (curAreaCode != null) {
    upListData.curAreaCode = curAreaCode;
  }
  return upListData;
}

Map<String, dynamic> $UpListDataToJson(UpListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['anchorLists'] = entity.anchorLists?.map((v) => v.toJson()).toList();
  data['areaList'] = entity.areaList?.map((v) => v.toJson()).toList();
  data['curAreaCode'] = entity.curAreaCode;
  return data;
}

extension UpListDataExtension on UpListData {
  UpListData copyWith({
    List<HostDetail>? anchorLists,
    List<AreaData>? areaList,
    int? curAreaCode,
  }) {
    return UpListData()
      ..anchorLists = anchorLists ?? this.anchorLists
      ..areaList = areaList ?? this.areaList
      ..curAreaCode = curAreaCode ?? this.curAreaCode;
  }
}

AreaData $AreaDataFromJson(Map<String, dynamic> json) {
  final AreaData areaData = AreaData();
  final int? canChoose = jsonConvert.convert<int>(json['canChoose']);
  if (canChoose != null) {
    areaData.canChoose = canChoose;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    areaData.areaCode = areaCode;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    areaData.title = title;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    areaData.path = path;
  }
  final int? countryCode = jsonConvert.convert<int>(json['countryCode']);
  if (countryCode != null) {
    areaData.countryCode = countryCode;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    areaData.currency = currency;
  }
  final bool? selected = jsonConvert.convert<bool>(json['selected']);
  if (selected != null) {
    areaData.selected = selected;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    areaData.isSelect = isSelect;
  }
  return areaData;
}

Map<String, dynamic> $AreaDataToJson(AreaData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['canChoose'] = entity.canChoose;
  data['areaCode'] = entity.areaCode;
  data['title'] = entity.title;
  data['path'] = entity.path;
  data['countryCode'] = entity.countryCode;
  data['currency'] = entity.currency;
  data['selected'] = entity.selected;
  data['isSelect'] = entity.isSelect;
  return data;
}

extension AreaDataExtension on AreaData {
  AreaData copyWith({
    int? canChoose,
    int? areaCode,
    String? title,
    String? path,
    int? countryCode,
    String? currency,
    bool? selected,
    bool? isSelect,
  }) {
    return AreaData()
      ..canChoose = canChoose ?? this.canChoose
      ..areaCode = areaCode ?? this.areaCode
      ..title = title ?? this.title
      ..path = path ?? this.path
      ..countryCode = countryCode ?? this.countryCode
      ..currency = currency ?? this.currency
      ..selected = selected ?? this.selected
      ..isSelect = isSelect ?? this.isSelect;
  }
}
