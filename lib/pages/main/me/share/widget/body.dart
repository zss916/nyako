import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sheet_app_invite.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/share/index.dart';
import 'package:oliapro/pages/main/me/share/widget/ActionWidget.dart';
import 'package:oliapro/pages/main/me/share/widget/text_widget.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/widget/animated_button.dart';
import 'package:oliapro/widget/base_app_bar.dart';

class ShareBody extends StatefulWidget {
  const ShareBody({super.key});

  @override
  State<ShareBody> createState() => _ShareBodyState();
}

class _ShareBodyState extends State<ShareBody> {
  late ScrollController scrollCtrl;
  static const int DEFAULT_SCROLLER = 38;
  late double toolbarOpacity = 0;
  late String content = Tr.app_share_tip.tr;
  late String title = Tr.app_receive_gift.tr;

  @override
  void initState() {
    super.initState();
    scrollCtrl = ScrollController();
    scrollCtrl.addListener(() {
      //double position = scrollController.offset;
      double t = scrollCtrl.offset / DEFAULT_SCROLLER;
      if (t < 0.0) {
        t = 0.0;
      } else if (t > 1.0) {
        t = 1.0;
      }
      if (mounted) {
        setState(() {
          toolbarOpacity = t;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    super.dispose();
  }

  bool get isSmall => ScreenUtil().screenHeight < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: toolbarOpacity == 0 ? "" : title,
          isDark: true,
          isSetBg: true,
          actions: const [ActionWidget()],
          backgroundColor: const Color(0xFFFF3689).withOpacity(toolbarOpacity)),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFF3689),
      body: SingleChildScrollView(
        controller: scrollCtrl,
        child: SizedBox(
          width: Get.width,
          height: isSmall ? (Get.height * 2) + 10 : (Get.height * 1.8),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              PositionedDirectional(
                  top: 0,
                  start: 0,
                  end: 0,
                  child: Image.asset(
                    Assets.imgShareBg3,
                    fit: BoxFit.fitWidth,
                    matchTextDirection: true,
                  )),
              Positioned.fill(child: buildContent())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 80),
          child: const TextWidget(),
        ),
        GetBuilder<ShareLogic>(
          assignId: true,
          init: ShareLogic(),
          builder: (logic) {
            return AnimatedButton(
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                    top: 10, start: 25, end: 25),
                decoration: BoxDecoration(
                    color: const Color(0xFFFA3485),
                    borderRadius: BorderRadiusDirectional.circular(12)),
                child: _myInviteCode(logic.data?.inviteCode ?? "--", logic),
              ),
              onCall: () => logic.copyId(),
            );
          },
        ),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsetsDirectional.only(bottom: 15),
          margin: const EdgeInsetsDirectional.only(
              top: 250, start: 15, end: 15, bottom: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(20)),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
                alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          Color(0xFFFFE0A2),
                          Color(0xFFFFF6E6),
                        ]),
                    borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(14))),
                child: Text(
                  Tr.app_invite_friends.tr,
                  style: const TextStyle(
                      color: Color(0xFF935B0A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GetBuilder<ShareLogic>(
                assignId: true,
                init: ShareLogic(),
                builder: (logic) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => ARoutes.toRewardDetails(),
                        child: Container(
                          width: double.maxFinite,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 20, end: 10, top: 10, bottom: 10),
                                child: Image.asset(Assets.imgAddInviteFriend,
                                    width: 48,
                                    height: 48,
                                    matchTextDirection: true),
                              ),
                              Expanded(
                                  child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 5, end: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      (logic.data?.inviteCount ?? 0).toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontFamily: AppConstants.fontsBold,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Tr.app_invite_num.tr,
                                      style: const TextStyle(
                                          color: Color(0xFF8C899C),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 20),
                        width: double.maxFinite,
                        height: 1,
                        color: const Color(0xFFEEEEEE),
                      ),
                      GestureDetector(
                        onTap: () => ARoutes.toRewardDetails(),
                        child: Container(
                          width: double.maxFinite,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 20, end: 10, top: 10, bottom: 10),
                                child: Image.asset(Assets.imgDiamond,
                                    width: 48,
                                    height: 48,
                                    matchTextDirection: true),
                              ),
                              Expanded(
                                  child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 5, end: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      (logic.data?.awardIncome ?? 0).toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontFamily: AppConstants.fontsBold,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      Tr.app_rewards.tr,
                                      style: const TextStyle(
                                          color: Color(0xFF8C899C),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 0,
              ),
              GetBuilder<ShareLogic>(
                assignId: true,
                init: ShareLogic(),
                builder: (logic) {
                  return _btn(
                      "${(logic.data?.shareContent ?? ":")}${logic.data?.shareUrl ?? ""}");
                },
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                    top: 13, start: 15, end: 15),
                child: AutoSizeText(
                  content,
                  textAlign: TextAlign.center,
                  maxFontSize: 12,
                  minFontSize: 8,
                  maxLines: 3,
                  style:
                      const TextStyle(color: Color(0xFF935B0A), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        _buildTip(),
      ],
    );
  }

  Widget _winTip(
      String inviteAward, String rechargeAward, String inviteeCardCount) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(top: 0, bottom: 0),
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
            alignment: AlignmentDirectional.center,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      Color(0xFFFFE0A2),
                      Color(0xFFFFF6E6),
                    ]),
                borderRadius:
                    BorderRadiusDirectional.vertical(top: Radius.circular(14))),
            child: Text(
              Tr.app_reward_tip.tr,
              style: const TextStyle(
                  color: Color(0xFF935B0A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Text(
              Tr.app_reward_content1.trArgs([inviteAward]),
              style: const TextStyle(color: Color(0xFF666666), fontSize: 14),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Text(
              Tr.app_reward_content2.trArgs([rechargeAward]),
              style: const TextStyle(color: Color(0xFF666666), fontSize: 14),
            ),
          ),
          if (AppConstants.isFakeMode == false)
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Text(
                Tr.app_reward_content3.trArgs([inviteeCardCount]),
                style: const TextStyle(color: Color(0xFF666666), fontSize: 14),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildTip() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(14)),
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 30),
      child: GetBuilder<ShareLogic>(
        assignId: true,
        init: ShareLogic(),
        builder: (logic) {
          return _winTip(
              (logic.data?.inviteAward ?? 0).toString(),
              (logic.data?.rechargeAward ?? 0).toString(),
              (logic.data?.inviteeCardCount ?? 0).toString());
        },
      ),
    );
  }

  Widget _btn(String url) {
    return AnimatedButton(
      onCall: () {
        if (url.isNotEmpty) {
          sheetToInvite(url);
        }
      },
      child: Container(
        width: double.maxFinite,
        height: 54,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 45),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: ExactAssetImage(Assets.imgInviteBtn)),
            borderRadius: BorderRadiusDirectional.circular(35)),
        child: AutoSizeText(
          Tr.app_invite_friends.tr,
          maxFontSize: 16,
          minFontSize: 8,
          maxLines: 1,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _myInviteCode(String code, ShareLogic logic) {
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Tr.app_my_invite_code.trArgs([":"]),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(code,
              style: TextStyle(
                  color: const Color(0xFFFFEB95),
                  fontSize: 14,
                  fontFamily: AppConstants.fontsRegular,
                  fontWeight: FontWeight.normal)),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 3),
            child: Image.asset(
              Assets.imgCopyID,
              width: 14,
              height: 14,
              matchTextDirection: true,
            ),
          )
        ],
      ),
    );
  }
}
