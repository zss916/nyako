import '../generated/json/base/json_field.dart';
import '../generated/json/app_login_entity.g.dart';

@JsonSerializable()
class Login {
  Login();

  factory Login.fromJson(Map<String, dynamic> json) =>
      $LoginFromJson(json);

  Map<String, dynamic> toJson() => $LoginToJson(this);

  LoginToken? token;
  String? enterTheSystem;
  LoginUser? user;
}

@JsonSerializable()
class LoginToken {
  LoginToken();

  factory LoginToken.fromJson(Map<String, dynamic> json) =>
      $LoginTokenFromJson(json);

  Map<String, dynamic> toJson() => $LoginTokenToJson(this);

  int? expire;
  String? agoraToken;
  String? authorization;
  String? rtmToken;
  String? userId;
  String? jpushAlias;
}

@JsonSerializable()
class LoginUser {
  LoginUser();

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      $LoginUserFromJson(json);

  Map<String, dynamic> toJson() => $LoginUserToJson(this);

  bool? accountNonExpired;
  bool? accountNonLocked;
  List<dynamic>? authorities;
  int? auth;
  bool? credentialsNonExpired;
  String? userId;
  String? portrait;
  bool? enabled;
  int? created;
  String? username;
  String? nickname;
  int? gender;
  String? status;
  String? areaCode;
}
