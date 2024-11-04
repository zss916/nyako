import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/sign_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/widget/base_button3.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';

void showSignReward(SignBean data) {
  Get.dialog(
    SignReward(data),
    routeSettings: const RouteSettings(name: AppPages.signRewardDialog),
  );
}

class SignReward extends StatelessWidget {
  final SignBean data;

  const SignReward(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      stops: [0, 0.9],
                      begin: AlignmentDirectional.topEnd,
                      end: AlignmentDirectional.bottomStart,
                      colors: [
                        Color(0xFFFFFBC1),
                        Color(0xFFFFFFFD),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              padding: const EdgeInsetsDirectional.only(top: 60, bottom: 20),
              margin:
                  const EdgeInsetsDirectional.only(start: 30, end: 30, top: 60),
              width: 315,
              // constraints: const BoxConstraints(minHeight: 285),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        Tr.appCgGain.trArgs([data.showName()]),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(
                        Tr.appSignRewardTip.trArgs([Tr.app_prop_package.tr]),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // if (data.isVip == 1 && ((data.vipDiamonds ?? 0) > 0))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "+${data.vipDiamonds ?? 0}",
                        style: TextStyle(
                            color: const Color(0xFF9341FF),
                            fontSize: 24,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 2),
                        child: Image.asset(
                          Assets.iconDiamond,
                          width: 25,
                          height: 25,
                          matchTextDirection: true,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(closeOverlays: true);
                      if (data.type == 8) {
                        ARoutes.toLottery();
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 52,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          color: const Color(0xFF9341FF),
                          borderRadius: BorderRadiusDirectional.circular(30)),
                      margin: const EdgeInsetsDirectional.only(
                          bottom: 5, top: 5, start: 30, end: 30),
                      child: Text(
                        data.type == 8
                            ? Tr.app_lottery.tr
                            : Tr.app_base_confirm.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              Assets.signNyakoSucceeful,
              matchTextDirection: true,
              width: 114,
              height: 114,
            )
          ],
        )
      ],
    );
  }

  Widget oooddd() {
    return Container(
      width: 305,
      constraints: const BoxConstraints(minHeight: 402),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 5),
            child: Image.asset(
              data.showIcon(),
              width: 150,
              height: 150,
              matchTextDirection: true,
            ),
          ),
          Text(
            Tr.app_congratulations_get.tr,
            style: const TextStyle(
                color: Color(0xFF6F3507),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.maxFinite,
            alignment: AlignmentDirectional.center,
            constraints: const BoxConstraints(minHeight: 64),
            padding: const EdgeInsetsDirectional.all(10),
            margin:
                const EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
            decoration: BoxDecoration(
                color: const Color(0xFFFCF4EC),
                borderRadius: BorderRadiusDirectional.circular(14)),
            child: content(type: data.type ?? 0, value: data.value),
          ),
          if (data.isVip == 1 && ((data.vipDiamonds ?? 0) > 0))
            Wrap(
              children: [
                Text(
                  "+${data.vipDiamonds ?? 0}",
                  style: TextStyle(
                      color: const Color(0xFF6F3507),
                      fontSize: 16,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.w500),
                ),
                Image.asset(
                  Assets.iconDiamond,
                  width: 17,
                  height: 17,
                  matchTextDirection: true,
                )
              ],
            ),
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 20, top: 20),
            child: Text(
              Tr.appSignRewardTip.trArgs([
                data.type == 8 ? Tr.app_lottery.tr : Tr.app_prop_package.tr
              ]),
              style: const TextStyle(color: Color(0xFF6F3507), fontSize: 13),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
              if (data.type == 8) {
                ARoutes.toLottery();
              }
            },
            child: BaseButton3(
                data.type == 8 ? Tr.app_to_lottery.tr : Tr.app_base_confirm.tr),
          ),
          if (data.type == 8)
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 5, top: 5),
              child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    Tr.app_base_confirm.tr,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
            )
        ],
      ),
    );
  }

  Widget content({required int type, int? value}) {
    List<String> callCards = Tr.app_dialog_call_experience_card.tr.split("x%s");
    List<String> msgCards = Tr.appSignMsgCard.tr.split("%s");
    List<String> turns = Tr.appSignDraw.tr.split("%s");
    List<String> diamondAddCards = Tr.app_prop_add_title.tr.split("%s");
    return switch (type) {
      _ when type == 3 =>
        richTextWidget(callCards.first, callCards.last, "x${value ?? 1}"),
      _ when type == 7 =>
        richTextWidget(msgCards.first, msgCards.last, "${value ?? 1}"),
      _ when type == 8 =>
        richTextWidget(turns.first, turns.last, "${value ?? 1}"),
      _ when type == 9 => richTextWidget(
          diamondAddCards.first, diamondAddCards.last, "${value ?? 0}"),
      _ => Text(
          data.showName(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color(0xFF6F3507),
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
    };
  }

  Widget richTextWidget(String start, String end, String center) {
    return Text.rich(TextSpan(
        style: const TextStyle(
            color: Color(0xFF6F3507),
            fontSize: 16,
            fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: start,
            style: const TextStyle(
                color: Color(0xFF6F3507),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: center,
            style: const TextStyle(
                color: Color(0xFFFF1818),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: end,
            style: const TextStyle(
                color: Color(0xFF6F3507),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ]));
  }
}
