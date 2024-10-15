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
import 'package:oliapro/pages/main/me/share/widget/share_title_image.dart';
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
  final String copy = Tr.appCopy.tr;

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
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            bottom: 0,
            child: Image.asset(
              Assets.iconShareBg,
              fit: BoxFit.fitWidth,
              matchTextDirection: true,
            )),
        PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: Container(
              height: 250,
              padding:
                  const EdgeInsetsDirectional.only(start: 5, end: 5, bottom: 0),
              width: double.maxFinite,
              alignment: AlignmentDirectional.bottomCenter,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      matchTextDirection: true,
                      fit: BoxFit.fitWidth,
                      image: ExactAssetImage(Assets.iconInviteBg))),
              child: const ShareTitleImage(),
            )),
        Scaffold(
          appBar: BaseAppBar(
              title: toolbarOpacity == 0 ? "" : title,
              actions: const [ActionWidget()],
              backgroundColor:
                  const Color(0xFFFEC3B3).withOpacity(toolbarOpacity)),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          //backgroundColor: const Color(0xFFFEC3B3),
          body: SingleChildScrollView(
            controller: scrollCtrl,
            child: SizedBox(
              width: Get.width,
              height: isSmall ? (Get.height * 2) + 10 : (Get.height * 1.8),
              child: buildContent(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsetsDirectional.only(bottom: 15),
          margin: const EdgeInsetsDirectional.only(
              top: 245, start: 15, end: 15, bottom: 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(20)),
          child: Column(
            children: [
              GetBuilder<ShareLogic>(
                assignId: true,
                init: ShareLogic(),
                builder: (logic) {
                  return Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () => ARoutes.toRewardDetails(),
                        child: Container(
                          // color: Colors.blue,
                          margin: const EdgeInsetsDirectional.only(
                              start: 10, end: 10, top: 30, bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(bottom: 5),
                                child: Image.asset(Assets.iconBigDiamond,
                                    width: 48,
                                    height: 48,
                                    matchTextDirection: true),
                              ),
                              Text(
                                (logic.data?.awardIncome ?? 0).toString(),
                                style: TextStyle(
                                    color: const Color(0xFFFF4864),
                                    fontSize: 20,
                                    fontFamily: AppConstants.fontsBold,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(top: 10),
                                child: Text(
                                  Tr.app_rewards.tr,
                                  style: const TextStyle(
                                      color: Color(0xFF9B989D),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(
                        height: 84,
                        child: VerticalDivider(
                          width: 1,
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () => ARoutes.toRewardDetails(),
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 10, end: 10, top: 30, bottom: 10),
                          // color: Colors.green,
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(bottom: 5),
                                child: Image.asset(Assets.iconAddInviteFriend,
                                    width: 48,
                                    height: 48,
                                    matchTextDirection: true),
                              ),
                              Text(
                                (logic.data?.inviteCount ?? 0).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: const Color(0xFFFF4864),
                                    fontSize: 20,
                                    fontFamily: AppConstants.fontsBold,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(top: 10),
                                child: Text(
                                  Tr.app_invite_num.tr,
                                  style: const TextStyle(
                                      color: Color(0xFF9B989D),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    ],
                  );
                },
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
                    top: 5, start: 15, end: 15),
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
        GetBuilder<ShareLogic>(
          assignId: true,
          init: ShareLogic(),
          builder: (logic) {
            return InkWell(
              child: Container(
                height: 60,
                margin: const EdgeInsetsDirectional.only(
                    top: 10, start: 15, end: 15, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(12)),
                child: _myInviteCode(logic.data?.inviteCode ?? "--", logic),
              ),
              onTap: () => logic.copyId(),
            );
          },
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
            child: Text(
              Tr.app_reward_tip.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: Text(
              Tr.app_reward_content1.trArgs([inviteAward]),
              style: const TextStyle(color: Color(0xFFA78068), fontSize: 14),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Text(
              Tr.app_reward_content2.trArgs([rechargeAward]),
              style: const TextStyle(color: Color(0xFFA78068), fontSize: 14),
            ),
          ),
          if (AppConstants.isFakeMode == false)
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Text(
                Tr.app_reward_content3.trArgs([inviteeCardCount]),
                style: const TextStyle(color: Color(0xFFA78068), fontSize: 14),
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
        height: 76,
        //margin: const EdgeInsetsDirectional.symmetric(horizontal: 45),
        alignment: Alignment.center,
        padding:
            const EdgeInsetsDirectional.only(bottom: 10, start: 10, end: 10),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: ExactAssetImage(Assets.iconInviteBtn)),
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
      margin: const EdgeInsets.only(top: 0, left: 15, right: 5),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Tr.app_my_invite_code.trArgs([":"]),
            style: const TextStyle(
                color: Color(0xFF6A4B39),
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(code,
              style: TextStyle(
                  color: const Color(0xFFFF4864),
                  fontSize: 16,
                  fontFamily: AppConstants.fontsRegular,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          const VerticalDivider(
            width: 1,
            color: Color(0xFFEEEEEE),
            indent: 12,
            endIndent: 12,
          ),
          Container(
            height: double.maxFinite,
            alignment: AlignmentDirectional.center,
            constraints: const BoxConstraints(maxWidth: 80),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
            margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 5, vertical: 5),
            child: Text(
              copy,
              style: const TextStyle(
                  color: Color(0xFF9341FF),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
