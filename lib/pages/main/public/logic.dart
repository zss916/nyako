part of 'index.dart';

class PublicLogic extends GetxController {
  List<String> pics = [];
  late String tag = "+";
  late TextEditingController ctl = TextEditingController(text: "");
  late final AppUpLoadCallBack upLoadCallBack;
  var lengthRx = 0.obs;
  late int len = 5;

  ///后端建议，接口图片最多上传6张

  @override
  void onInit() {
    super.onInit();
    upLoadCallBack = (uploader, type, url, path) {
      // AppLog.debug('UpLoadCallBack type=$type url=$url path=$path');
      switch (type) {
        case AppUploadType.begin:
          // AppLog.debug('UpLoadCallBack type=$type path=$path');
          break;
        case AppUploadType.success:
          addImg(url ?? "");
          update();
          break;
        case AppUploadType.cancel:
          break;
        case AppUploadType.failed:
          break;
      }
    };
  }

  @override
  void onReady() {
    super.onReady();
    pics.clear();
    addFirst();
  }

  @override
  void onClose() {
    super.onClose();
    ctl.dispose();
  }

  addFirst() {
    pics.insert(pics.length, tag);
    update();
  }

  addImg(String path) {
    if (pics.length <= len) {
      pics.insert(0, path);
    } else {
      pics.insert(0, path);
      pics.removeWhere((element) => element == tag);
    }
    update();
  }

  reduceImg(int index) {
    if (pics.isNotEmpty) {
      pics.removeAt(index);
      if (pics.length <= len && !pics.contains(tag)) {
        pics.insert(pics.length, tag);
      }
      update();
    }
  }

  toPublic({String content = ""}) {
    if (pics.isNotEmpty && pics.contains(tag)) {
      pics.removeWhere((element) => element == tag);
    }
    if ((content.isEmpty || content == "")) {
      AppLoading.toast(Tr.app_public_moment_tip.tr);
    } else if (pics.isEmpty) {
      AppLoading.toast(Tr.appAtLeast1Pic.tr);
    } else {
      AppLoading.show();
      var paths = _getImgString(pics);
      Map<String, dynamic> data = {
        'content': (content.isEmpty || content == "") ? null : content,
        'paths': paths,
      };
      ProfileAPI.public(data: data, showLoading: true).then((_) {
        AppEventBus.eventBus.fire(MyMomentEvent());
        Get.dialog(AppDialogTopConfirm(
          title: Tr.app_base_success.tr,
          content: Tr.app_posted_tip.tr,
          showIcon: false,
          onlyConfirm: true,
          h: 250,
          callback: (i) {
            hideKeyboard();
            Get.back();
          },
        ));
      });
    }
  }

  hideKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  String _getImgString(List<String> data) {
    return data.isEmpty ? "" : data.join(",");
  }
}
