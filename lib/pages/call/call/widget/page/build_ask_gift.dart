import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_gift_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/call/index.dart';
import 'package:oliapro/utils/app_extends.dart';

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
        : Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF8940FF), Color(0xFFD34BFD)]),
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsetsDirectional.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(width: 1, color: Colors.transparent)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: cachedImage(widget.data?.icon ?? ""),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      Tr.app_claim_gift_tip
                          .trArgs([(widget.data?.name ?? "--")]),
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        if (widget.data != null) {
                          widget.logic.sendGift(widget.data!, onEnd: () {
                            widget.logic.askGiftsList.clear();
                            widget.logic.update(["askGift"]);
                          });
                        }
                      },
                      child: Container(
                        height: 36,
                        // width: 94,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(50),
                        ),
                        child: AutoSizeText(
                          Tr.app_gift_send.tr,
                          maxFontSize: 12,
                          minFontSize: 6,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Color(0xFF8239FF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              PositionedDirectional(
                  top: 0,
                  start: 10,
                  child: GestureDetector(
                    onTap: () {
                      widget.logic.askGiftsList.clear();
                      widget.logic.update(["askGift"]);
                    },
                    child: Image.asset(
                      Assets.imgCloseHg,
                      height: 24,
                      width: 24,
                    ),
                  )),
            ],
          );
  }
}
