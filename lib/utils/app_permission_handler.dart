import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_permissions/notification_permissions.dart'
    hide PermissionStatus;
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common/language_key.dart';

/// 被叫页面初始化完成后，先调askCallPermission提示需要权限
/// 点击拨打按钮或者被叫页面的接听按钮，先调checkCallPermission检查权限
class AppPermissionHandler {
  /// 每次打开app时检查下这个通知权限
  static void checkNotificationPermission() {
    // 这个通知权限一般默认有
    Permission.notification.request().then((value) {
      // AppLog.debug(value);
      if (value != PermissionStatus.granted) {
        showPermissionNotify();
      }
    });
  }

  static Future<bool> checkAudioPermission(
      {Function? cancelPermission, bool hadTip = false}) async {
    Map status = await [Permission.microphone].request();
    var microphoneStatus = status[Permission.microphone];
    List<Permission> permissions = [];
    if (microphoneStatus == PermissionStatus.permanentlyDenied) {
      permissions.add(Permission.microphone);
    }
    // 有永久拒绝的，提示去设置页面
    if (permissions.isNotEmpty) {
      showPermissionSetting(permissions, cancelPermission);
      return false;
    }
    if (microphoneStatus != PermissionStatus.granted) {
      permissions.add(Permission.microphone);
    }
    // 有拒绝的，提示获取权限
    if (permissions.isNotEmpty && !hadTip) {
      showAskPermissionAlert(permissions, cancelPermission);
      return false;
    }
    return true;
  }

  /// 打开被叫页面时先调这个检查权限，
  static Future<bool> askCallPermission({Function? cancelPermission}) async {
    // Map status = await [Permission.camera, Permission.microphone].request();
    // 这里有个坑，永久拒绝时，
    // Permission.camera.status这样得到的是denied，
    // 而不是permanentlyDenied，
    // request()方法返回的结果才能知道是permanentlyDenied
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;
    List<Permission> permissions = [];
    if (cameraStatus != PermissionStatus.granted) {
      permissions.add(Permission.camera);
    }
    if (microphoneStatus != PermissionStatus.granted) {
      permissions.add(Permission.microphone);
    }
    if (permissions.isNotEmpty) {
      AppConstants.isBeCallPermission = true;
      showAskPermissionAlert(permissions, cancelPermission);
      return false;
    }
    return true;
  }

  /// 点击拨打按钮或者点击接听时先调这个，在.then((value){})的value为true时再真正拨打或接听
  static Future<bool> checkCallPermission(
      {Function? cancelPermission, bool hadTip = false}) async {
    Map status = await [Permission.camera, Permission.microphone].request();
    var cameraStatus = status[Permission.camera];
    var microphoneStatus = status[Permission.microphone];
    List<Permission> permissions = [];
    if (cameraStatus == PermissionStatus.permanentlyDenied) {
      permissions.add(Permission.camera);
    }
    if (microphoneStatus == PermissionStatus.permanentlyDenied) {
      permissions.add(Permission.microphone);
    }
    // 有永久拒绝的，提示去设置页面
    if (permissions.isNotEmpty) {
      showPermissionSetting(permissions, cancelPermission);
      return false;
    }

    if (cameraStatus != PermissionStatus.granted) {
      permissions.add(Permission.camera);
    }
    if (microphoneStatus != PermissionStatus.granted) {
      permissions.add(Permission.microphone);
    }
    // 有拒绝的，提示获取权限
    if (permissions.isNotEmpty && !hadTip) {
      showAskPermissionAlert(permissions, cancelPermission);
      return false;
    }
    return true;
  }

