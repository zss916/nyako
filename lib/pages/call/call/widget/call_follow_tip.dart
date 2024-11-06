import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/call/call/index.dart';
import 'package:nyako/pages/call/call/widget/page/build_call_tip.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../common/language_key.dart';
import '../../../../entities/app_gift_entity.dart';

enum CallDialogToolType {
  none,
  follow, // 关注
  gift, // 提示送礼
  askGift, // 主播要礼物
  countDown, // 20s 通话倒计时
}

class CallFollowTip extends StatelessWidget {
  final CallDialogToolType type;
  final Function(bool send) callBack;
  final String? netImage;
  final int? count2MinLeft;
  final GiftEntity? gift;
  final CallLogic? logic;

  const CallFollowTip(
      {Key? key,
      required this.type,
      required this.callBack,
      this.netImage,
      this.count2MinLeft,
      this.gift,
      this.logic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (type == CallDialogToolType.askGift)
    // TestRtmUtils.showRtmGift(msg: "弹出索要礼物 ${type}");

    return buildContent(type.index);

    /*return type == CallDialogToolType.none
        ? const SizedBox.shrink()
        : commonTip(type == CallDialogToolType.countDown);*/
  }

  Widget buildContent(int state) {
    return switch (state) {
      _ when state == CallDialogToolType.gift.index => buildSendGift(),
      _ when state == CallDialogToolType.follow.index => buildFollowTip(),
      _ when state == CallDialogToolType.countDown.index =>
        const SizedBox.shrink(),
      _ when state == CallDialogToolType.none.index => const SizedBox.shrink(),
      _ => const SizedBox.shrink(),
    };
  }

  /* Widget _buildLeftItem() {
    return type == CallDialogToolType.countDown
        ? indicator((count2MinLeft ?? 0) / 20)
        : type == CallDialogToolType.gift
            ? Image.asset(
                Assets.imgMsgGift,
                matchTextDirection: true,
                height: 40,
                width: 40,
              )
            : Container(
                width: 40,
                height: 40,
                padding: const EdgeInsetsDirectional.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1, color: Colors.transparent)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: cachedImage(netImage ?? ""),
                ),
              );
  }

  Widget _buildCenterItem() {
    return Expanded(
        child: Container(
      margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
      child: (type == CallDialogToolType.follow)
          ? Text.rich(TextSpan(
              text: Tr.app_video_to_follow_tip.tr,
              style: const TextStyle(color: Colors.white, fontSize: 14)))
          : type == CallDialogToolType.gift
              ? Text.rich(TextSpan(
                  text: Tr.app_video_to_gift_tip.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14)))
              : type == CallDialogToolType.askGift
                  ? Text(
                      Tr.app_claim_gift_tip.trArgs([(gift?.name ?? "")]),
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )
                  : type == CallDialogToolType.countDown
                      ? GestureDetector(
                          onTap: () {
                            callBack(true);
                          },
                          child: Text.rich(
                            TextSpan(
                                text: "${Tr.app_chat_left_charge_tip_1.tr} ",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13),
                                children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Image.asset(
                                        Assets.imgDiamond,
                                        matchTextDirection: true,
                                        width: 15,
                                        height: 15,
                                      )),
                                  TextSpan(
                                      text:
                                          ' ${UserInfo.to.config?.chargePrice.toString() ?? "--"}',
                                      style: const TextStyle(
                                          color: Color(0xFFFF890E),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          " ${Tr.app_chat_left_charge_tip_2.tr} "),
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox.shrink(),
    ));
  }

  Widget _buildRightItem() {
    return GestureDetector(
        onTap: () {
          callBack(true);
        },
        child: type == CallDialogToolType.askGift
            ? Container(
                height: 40,
                width: 94,
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
              )
            : type == CallDialogToolType.follow
                ? Image.asset(
                    Assets.imgFollow,
                    matchTextDirection: true,
                    height: 30,
                    width: 40,
                  )
                : type == CallDialogToolType.gift
                    ? Container(
                        height: 40,
                        width: 94,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(50),
                        ),
                        child: AutoSizeText(
                          Tr.app_video_send_gift.tr,
                          maxLines: 1,
                          maxFontSize: 16,
                          minFontSize: 8,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xFF8239FF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : type == CallDialogToolType.countDown
                        ? Container(
                            height: 40,
                            width: 94,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadiusDirectional.circular(50),
                            ),
                            child: AutoSizeText(
                              Tr.app_recharge.tr,
                              maxLines: 1,
                              maxFontSize: 16,
                              minFontSize: 8,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Color(0xFF8239FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox.shrink());
  }

  Widget commonTip(bool isCountDown) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF8940FF), Color(0xFFD34BFD)]),
              borderRadius: BorderRadiusDirectional.circular(20),
            ),
            child: Row(
              children: [
                _buildLeftItem(),
                _buildCenterItem(),
                _buildRightItem(),
              ],
            ),
          ),
          PositionedDirectional(
              top: 0,
              start: 10,
              child: GestureDetector(
                onTap: () => callBack(false),
                child: Image.asset(
                  Assets.imgCloseHg,
                  height: 24,
                  width: 24,
                ),
              )),
        ],
      ),
    );
  }*/

  Widget indicator(double percent) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: CircularPercentIndicator(
        radius: 25,
        reverse: true,
        circularStrokeCap: CircularStrokeCap.round,
        animation: true,
        animationDuration: 0,
        percent: percent,
        lineWidth: 2,
        widgetIndicator: UnconstrainedBox(
          child: Container(
            width: 6,
            height: 6,
            margin: const EdgeInsetsDirectional.only(start: 5),
            decoration: const BoxDecoration(
              color: Color(0xFFFE2C55),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
        ),
        backgroundColor: Colors.white10,
        progressColor: const Color(0xFFFE2C55),
        center: Text(
          "$count2MinLeft",
          style: const TextStyle(
              color: Color(0xFFFE2C55),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildFollowTip() => Container(
        margin: const EdgeInsetsDirectional.only(top: 60),
        child: BuildCallTip(
          portrait: logic?.detail?.showPortrait ?? "",
          nickName: logic?.detail?.showNickName ?? "--",
          id: "ID:${logic?.detail?.showId ?? "--"}",
          title: Text(
            Tr.app_video_to_follow_tip.tr,
            style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF642A4B),
                fontWeight: FontWeight.w500),
          ),
          submit: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 6),
                child: Image.asset(
                  Assets.iconFollow,
                  width: 20,
                  height: 20,
                  matchTextDirection: true,
                ),
              ),
              Text(
                Tr.app_details_follow.tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          onCancel: () {
            callBack(false);
          },
          onSubmit: () {
            callBack(true);
          },
        ),
      );

  Widget buildSendGift() => Container(
        margin: const EdgeInsetsDirectional.only(top: 60),
        child: BuildCallTip(
          portrait: logic?.detail?.showPortrait ?? "",
          nickName: logic?.detail?.showNickName ?? "--",
          id: "ID:${logic?.detail?.showId ?? "--"}",
          title: Text(
            Tr.app_video_to_gift_tip.tr,
            style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF642A4B),
                fontWeight: FontWeight.w500),
          ),
          submit: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 6),
                child: Image.asset(
                  Assets.iconGiftIc,
                  width: 20,
                  height: 20,
                  matchTextDirection: true,
                ),
              ),
              Text(
                Tr.app_gift_send.tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          onCancel: () {
            callBack(false);
          },
          onSubmit: () {
            callBack(true);
          },
        ),
      );
}
