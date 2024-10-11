import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/utils/app_voice_player.dart';

class BuildRechargeTip extends StatelessWidget {
  final ChatLogic logic;
  const BuildRechargeTip(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(
              top: 7, bottom: 7, start: 5, end: 10),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: AlignmentDirectional.bottomStart,
                  end: AlignmentDirectional.topEnd,
                  colors: [
                    Color(0xFF8940FF),
                    Color(0xFFD34BFD),
                  ]),
              borderRadius: BorderRadiusDirectional.circular(0)),
          child: InkWell(
            onTap: () {
              AppAudioPlayer().stop();
              sheetToVip(
                  path: ChargePath.recharge_vip_dialog_user_center,
                  index: 1,
                  upid: logic.herId);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  child: Image.asset(
                    Assets.animaIconToOpenVip,
                    width: 50,
                    height: 50,
                    matchTextDirection: true,
                  ),
                ),
                Expanded(
                    child: Text(
                  Tr.app_vip_send_msg_tip.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    height: 1.3,
                  ),
                )),
                Image.asset(
                  Assets.imgVipRechargeBtn,
                  width: 50,
                  height: 36,
                  matchTextDirection: true,
                )
              ],
            ),
          ),
        ),
        PositionedDirectional(
            top: 0,
            start: 0,
            child: InkWell(
              onTap: () {
                logic.showFreeMsgView = false;
                logic.update();
              },
              child: Container(
                padding: const EdgeInsetsDirectional.only(bottom: 20, end: 20),
                color: Colors.transparent,
                child: Image.asset(
                  Assets.imgIconCloseToOpenVip,
                  width: 24,
                  height: 24,
                  matchTextDirection: true,
                ),
              ),
            ))
      ],
    );
  }
}
