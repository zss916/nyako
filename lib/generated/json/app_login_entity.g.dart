import 'package:nyako/entities/app_login_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

Login $LoginFromJson(Map<String, dynamic> json) {
  final Login login = Login();
  final LoginToken? token = jsonConvert.convert<LoginToken>(json['token']);
  if (token != null) {
    login.token = token;
  }
  final String? enterTheSystem =
      jsonConvert.convert<String>(json['enterTheSystem']);
  if (enterTheSystem != null) {
    login.enterTheSystem = enterTheSystem;
  }
  final LoginUser? user = jsonConvert.convert<LoginUser>(json['user']);
  if (user != null) {
    login.user = user;
  }
  return login;
}

Map<String, dynamic> $LoginToJson(Login entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token?.toJson();
  data['enterTheSystem'] = entity.enterTheSystem;
  data['user'] = entity.user?.toJson();
  return data;
}

extension LoginExtension on Login {
  Login copyWith({
    LoginToken? token,
    String? enterTheSystem,
    LoginUser? user,
  }) {
    return Login()
      ..token = token ?? this.token
      ..enterTheSystem = enterTheSystem ?? this.enterTheSystem
      ..user = user ?? this.user;
  }
}

LoginToken $LoginTokenFromJson(Map<String, dynamic> json) {
  final LoginToken loginToken = LoginToken();
  final int? expire = jsonConvert.convert<int>(json['expire']);
  if (expire != null) {
    loginToken.expire = expire;
  }
  final String? agoraToken = jsonConvert.convert<String>(json['agoraToken']);
  if (agoraToken != null) {
    loginToken.agoraToken = agoraToken;
  }
  final String? authorization =
      jsonConvert.convert<String>(json['authorization']);
  if (authorization != null) {
    loginToken.authorization = authorization;
  }
  final String? rtmToken = jsonConvert.convert<String>(json['rtmToken']);
  if (rtmToken != null) {
    loginToken.rtmToken = rtmToken;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    loginToken.userId = userId;
  }
  final String? jpushAlias = jsonConvert.convert<String>(json['jpushAlias']);
  if (jpushAlias != null) {
    loginToken.jpushAlias = jpushAlias;
  }
  return loginToken;
}

Map<String, dynamic> $LoginTokenToJson(LoginToken entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['expire'] = entity.expire;
  data['agoraToken'] = entity.agoraToken;
  data['authorization'] = entity.authorization;
  data['rtmToken'] = entity.rtmToken;
  data['userId'] = entity.userId;
  data['jpushAlias'] = entity.jpushAlias;
  return data;
}

extension LoginTokenExtension on LoginToken {
  LoginToken copyWith({
    int? expire,
    String? agoraToken,
    String? authorization,
    String? rtmToken,
    String? userId,
    String? jpushAlias,
  }) {
    return LoginToken()
      ..expire = expire ?? this.expire
      ..agoraToken = agoraToken ?? this.agoraToken
      ..authorization = authorization ?? this.authorization
      ..rtmToken = rtmToken ?? this.rtmToken
      ..userId = userId ?? this.userId
      ..jpushAlias = jpushAlias ?? this.jpushAlias;
  }
}

LoginUser $LoginUserFromJson(Map<String, dynamic> json) {
  final LoginUser loginUser = LoginUser();
  final bool? accountNonExpired =
      jsonConvert.convert<bool>(json['accountNonExpired']);
  if (accountNonExpired != null) {
    loginUser.accountNonExpired = accountNonExpired;
  }
  final bool? accountNonLocked =
      jsonConvert.convert<bool>(json['accountNonLocked']);
  if (accountNonLocked != null) {
    loginUser.accountNonLocked = accountNonLocked;
  }
  final List<dynamic>? authorities =
      (json['authorities'] as List<dynamic>?)?.map((e) => e).toList();
  if (authorities != null) {
    loginUser.authorities = authorities;
  }
  final int? auth = jsonConvert.convert<int>(json['auth']);
  if (auth != null) {
    loginUser.auth = auth;
  }
  final bool? credentialsNonExpired =
      jsonConvert.convert<bool>(json['credentialsNonExpired']);
  if (credentialsNonExpired != null) {
    loginUser.credentialsNonExpired = credentialsNonExpired;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    loginUser.userId = userId;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    loginUser.portrait = portrait;
  }
  final bool? enabled = jsonConvert.convert<bool>(json['enabled']);
  if (enabled != null) {
    loginUser.enabled = enabled;
  }
  final int? created = jsonConvert.convert<int>(json['created']);
  if (created != null) {
    loginUser.created = created;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    loginUser.username = username;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    loginUser.nickname = nickname;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    loginUser.gender = gender;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    loginUser.status = status;
  }
  final String? areaCode = jsonConvert.convert<String>(json['areaCode']);
  if (areaCode != null) {
    loginUser.areaCode = areaCode;
  }
  return loginUser;
}

Map<String, dynamic> $LoginUserToJson(LoginUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['accountNonExpired'] = entity.accountNonExpired;
  data['accountNonLocked'] = entity.accountNonLocked;
  data['authorities'] = entity.authorities;
  data['auth'] = entity.auth;
  data['credentialsNonExpired'] = entity.credentialsNonExpired;
  data['userId'] = entity.userId;
  data['portrait'] = entity.portrait;
  data['enabled'] = entity.enabled;
  data['created'] = entity.created;
  data['username'] = entity.username;
  data['nickname'] = entity.nickname;
  data['gender'] = entity.gender;
  data['status'] = entity.status;
  data['areaCode'] = entity.areaCode;
  return data;
}

extension LoginUserExtension on LoginUser {
  LoginUser copyWith({
    bool? accountNonExpired,
    bool? accountNonLocked,
    List<dynamic>? authorities,
    int? auth,
    bool? credentialsNonExpired,
    String? userId,
    String? portrait,
    bool? enabled,
    int? created,
    String? username,
    String? nickname,
    int? gender,
    String? status,
    String? areaCode,
  }) {
    return LoginUser()
      ..accountNonExpired = accountNonExpired ?? this.accountNonExpired
      ..accountNonLocked = accountNonLocked ?? this.accountNonLocked
      ..authorities = authorities ?? this.authorities
      ..auth = auth ?? this.auth
      ..credentialsNonExpired =
          credentialsNonExpired ?? this.credentialsNonExpired
      ..userId = userId ?? this.userId
      ..portrait = portrait ?? this.portrait
      ..enabled = enabled ?? this.enabled
      ..created = created ?? this.created
      ..username = username ?? this.username
      ..nickname = nickname ?? this.nickname
      ..gender = gender ?? this.gender
      ..status = status ?? this.status
      ..areaCode = areaCode ?? this.areaCode;
  }
}
