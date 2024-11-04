import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/widget/base_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

@RouteName(AppPages.webPage)
class WebPage extends StatefulWidget {
  const WebPage({super.key});

  static startMe(String url, {bool isAiHelp = false}) {
    Map<String, dynamic> map = {};
    map['url'] = url;
    map['aihelp'] = isAiHelp;
    Get.toNamed(AppPages.webPage, arguments: map);
  }

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  String url = "";

  String title = "";
  late WebViewController webViewController;
  String _lastUrl = "";

  bool isShowClose = false;

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments as Map<String, dynamic>;
    url = arguments['url']!;
    isShowClose = arguments['aihelp']!;
    initWebController();
    _addFileSelectionListener();
    /* SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);*/
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
          onProgress: (int progress) {
            debugPrint("progress: $progress");
          },
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
      ..loadRequest(Uri.parse(url));
    _lastUrl = url;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          leading: isShowClose ? const SizedBox.shrink() : null,
          title: title,
          actions: [
            //isShowClose
            if (isShowClose)
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 15),
                  child: Image.asset(
                    Assets.iconCallClose,
                    width: 34,
                    height: 34,
                  ),
                ),
              )
          ],
        ),
        extendBodyBehindAppBar: false,
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            WebViewWidget(
              controller: webViewController,
            ),
          ],
        ));
  }
}
