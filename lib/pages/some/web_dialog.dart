import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/widget/base_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

void showWebDialog(String url) {
  BotToast.showAnimationWidget(
    toastBuilder: (cancelFunc) {
      return Web(url, cancelFunc);
    },
    onClose: () {},
    backgroundColor: const Color(0x7F000000),
    animationDuration: const Duration(seconds: 0),
    animationReverseDuration: const Duration(seconds: 0),
    wrapToastAnimation: (controller, cancel, child) => SafeArea(child: child),
    groupKey: "webRechargeBot",
    onlyOne: false,
    crossPage: true,
    clickClose: false,
    allowClick: false,
    backButtonBehavior: BackButtonBehavior.close,
  );
}

class Web extends StatefulWidget {
  String url;
  CancelFunc cancelFunc;

  Web(this.url, this.cancelFunc, {super.key});

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  String title = "";
  String _lastUrl = "";
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);*/
    initWebController();
    _addFileSelectionListener();
  }

  Future _addFileSelectionListener() async {
    if (GetPlatform.isAndroid) {
      final androidController =
          webViewController.platform as AndroidWebViewController;
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    List<String> result = [];

    List<XFile>? xFiles = await ImagePicker().pickMultiImage();
    if (xFiles.isNotEmpty) {
      for (var element in xFiles) {
        String filePath = element.path;
        result.add(File(filePath).uri.toString());
      }
    }
    return result;
  }

  void initWebController() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (!request.url.startsWith('http')) {
              if (await launch(request.url)) {
                return NavigationDecision.prevent;
              }
            }
            if (_lastUrl == request.url) {
              return NavigationDecision.navigate;
            } else {
              webViewController.loadRequest(Uri.parse(request.url),
                  headers: {"referer": _lastUrl});
              _lastUrl = request.url;
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    _lastUrl = widget.url;
    webViewController.addJavaScriptChannel('flutterapp',
        onMessageReceived: (JavaScriptMessage message) {
      if (message.message == "goback") {
        Get.back();
      } else if (message.message == "recharge") {
        ARoutes.toRecharge();
      } else if (message.message == "gift") {
        Navigator.popUntil(
            Get.context!,
            (route) => ((Get.isDialogOpen != true &&
                    Get.isBottomSheetOpen != true &&
                    Get.isOverlaysOpen != true &&
                    Get.isSnackbarOpen != true &&
                    ARoutes.isMainPage) ||
                ARoutes.isMainPage));
      } else if (message.message == "call") {
        Navigator.popUntil(
            Get.context!,
            (route) => ((Get.isDialogOpen != true &&
                    Get.isBottomSheetOpen != true &&
                    Get.isOverlaysOpen != true &&
                    Get.isSnackbarOpen != true &&
                    ARoutes.isMainPage) ||
                ARoutes.isMainPage));
      } else if (message.message == "completeMaterial") {
        ARoutes.toUserEdit();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //webViewController = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: title,
          back: () {
            widget.cancelFunc.call();
          },
        ),
        extendBodyBehindAppBar: false,
        body: WebViewWidget(
          controller: webViewController,
        ));
  }
}
