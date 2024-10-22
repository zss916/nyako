import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/widget/scale_transform.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ChangePasswordDialog2 extends StatefulWidget {
  static show(String account, String password, VoidCallback call) {
    if (account.trim().isNotEmpty) {
      UserInfo.to.setVisitorPsdDialog(true);
      Get.dialog(
          ChangePasswordDialog2(
            account,
            password,
            back: call,
          ),
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.8),
          useSafeArea: true,
          routeSettings: const RouteSettings(name: AppPages.saveAccountDialog));
    }
  }

  final String account;
  final String password;
  final VoidCallback? back;

  const ChangePasswordDialog2(this.account, this.password,
      {super.key, this.back});

  @override
  State<ChangePasswordDialog2> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog2> {
  final GlobalKey _globalKey = GlobalKey();

  String? qrData = UserInfo.to.qr;
  String qrTip = Tr.appQRTip.tr;

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
    return ScaleTransform(
      child: body(),
    );
  }

  Widget body() => Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(start: 30, end: 30),
                padding: const EdgeInsetsDirectional.only(
                    top: 20, start: 20, end: 20, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.iconNyakoTitle,
                      width: 150,
                      height: 50,
                    ),
                    Container(
                      //height: 60,
                      width: double.maxFinite,
                      margin: const EdgeInsetsDirectional.only(top: 10),
                      padding: const EdgeInsetsDirectional.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0x149341FF),
                          borderRadius: BorderRadiusDirectional.circular(12)),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 10),
                            child: Image.asset(
                              Assets.iconNyakoAccount,
                              matchTextDirection: true,
                              width: 38,
                              height: 38,
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Tr.app_login_account.tr,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Color(0xFF9B989D), fontSize: 13),
                              ),
                              Text(
                                widget.account,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                      //height: 60,
                      width: double.maxFinite,
                      margin: const EdgeInsetsDirectional.only(top: 12),
                      padding: const EdgeInsetsDirectional.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0x149341FF),
                          borderRadius: BorderRadiusDirectional.circular(12)),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 10),
                            child: Image.asset(
                              Assets.iconNyakoPassword,
                              matchTextDirection: true,
                              width: 38,
                              height: 38,
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Tr.app_login_password.tr,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Color(0xFF9B989D), fontSize: 13),
                              ),
                              Text(
                                widget.password,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(vertical: 20),
                      child: const Divider(
                        height: 1,
                        color: Color(0xFFEEEEEE),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          margin: const EdgeInsetsDirectional.only(end: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: QrImageView(
                            padding: const EdgeInsets.all(6),
                            data: qrData ?? "",
                            version: QrVersions.auto,
                            size: 54,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              Assets.iconNyakoSmallIc,
                              width: 50,
                              height: 18,
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.only(top: 3),
                              height: 36,
                              width: double.maxFinite,
                              child: AutoSizeText(
                                qrTip,
                                maxLines: 2,
                                maxFontSize: 13,
                                minFontSize: 10,
                                softWrap: true,
                                style: const TextStyle(
                                    color: Color(0xFF9B989D),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                    GestureDetector(
                      onTap: () => savePhoto(),
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(top: 30),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9341FF),
                          borderRadius: BorderRadiusDirectional.circular(30),
                        ),
                        height: 52,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 3),
                              child: Image.asset(
                                Assets.iconDownloadIcon,
                                height: 24,
                                width: 24,
                                matchTextDirection: true,
                              ),
                            ),
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
              GestureDetector(
                onTap: () {
                  Get.back();
                  widget.back?.call();
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(top: 20),
                  child: Image.asset(
                    Assets.iconCloseDialog,
                    height: 42,
                    width: 42,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
