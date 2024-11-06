import 'dart:math';

import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/database/entity/app_login_entity.dart';
import 'package:nyako/entities/app_login_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/init/login/interface/login_interface.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/utils/cache/login_cache.dart';
import 'package:nyako/utils/mylib/app_other_plugin_manage.dart';

mixin class OtherLoginUtils implements LoginInterface {
  bool loginIng = false;

  // 用来获取随机头像 ，后端会拼上域名
  List<String> heads = [
    "users/awss3/manage/upload/default1.png",
    "users/awss3/manage/upload/default2.png",
    "users/awss3/manage/upload/default3.png",
    "users/awss3/manage/upload/default4.png",
    "users/awss3/manage/upload/default5.png",
  ];

  // 用来获取随机名字
  static String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  late final Random rnd = Random();

  String generatePassword(int length) {
    var rand = Random();
    const chars = "abcdefghjklmnoprstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ2345678";
    String password = "";
    for (int i = 0; i < length; i++) {
      int index = rand.nextInt(chars.length);
      password += chars[index];
    }
    return password;
  }

  String getRandomString(int length) {
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  /// 绑定google账号
  void bindGoogle() {
    String nickName = String.fromCharCodes(Iterable.generate(
        5, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
    String coverHead = heads[Random().nextInt(5)];
    AppOtherPluginManage.googleLogin((
        {cover, id, nickname, required success, token}) {
      if (success) {
        Http.instance.post<Login>(NetPath.bindGoogleApi,
            data: {
              "id": id ?? "",
              "cover": cover ?? coverHead,
              "nickname": nickname ?? nickName,
            },
            errCallback: (err) {
              AppLoading.toast(err.toString());
            },
            showLoading: true,
            doneCallback: (_, msg) {
              AppLoading.toast(Tr.app_base_success.tr);
              StorageService.to.eventBus.fire(eventBusRefreshMe);
            });
      }
    });
  }

  @override
  void googleLogin(GoogleCallBack callBack) {
    if (loginIng) {
      return;
    }
    loginIng = true;
    AppOtherPluginManage.googleLogin((
        {required success, cover, id, nickname, token}) async {
      if (success) {
        checkGoogleAccount(
            id: id,
            onCheck: () {
              callBack.call(
                  success: true,
                  cover: cover,
                  id: id,
                  nickname: nickname,
                  token: token);
            });
      }
      loginIng = false;
    });
  }

  @override
  void appleLogin() {}

  @override
  void facebookLogin(FbCallBack callBack) {}

  ///判断是否绑定，已经绑定next,没就先绑定再next
  Future<void> checkGoogleAccount({String? id, Function? onCheck}) async {
    AppLoginEntity? lastLogin = LoginCache.getLastLogin();
    if (id != null) {
      bool isBinding = await AccountAPI.checkBindGoogleAccount(googleId: id);
      if (isBinding) {
        onCheck?.call();
      } else {
        var loginType = 3;
        if (lastLogin == null) {
          loginType = 3;
        } else if (lastLogin.isGoogle == true) {
          loginType = 3;
        } else {
          loginType = 2;
        }
        // debugPrint("===>>>isBinding3:loginType:$loginType,googleId:$id,uid:${lastLogin?.userId}");
        AccountAPI.checkCacheAccount(
          loginType: loginType,
          googleId: id,
          uid: lastLogin?.userId ?? "",
        ).whenComplete(() {
          onCheck?.call();
        });
      }
    }
  }
}
