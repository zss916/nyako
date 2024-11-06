import 'package:nyako/entities/app_balance_list_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

BalanceListEntity $BalanceListEntityFromJson(Map<String, dynamic> json) {
  final BalanceListEntity balanceListEntity = BalanceListEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    balanceListEntity.code = code;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    balanceListEntity.message = message;
  }
  final List<BalanceListData>? data = (json['data'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<BalanceListData>(e) as BalanceListData)
      .toList();
  if (data != null) {
    balanceListEntity.data = data;
  }
  final dynamic page = json['page'];
  if (page != null) {
    balanceListEntity.page = page;
  }
  return balanceListEntity;
}

Map<String, dynamic> $BalanceListEntityToJson(BalanceListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['page'] = entity.page;
  return data;
}

extension BalanceListEntityExtension on BalanceListEntity {
  BalanceListEntity copyWith({
    int? code,
    String? message,
    List<BalanceListData>? data,
    dynamic page,
  }) {
    return BalanceListEntity()
      ..code = code ?? this.code
      ..message = message ?? this.message
      ..data = data ?? this.data
      ..page = page ?? this.page;
  }
}

BalanceListData $BalanceListDataFromJson(Map<String, dynamic> json) {
  final BalanceListData balanceListData = BalanceListData();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    balanceListData.userId = userId;
  }
  final int? linkId = jsonConvert.convert<int>(json['linkId']);
  if (linkId != null) {
    balanceListData.linkId = linkId;
  }
  final int? afterChange = jsonConvert.convert<int>(json['afterChange']);
  if (afterChange != null) {
    balanceListData.afterChange = afterChange;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    balanceListData.id = id;
  }
  final int? beforeChange = jsonConvert.convert<int>(json['beforeChange']);
  if (beforeChange != null) {
    balanceListData.beforeChange = beforeChange;
  }
  final int? depletionType = jsonConvert.convert<int>(json['depletionType']);
  if (depletionType != null) {
    balanceListData.depletionType = depletionType;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    balanceListData.updatedAt = updatedAt;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    balanceListData.createdAt = createdAt;
  }
  final int? anchorId = jsonConvert.convert<int>(json['anchorId']);
  if (anchorId != null) {
    balanceListData.anchorId = anchorId;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    balanceListData.type = type;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    balanceListData.diamonds = diamonds;
  }
  final int? inviteeRepeat = jsonConvert.convert<int>(json['inviteeRepeat']);
  if (inviteeRepeat != null) {
    balanceListData.inviteeRepeat = inviteeRepeat;
  }
  final String? inviterNickname =
      jsonConvert.convert<String>(json['inviterNickname']);
  if (inviterNickname != null) {
    balanceListData.inviterNickname = inviterNickname;
  }
  return balanceListData;
}

Map<String, dynamic> $BalanceListDataToJson(BalanceListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['linkId'] = entity.linkId;
  data['afterChange'] = entity.afterChange;
  data['id'] = entity.id;
  data['beforeChange'] = entity.beforeChange;
  data['depletionType'] = entity.depletionType;
  data['updatedAt'] = entity.updatedAt;
  data['createdAt'] = entity.createdAt;
  data['anchorId'] = entity.anchorId;
  data['type'] = entity.type;
  data['diamonds'] = entity.diamonds;
  data['inviteeRepeat'] = entity.inviteeRepeat;
  data['inviterNickname'] = entity.inviterNickname;
  return data;
}

extension BalanceListDataExtension on BalanceListData {
  BalanceListData copyWith({
    int? userId,
    int? linkId,
    int? afterChange,
    int? id,
    int? beforeChange,
    int? depletionType,
    int? updatedAt,
    int? createdAt,
    int? anchorId,
    int? type,
    int? diamonds,
    int? inviteeRepeat,
    String? inviterNickname,
  }) {
    return BalanceListData()
      ..userId = userId ?? this.userId
      ..linkId = linkId ?? this.linkId
      ..afterChange = afterChange ?? this.afterChange
      ..id = id ?? this.id
      ..beforeChange = beforeChange ?? this.beforeChange
      ..depletionType = depletionType ?? this.depletionType
      ..updatedAt = updatedAt ?? this.updatedAt
      ..createdAt = createdAt ?? this.createdAt
      ..anchorId = anchorId ?? this.anchorId
      ..type = type ?? this.type
      ..diamonds = diamonds ?? this.diamonds
      ..inviteeRepeat = inviteeRepeat ?? this.inviteeRepeat
      ..inviterNickname = inviterNickname ?? this.inviterNickname;
  }
}
