import 'package:oliapro/generated/json/base/json_convert_content.dart';
import 'package:oliapro/socket/socket_entity.dart';

SocketEntity $SocketEntityFromJson(Map<String, dynamic> json) {
  final SocketEntity socketEntity = SocketEntity();
  final String? data = jsonConvert.convert<String>(json['data']);
  if (data != null) {
    socketEntity.data = data;
  }
  final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
  if (timestamp != null) {
    socketEntity.timestamp = timestamp;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    socketEntity.userId = userId;
  }
  final String? optType = jsonConvert.convert<String>(json['optType']);
  if (optType != null) {
    socketEntity.optType = optType;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    socketEntity.remark = remark;
  }
  return socketEntity;
}

Map<String, dynamic> $SocketEntityToJson(SocketEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data;
  data['timestamp'] = entity.timestamp;
  data['userId'] = entity.userId;
  data['optType'] = entity.optType;
  data['remark'] = entity.remark;
  return data;
}

extension SocketEntityExtension on SocketEntity {
  SocketEntity copyWith({
    String? data,
    int? timestamp,
    int? userId,
    String? optType,
    String? remark,
  }) {
    return SocketEntity()
      ..data = data ?? this.data
      ..timestamp = timestamp ?? this.timestamp
      ..userId = userId ?? this.userId
      ..optType = optType ?? this.optType
      ..remark = remark ?? this.remark;
  }
}

SocketHostState $SocketHostStateFromJson(Map<String, dynamic> json) {
  final SocketHostState socketHostState = SocketHostState();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    socketHostState.userId = userId;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    socketHostState.isOnline = isOnline;
  }
  final int? isDoNotDisturb = jsonConvert.convert<int>(json['isDoNotDisturb']);
  if (isDoNotDisturb != null) {
    socketHostState.isDoNotDisturb = isDoNotDisturb;
  }
  return socketHostState;
}

Map<String, dynamic> $SocketHostStateToJson(SocketHostState entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['isOnline'] = entity.isOnline;
  data['isDoNotDisturb'] = entity.isDoNotDisturb;
  return data;
}

extension SocketHostStateExtension on SocketHostState {
  SocketHostState copyWith({
    String? userId,
    int? isOnline,
    int? isDoNotDisturb,
  }) {
    return SocketHostState()
      ..userId = userId ?? this.userId
      ..isOnline = isOnline ?? this.isOnline
      ..isDoNotDisturb = isDoNotDisturb ?? this.isDoNotDisturb;
  }
}

SocketBalance $SocketBalanceFromJson(Map<String, dynamic> json) {
  final SocketBalance socketBalance = SocketBalance();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    socketBalance.userId = userId;
  }
  final int? depletionType = jsonConvert.convert<int>(json['depletionType']);
  if (depletionType != null) {
    socketBalance.depletionType = depletionType;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    socketBalance.diamonds = diamonds;
  }
  final int? expLevel = jsonConvert.convert<int>(json['expLevel']);
  if (expLevel != null) {
    socketBalance.expLevel = expLevel;
  }
  final int? callDuration = jsonConvert.convert<int>(json['callDuration']);
  if (callDuration != null) {
    socketBalance.callDuration = callDuration;
  }
  return socketBalance;
}

Map<String, dynamic> $SocketBalanceToJson(SocketBalance entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['depletionType'] = entity.depletionType;
  data['diamonds'] = entity.diamonds;
  data['expLevel'] = entity.expLevel;
  data['callDuration'] = entity.callDuration;
  return data;
}

extension SocketBalanceExtension on SocketBalance {
  SocketBalance copyWith({
    String? userId,
    int? depletionType,
    int? diamonds,
    int? expLevel,
    int? callDuration,
  }) {
    return SocketBalance()
      ..userId = userId ?? this.userId
      ..depletionType = depletionType ?? this.depletionType
      ..diamonds = diamonds ?? this.diamonds
      ..expLevel = expLevel ?? this.expLevel
      ..callDuration = callDuration ?? this.callDuration;
  }
}
