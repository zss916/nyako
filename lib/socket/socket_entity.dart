import 'package:oliapro/generated/json/socket_entity.g.dart';

import '../generated/json/base/json_field.dart';

@JsonSerializable()
class SocketEntity {
  // {"data":"{\"isDoNotDisturb\":0,\"isOnline\":1,\"userId\":107780488}",
  // "optType":"anchorStatusChange","remark":"",
  // "timestamp":1649663757215,"userId":107781256}
  SocketEntity();

  factory SocketEntity.fromJson(Map<String, dynamic> json) =>
      $SocketEntityFromJson(json);

  Map<String, dynamic> toJson() => $SocketEntityToJson(this);

  // CblSocketContentEntity? data_Entity;
  String? data;
  int? timestamp;
  int? userId;
  String? optType;
  String? remark;
}

@JsonSerializable()
class SocketHostState {
  static const String typeCode = 'anchorStatusChange';

  SocketHostState();

  factory SocketHostState.fromJson(Map<String, dynamic> json) =>
      $SocketHostStateFromJson(json);

  Map<String, dynamic> toJson() => $SocketHostStateToJson(this);

  String userId = '';
  int isOnline = 0;
  int isDoNotDisturb = 0;
}

@JsonSerializable()
class SocketBalance {
  static const String typeCode = 'balanceChanged';

  SocketBalance();

  factory SocketBalance.fromJson(Map<String, dynamic> json) =>
      $SocketBalanceFromJson(json);

  Map<String, dynamic> toJson() => $SocketBalanceToJson(this);

  String userId = '';
  int depletionType = 0;
  int diamonds = 0;
  int expLevel = 0;
  int? callDuration;

  @override
  String toString() {
    return 'SocketBalance{userId: $userId, depletionType: $depletionType, diamonds: $diamonds, expLevel: $expLevel, callDuration: $callDuration}';
  }
}
