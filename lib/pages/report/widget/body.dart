import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/report/index.dart';
import 'package:oliapro/widget/animated_button.dart';

class ReportBody extends StatefulWidget {
  final ReportLogic logic;

  const ReportBody(this.logic, {super.key});

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> with RouteAware {
  FocusNode? _focusNode;

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
    widget.logic.controller = TextEditingController();
    widget.logic.controller?.addListener(() {
      if ((widget.logic.controller?.text.length ?? 0) > 200) {
        widget.logic.controller?.text =
            widget.logic.controller?.text.substring(0, 200) ?? "";
        widget.logic.controller?.selection = TextSelection(
            baseOffset: widget.logic.controller?.text.length ?? 0,
            extentOffset: widget.logic.controller?.text.length ?? 0);
      }
    });
    if (Get.parameters['upid'] != null) {
      widget.logic.upid = Get.parameters['upid'];
    }
    if (Get.parameters['channelid'] != null) {
      widget.logic.upid = Get.parameters['channelid'];
    }
    if (Get.parameters['index'] != null) {
      widget.logic.index = int.parse(Get.parameters['index'] ?? "-1");
    }
    if (Get.parameters['type'] != null) {
      widget.logic.type = int.parse(Get.parameters['type'] ?? "-1");
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    widget.logic.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          children: [top(), list(), submit()],
        ),
      ),
    );
  }

  Widget top() {
    return Container(
      margin:
          const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadiusDirectional.all(
          Radius.circular(16),
        ),
      ),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 15),
      child: Text(
        Tr.app_report.tr,
        maxLines: null,
        style: const TextStyle(fontSize: 14, color: Color(0xFFC3A0FF)),
      ),
    );
  }

  Widget list() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadiusDirectional.circular(16)),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.logic.reportList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => widget.logic.setSelect(index),
                child: Container(
                  height: 45,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: AutoSizeText(
                        widget.logic.reportList[index],
                        maxFontSize: 16,
                        minFontSize: 8,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                      GetBuilder<ReportLogic>(
                        assignId: true,
                        init: ReportLogic(),
                        builder: (logic) {
                          return buildSelect(index);
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          // field(),
        ],
      ),
    );
  }

  Widget field() {
    return Container(
      constraints: BoxConstraints(minHeight: 150.h),
      margin: const EdgeInsetsDirectional.only(
          top: 10, bottom: 30, start: 15, end: 15),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
      ),
      child: TextField(
        maxLines: 10,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        controller: widget.logic.controller,
        focusNode: _focusNode,
        inputFormatters: [
          LengthLimitingTextInputFormatter(200),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: Tr.app_not_exceed.trArgs(["200"]),
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget submit() {
    return AnimatedButton(
      onCall: () => widget.logic.report(),
      child: Container(
        width: double.maxFinite,
        height: 52,
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsets.only(bottom: 30, top: 20, left: 15, right: 15),
        decoration: BoxDecoration(
          gradient: AppColors.btnGradient,
          borderRadius: BorderRadiusDirectional.circular(30),
        ),
        child: AutoSizeText(
          Tr.app_report_submit.tr,
          maxLines: 1,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
    /*return InkWell(
      onTap: () => widget.logic.report(),
      child: Container(
        width: double.maxFinite,
        height: 52,
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsets.only(bottom: 30, top: 20, left: 15, right: 15),
        decoration: BoxDecoration(
          gradient: AppColors.btnGradient,
          borderRadius: BorderRadiusDirectional.circular(30),
        ),
        child: AutoSizeText(
          Tr.app_report_submit.tr,
          maxLines: 1,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),

    );*/
  }

  Image buildSelect(int index) {
    return index == widget.logic.selectIndex.value
        ? Image.asset(
            Assets.imgChecked,
            width: 16,
            height: 16,
            matchTextDirection: true,
          )
        : Image.asset(
            Assets.imgUncheck,
            width: 16,
            height: 16,
            color: const Color(0xFFBAAEB7),
            matchTextDirection: true,
          );
  }
}
