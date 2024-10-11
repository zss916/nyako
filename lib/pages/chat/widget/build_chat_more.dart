import 'package:flutter/material.dart';
import 'package:oliapro/dialogs/dialog_confirm_black.dart';
import 'package:oliapro/dialogs/sheet_chat_more.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_voice_player.dart';

class BuildChatMore extends StatelessWidget {
  final ChatLogic logic;
  const BuildChatMore(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          AppAudioPlayer().stop();
          showChatMore(
              report: () => ARoutes.toReport(
                    uid: logic.herDetail?.getUid,
                    type: ReportEnum.chat.index.toString(),
                  ),
              black: () {
                if (logic.herDetail == null) return;
                showBlackDialog(
                    host: logic.herDetail,
                    callback: (i) {
                      logic.handleBlack();
                    });
              },
              clean: () {
                StorageService.to.objectBoxMsg.removeHer(logic.herId);
              },
              follow: () => logic.handleFollow(),
              isToFollow: (logic.herDetail?.isFollowed != true),
              h: 280);
        },
        child: Container(
          padding: const EdgeInsetsDirectional.all(5),
          child: Image.asset(
            Assets.imgMore,
            matchTextDirection: true,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
