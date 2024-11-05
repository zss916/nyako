import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_loading.dart';

void showReportSheet(String anchorId, {VoidCallback? close}) {
  Get.bottomSheet(
      BottomArrowWidget(
        child: ReportDialog(
          uid: anchorId,
          channelId: "",
          close: close,
        ),
        onBack: () => Get.back(),
      ),
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.reportSheet));
}

class ReportDialog extends StatefulWidget {
  final String uid;
  final String channelId;
  final VoidCallback? close;

  const ReportDialog(
      {super.key, required this.uid, required this.channelId, this.close});

  @override
  State<ReportDialog> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportDialog> with RouteAware {
  FocusNode? _focusNode;
  late TextEditingController textEditCtrl = TextEditingController();
  int selectIndex = -1;

  final reportList = [
    Tr.app_report_text_1.tr,
    Tr.app_report_text_2.tr,
    Tr.app_report_text_3.tr,
    Tr.app_report_text_4.tr,
    Tr.app_report_text_5.tr,
    Tr.app_report_text_7.tr,
    Tr.app_report_text_8.tr,
    Tr.app_report_text_9.tr,
    Tr.app_report_text_6.tr
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didPushNext() {
    _focusNode?.unfocus();
    super.didPushNext();
  }

  @override
  void didPop() {
    _focusNode?.unfocus();
    super.didPop();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    textEditCtrl.addListener(() {
      if ((textEditCtrl.text.length ?? 0) > 200) {
        textEditCtrl.text = textEditCtrl.text.substring(0, 200) ?? "";
        textEditCtrl.selection = TextSelection(
            baseOffset: textEditCtrl.text.length ?? 0,
            extentOffset: textEditCtrl.text.length ?? 0);
      }
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    textEditCtrl.dispose();
    // MRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(24), topEnd: Radius.circular(24))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              Tr.app_report_title.tr,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 5),
              child: Text(
                Tr.app_report_description.tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 13,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.normal),
              ),
            ),
            list(),
            // submit()
          ],
        ),
      ),
    );
  }

  Widget list() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: reportList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => setSelect(index),
            child: Container(
              height: 45,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: index == selectIndex
                      ? const Color(0x1A939393)
                      : Colors.transparent,
                  borderRadius: BorderRadiusDirectional.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: AutoSizeText(
                    reportList[index],
                    maxFontSize: 16,
                    minFontSize: 8,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: index == selectIndex
                            ? AppConstants.fontsBold
                            : AppConstants.fontsRegular,
                        color: index == selectIndex
                            ? Colors.black
                            : const Color(0xFF666666),
                        fontWeight: index == selectIndex
                            ? FontWeight.w600
                            : FontWeight.w500),
                  )),
                  buildSelect(index)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void setSelect(int index) {
    setState(() {
      selectIndex = index;
    });

    report(widget.uid, widget.channelId, close: widget.close);
  }

  Widget submit() {
    return GestureDetector(
      child: Container(
        width: double.maxFinite,
        height: 52,
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsets.only(bottom: 10, top: 20, left: 15, right: 15),
        decoration: BoxDecoration(
            gradient: AppColors.btnGradient,
            borderRadius: BorderRadiusDirectional.circular(30)),
        child: AutoSizeText(
          Tr.app_report_submit.tr,
          maxLines: 1,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      onTap: () => report(widget.uid, widget.channelId, close: widget.close),
    );
  }

  Image buildSelect(int index) {
    return index == selectIndex
        ? Image.asset(
            Assets.iconSelected,
            width: 25,
            height: 25,
          )
        : Image.asset(
            Assets.iconUnselect,
            width: 25,
            height: 25,
          );
  }

  void report(String upid, String channelid, {VoidCallback? close}) {
    Map<String, dynamic> data = {
      "type": "2",
      "anchorUserId": upid,
      "topic": reportList[selectIndex],
      "content": "not input",
      "linkId": channelid,
    };

    ProfileAPI.report(data: data, showLoading: true).then((value) {
      AppLoading.toast(Tr.app_base_success.tr);
      Get.back(result: 1);
      close?.call();
    });

    // 举报后要拉黑
    if (StorageService.to.checkBlackList(upid)) {
      return;
    }
    ProfileAPI.handBlack(anchorId: upid).then((value) {
      if (value == 1) {
        StorageService.to.updateBlackList(upid, true);
      }
    });
  }
}
