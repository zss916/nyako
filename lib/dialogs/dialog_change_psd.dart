import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_dialog.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:permission_handler/permission_handler.dart';

class ChangePasswordDialog extends StatefulWidget {
  static show(String account, String password, VoidCallback call) {
    if (account.trim().isNotEmpty) {
      UserInfo.to.setVisitorPsdDialog(true);
      AppCommonDialog.dialog(
          ChangePasswordDialog(
            account,
            password,
            back: call,
          ),
          barrierDismissible: false,
          routeSettings: const RouteSettings(name: AppPages.changePsdDialog));
    }
  }

  final String account;
  final String password;
  final VoidCallback? back;

  const ChangePasswordDialog(this.account, this.password,
      {super.key, this.back});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final GlobalKey _globalKey = GlobalKey();

  Future<bool> getPermission() async {
    ///适配鸿蒙
    var HarmonyOSstatus = await Permission.storage.status;
    if (HarmonyOSstatus.isDenied) {
      await [
        Permission.storage,
      ].request();
    }

    ///android/ios
    var status = await Permission.photos.status;
    if (status.isDenied) {
      await [
        Permission.photos,
      ].request();
    }
    return status.isGranted || HarmonyOSstatus.isGranted;
  }

  void savePhoto() async {
    RenderRepaintBoundary? boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;

    double dpr = Get.pixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    //获取保存相册权限，如果没有，则申请改权限
    bool permission = await getPermission();
    // bool permission = await Permission.storage.request().isGranted;
    // var status = await Permission.photos.status;
    if (permission) {
      if (Platform.isIOS) {
        Uint8List images = byteData!.buffer.asUint8List();
        final result = await ImageGallerySaver.saveImage(images,
            quality: 60, name: "hello");
        if (result != null) {
          AppLoading.toast(Tr.app_base_success.tr);
          Future.delayed(const Duration(milliseconds: 500), () {
            widget.back?.call();
            Get.back();
          });
        } else {
          // print('error');
        }
      } else {
        //安卓
        // if (status.isGranted) {
        Uint8List images = byteData!.buffer.asUint8List();
        final result = await ImageGallerySaver.saveImage(images, quality: 60);
        if (result != null) {
          AppLoading.toast(Tr.app_base_success.tr);
          Future.delayed(const Duration(milliseconds: 500), () {
            widget.back?.call();
            Get.back();
          });
        } else {
          debugPrint('saveImageError');
        }
        // } else {
        //   // 权限被拒绝
        // }
      }
    } else {
      //重新请求--第一次请求权限时，保存方法不会走，需要重新调一次
      savePhoto();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Center(
          child: RepaintBoundary(
            key: _globalKey,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  height: 377,
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 29, vertical: 50),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          matchTextDirection: true,
                          image: ExactAssetImage(Assets.iconSmallLogo))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Tr.app_login_account.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            alignment: AlignmentDirectional.centerStart,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            child: Text(
                              widget.account,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Tr.app_login_password.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            alignment: AlignmentDirectional.centerStart,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            child: Text(
                              widget.password,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => savePhoto(),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(30),
                              gradient: AppColors.btnGradient),
                          height: 57,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Tr.app_save_image.tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 377,
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 29, vertical: 50),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Tr.app_base_success.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                PositionedDirectional(
                    top: 65,
                    end: 40,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        widget.back?.call();
                      },
                      child: Image.asset(
                        Assets.iconCloseDialog,
                        height: 30,
                        width: 30,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
