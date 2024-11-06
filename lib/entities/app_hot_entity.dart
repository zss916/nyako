import 'package:nyako/entities/app_host_entity.dart';

import '../generated/json/app_hot_entity.g.dart';
import '../generated/json/base/json_field.dart';

/// 发现了一个问题这里导包了YuliaHostDetail
/// 如果写成 import 'app_host_entity.dart';生成的.g.dart文件也这样导包产生错误
/// 改用 import 'package:nyako/entities/app_host_entity.dart';
/// 才没有问题，说明这个插件需要全路径
@JsonSerializable()
class UpListData {
  UpListData();

  factory UpListData.fromJson(Map<String, dynamic> json) =>
      $UpListDataFromJson(json);

  Map<String, dynamic> toJson() => $UpListDataToJson(this);

  List<HostDetail>? anchorLists;
  List<AreaData>? areaList;
  int? curAreaCode;

  List<AreaData> getArea() {
    List<AreaData> start =
        (areaList ?? []).where((element) => (element.canChoose == 1)).toList();
    List<AreaData> first =
        start.where((element) => element.areaCode == curAreaCode).toList();
    List<AreaData> other =
        start.where((element) => element.areaCode != curAreaCode).toList();
    List<AreaData> end =
        (areaList ?? []).where((element) => element.canChoose != 1).toList();
    first
      ..addAll(other)
      ..addAll(end);
    return first;
  }
}

@JsonSerializable()
class AreaData {
  AreaData();

  factory AreaData.fromJson(Map<String, dynamic> json) =>
      $AreaDataFromJson(json);

  Map<String, dynamic> toJson() => $AreaDataToJson(this);
  int? canChoose; // 1可以选择换区
  int? areaCode;
  String? title;
  String? path;
  int? countryCode;
  String? currency;

  bool? selected;
  bool? isSelect; //本地

  bool get showCanChoose => canChoose == 1;
}
