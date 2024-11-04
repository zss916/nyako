import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/database/entity/app_msg_entity.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/utils/image_update/image_utils.dart';

import '../app_loading.dart';
import '../app_upload_isolate.dart';

typedef AppUpLoadCallBack = Function(AppChooseImageUtil upLoader,
    AppUploadType type, String? url, String? partPath);

enum AppUploadType { cancel, begin, success, failed }

class AppChooseImageUtil {
  final AppUpLoadCallBack callBack;

  // type 0头像，1图片，2声音
  final int type;

  // 如果他是发消息，做暂时的存储
  MsgEntity? msg;

  AppChooseImageUtil({required this.type, required this.callBack});

  void openChooseDialog() {
    Get.bottomSheet(
      BottomArrowWidget(
        child: Container(
            width: Get.width,
            height: Get.width / 2,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      Get.back();
                      goChooseImage(true);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsetsDirectional.symmetric(vertical: 10),
                      margin: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        Tr.app_base_take_picture.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      Get.back();
                      goChooseImage(false);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsetsDirectional.symmetric(vertical: 10),
                      margin: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        Tr.app_details_album.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsetsDirectional.symmetric(vertical: 10),
                      margin: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(20))),
                      child: Text(
                        Tr.app_base_cancel.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstants.fontsRegular,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        onBack: () {
          Get.back();
        },
      ),
      isScrollControlled: true,
      barrierColor: Colors.black12,
    );
  }

  Future<void> goChooseImage(bool camera) async {
    await ImageUtils.chooseOneImage(camera: camera).then((file) {
      if (file == null) {
        callBack.call(this, AppUploadType.failed, null, null);
      } else {
        callBack.call(this, AppUploadType.begin, null, file.path);
        // debugPrint("压缩前 => ${ImageUtils.getShowLogger(file.path)}");
        //loadOssAndUpload(file.path);
        ImageUtils.compress(file.path).then((path) {
          // debugPrint("压缩后 => ${ImageUtils.getShowLogger(path)}");
          loadOssAndUpload(path);
        });
      }
    });
  }

  @Deprecated("old")
  void goChooseImage2(bool camera) {
    ImagePicker()
        .pickImage(
            source: camera ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080)
        .then((value) {
      if (value != null) {
        loadOssAndUpload(value.path);
        callBack.call(this, AppUploadType.begin, null, value.path);
      } else {
        callBack.call(this, AppUploadType.failed, null, null);
      }
    });
  }

  // type 0头像，1图片，2声音
  void loadOssAndUpload(String path) {
    AppLoading.show();
    Http.instance.post<String>(NetPath.s3UploadUrl, data: {'endType': '.jpg'},
        errCallback: (err) {
      // AppLog.debug(err);
      //  AppLoading.toast(err.message);
      callBack.call(this, AppUploadType.failed, null, null);
    }, showLoading: true).then((url) {
      // debugPrint("loadOssAndUpload => $url");
      uploadWithFilePath(path, url);
    });
  }

// type 0头像，1图片，2声音
  void uploadWithFilePath(String filePath, String url) async {
    try {
      AppUploadIsolate().loadData(url, filePath, 'image/jpeg').then((value) {
        if (value == 200) {
          var realUrl = url.split('?')[0];
          // AppLog.debug("图片上传成功 URL= ${realUrl}");
          callBack.call(this, AppUploadType.success, realUrl, filePath);
        } else {
          callBack.call(this, AppUploadType.failed, null, null);
        }
      }).catchError((e) {
        callBack.call(this, AppUploadType.failed, null, null);
      }).whenComplete(() => AppLoading.dismiss());
    } catch (e) {
      //AppLog.debug(e);
      callBack.call(this, AppUploadType.failed, null, null);
    } finally {
      AppLoading.dismiss();
    }
  }
}
