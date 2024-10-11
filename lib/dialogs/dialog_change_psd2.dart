import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oliapro/common/app_colors.dart';
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
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (qrData != null)
                Container(
                  //color: Colors.blue,
                  height: 510,
                  margin: const EdgeInsetsDirectional.only(
                      start: 26, end: 26, top: 60),
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        width: double.maxFinite,
                        height: 100,
                        alignment: AlignmentDirectional.bottomCenter,
                        padding: const EdgeInsetsDirectional.all(15),
                        margin: const EdgeInsetsDirectional.only(top: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(colors: [
                              Color(0xFF381F66),
                              Color(0xFF232258),
                            ])),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 7),
                                  child: Image.asset(
                                    Assets.imgMira,
                                    width: 38,
                                    height: 14,
                                  ),
                                ),
                                AutoSizeText(
                                  qrTip,
                                  maxLines: 1,
                                  maxFontSize: 14,
                                  minFontSize: 11,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                )
                              ],
                            )),
                            Container(
                              width: 42,
                              height: 42,
                              margin:
                                  const EdgeInsetsDirectional.only(start: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: QrImageView(
                                padding: const EdgeInsets.all(6),
                                data: qrData ?? "",
                                version: QrVersions.auto,
                                size: 42,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: 380,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    margin: const EdgeInsetsDirectional.only(
                        start: 26, end: 26, top: 60),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            colors: [
                              Color(0xFF201436),
                              Color(0xFF0C0C32),
                            ]),
                        borderRadius: BorderRadiusDirectional.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          Tr.appQRDialogTitle.tr,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          maxFontSize: 15,
                          minFontSize: 12,
                          style: const TextStyle(
                              fontSize: 15, color: Color(0xFFF447FF)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsetsDirectional.only(
                              start: 10, end: 10, top: 5, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Tr.app_login_account.tr,
                                style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.account,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsetsDirectional.only(
                              start: 10, end: 10, top: 5, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Tr.app_login_password.tr,
                                style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.password,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
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
                                Container(
                                  margin:
                                      const EdgeInsetsDirectional.only(end: 3),
                                  child: Image.asset(
                                    Assets.imgDownloadIcon,
                                    height: 20,
                                    width: 20,
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
                  Image.asset(
                    Assets.imgAppLogo,
                    width: 95,
                    height: 95,
                    matchTextDirection: false,
                  ),
                ],
              ),
              PositionedDirectional(
                  top: 50,
                  end: 40,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      widget.back?.call();
                    },
                    child: Image.asset(
                      Assets.imgCloseDialog,
                      height: 30,
                      width: 30,
                    ),
                  )),
            ],
          ),
        ),
      );
}
