import 'package:flutter/material.dart';
import 'package:nyako/dialogs/dialog_confirm_black.dart';
import 'package:nyako/dialogs/sheet_chat_more.dart';
import 'package:nyako/dialogs/sheet_report.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/chat/index.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_voice_player.dart';

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
              report: () =>
                  showReportSheet(logic.herDetail?.getUid ?? "", close: () {
                    StorageService.to
                        .updateBlackList(logic.herDetail?.getUid ?? "", true);
                    AppEventBus.eventBus
                        .fire(BlackEvent(uid: logic.herDetail?.getUid ?? ""));
                    AppEventBus.eventBus
                        .fire(ReportEvent(ReportEnum.chat.index));
                  }),
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
            Assets.iconMoreB,
            matchTextDirection: true,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
