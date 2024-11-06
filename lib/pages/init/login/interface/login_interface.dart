import 'package:nyako/utils/mylib/app_other_plugin_manage.dart';

abstract class LoginInterface {
  ///Google登录
  void googleLogin(GoogleCallBack callBack);

  ///fb登录
  void facebookLogin(FbCallBack callBack);

  ///apple登录
  void appleLogin();
}
