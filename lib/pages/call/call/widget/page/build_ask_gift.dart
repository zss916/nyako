import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_gift_entity.dart';
import 'package:nyako/pages/call/call/index.dart';
import 'package:nyako/pages/call/call/widget/page/build_call_tip.dart';

class BuildAskGift extends StatefulWidget {
  final GiftEntity? data;
  final CallLogic logic;

  int i;

  BuildAskGift(
      {Key? key, required this.data, required this.logic, required this.i})
      : super(key: key);

  @override
  _BuildAskGiftState createState() => _BuildAskGiftState();
}

class _BuildAskGiftState extends State<BuildAskGift> {
  Timer? time;

  @override
  void initState() {
    super.initState();
    if (time != null) {
      time?.cancel();
      time = null;
    }
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      widget.i--;
      if (widget.i == 0) {
        widget.logic.askGiftsList.clear();
        widget.logic.update(["askGift"]);
      }
    });
  }

  @override
  void dispose() {
    if (time != null) {
      time?.cancel();
      time = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.data == null
        ? const SizedBox.shrink()
        : BuildCallTip(
            portrait: widget.logic.detail?.showPortrait ?? "",
            nickName: widget.logic.detail?.showNickName ?? "--",
            id: "ID:${widget.logic.detail?.showId ?? "--"}",
            title: Text(
              Tr.app_claim_gift_tip.trArgs([(widget.data?.name ?? "")]),
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppConstants.fontsRegular,
                  color: const Color(0xFF642A4B),
                  fontWeight: FontWeight.w500),
            ),
            submit: Text(
              Tr.app_gift_send.tr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: AppConstants.fontsRegular,
                  fontWeight: FontWeight.w500),
            ),
            onCancel: () {
              widget.logic.askGiftsList.clear();
              widget.logic.update(["askGift"]);
            },
            onSubmit: () {
              if (widget.data != null) {
                widget.logic.sendGift(widget.data!, onEnd: () {
                  widget.logic.askGiftsList.clear();
                  widget.logic.update(["askGift"]);
                });
              }
            },
          );
  }
}
