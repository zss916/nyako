import 'package:objectbox/objectbox.dart';

@Entity()
class AppLoginEntity {
  int id;
  String? nickName;

  @Unique()
  String userId;
  String? userName;
  String? password;
  bool? isGoogle;
  bool? isGust;
  String? googleId;
  String? diamondCount;
  bool? lastLogin;
  String? profileUrl;
  String? token;
  String? email;
  int loginTime;

  AppLoginEntity({
    this.id = 0,
    required this.userId,
    required this.loginTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nickName'] = nickName;
    data['userId'] = userId;
    data['userName'] = userName;
    data['password'] = password;
    data['isGoogle'] = isGoogle;
    data['isGust'] = isGust;
    data['googleId'] = googleId;
    data['diamondCount'] = diamondCount;
    data['lastLogin'] = lastLogin;
    data['profileUrl'] = profileUrl;
    data['token'] = token;
    data['email'] = email;
    data['loginTime'] = loginTime;
    return data;
  }
}