  // 提示需要权限
  static void showAskPermissionAlert(
    List<Permission> permissions,
    Function? cancelPermission,
  ) {
    if (permissions.isEmpty) {
      return;
    }

    String content = "";
    String camera = Tr.app_base_camera.tr;
    String mic = Tr.app_base_mic.tr;
    String store = Tr.app_base_store.tr;
    for (int i = 0; i < permissions.length; i++) {
      Permission permission = permissions[i];
      if (permission == Permission.camera) {
        content = (content.isNotEmpty) ? ("$content/") + camera : camera;
      } else if (permission == Permission.microphone) {
        content = (content.isNotEmpty) ? ("$content/") + mic : mic;
      } else if (permission == Permission.storage) {
        content = (content.isNotEmpty) ? ("$content/") + store : store;
      }
    }

    Get.defaultDialog(
      title: Tr.app_video_permission.tr,
      titleStyle: const TextStyle(fontSize: 16),
      middleText: Tr.app_open_permission.trArgs([content]),
      middleTextStyle: const TextStyle(fontSize: 14),
      contentPadding: const EdgeInsetsDirectional.only(
          start: 20, end: 20, top: 20, bottom: 20),
      radius: 12,
      cancel: TextButton(
          onPressed: () {
            Get.back();
            cancelPermission?.call();
          },
          child: Text(
            Tr.app_base_cancel.tr,
            style: const TextStyle(fontSize: 16),
          )),
      confirm: TextButton(
          onPressed: () {
            Get.back();
            checkCallPermission(hadTip: true);
          },
          child: Text(
            Tr.app_base_confirm.tr,
            style: const TextStyle(fontSize: 16, color: Colors.red),
          )),
    );
  }

  // 提示需要到设置页设置权限,
  static void showPermissionSetting(
      List<Permission> permissions, Function? cancelPermission) {
    if (permissions.isEmpty) {
      return;
    }

    String content = "";
    String camera = Tr.app_base_camera.tr;
    String mic = Tr.app_base_mic.tr;
    String store = Tr.app_base_store.tr;
    for (int i = 0; i < permissions.length; i++) {
      Permission permission = permissions[i];
      if (permission == Permission.camera) {
        content = (content.isNotEmpty) ? (content + "/") + camera : camera;
      } else if (permission == Permission.microphone) {
        content = (content.isNotEmpty) ? (content + "/") + mic : mic;
      } else if (permission == Permission.storage) {
        content = (content.isNotEmpty) ? (content + "/") + store : store;
      }
    }

    Get.defaultDialog(
        title: Tr.app_base_permissions_to_setting.tr,
        titleStyle: const TextStyle(fontSize: 16),
        middleText: Tr.app_open_permission.trArgs(["${content}"]),
        middleTextStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsetsDirectional.only(
            start: 20, end: 20, top: 20, bottom: 20),
        radius: 12,
        cancel: TextButton(
            onPressed: () {
              Get.back();
              cancelPermission?.call();
            },
            child: Text(
              Tr.app_base_cancel.tr,
              style: const TextStyle(fontSize: 16),
            )),
        confirm: TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: Text(
              Tr.app_mine_setting.tr,
              style: const TextStyle(fontSize: 16, color: Color(0xFFFF890E)),
            )));
  }

  // 提示去设置页打开通知权限
  static void showPermissionNotify() {
    Get.dialog(Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                padding: const EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(33),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            size: 25,
                            color: Color(0xFFFF3978),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            Tr.app_notifications_title.tr,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          RepaintBoundary(
                            child: Image.asset(
                              Assets.animaNotify,
                              matchTextDirection: true,
                              height: 22,
                              width: 38,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Text(
                        Tr.app_notifications_content.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      // padding: EdgeInsets.symmetric(horizontal: 30),
                      onTap: () {
                        Get.back();
                        // openAppSettings();
                        //openNotificationSetting();
                        NotificationPermissions
                            .requestNotificationPermissions();
                      },
                      child: Container(
                        height: 52,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: AppColors.btnGradient,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          Tr.app_base_confirm.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                top: 10,
                end: 10,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    Assets.iconCloseDialog,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  static Future<bool> checkMicphoneAndStoragePermission(
      {Function? cancelPermission}) async {
    Map status = await [Permission.microphone, Permission.storage].request();
    var microphone = status[Permission.microphone];
    var storageStatus = status[Permission.storage];

    if (microphone != PermissionStatus.granted ||
        storageStatus != PermissionStatus.granted) {
      List<Permission> permissions = [];

      if (microphone == PermissionStatus.permanentlyDenied) {
        permissions.add(Permission.microphone);
      }
      if (storageStatus == PermissionStatus.permanentlyDenied) {
        permissions.add(Permission.storage);
      }

      showPermissionSetting(permissions, cancelPermission);

      return false;
    }
    return true;
  }
}
