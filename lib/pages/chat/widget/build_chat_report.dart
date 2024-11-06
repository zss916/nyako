import 'package:flutter/material.dart';
import 'package:nyako/dialogs/sheet_report.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_event_bus.dart';

class BuildChatReport extends StatelessWidget {
  final String? img;
  final String anchorId;
  final bool isBlack;
  final String? type;

  const BuildChatReport(this.anchorId,
      {super.key, this.img, required this.isBlack, this.type});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => showReportSheet(anchorId, close: () {
          StorageService.to.updateBlackList(anchorId, true);
          AppEventBus.eventBus.fire(BlackEvent(uid: anchorId));
          AppEventBus.eventBus.fire(ReportEvent(ReportEnum.chat.index));
        }),
        // onTap: () => ARoutes.toReport(uid: anchorId, type: type),
        child: Container(
          padding: const EdgeInsetsDirectional.all(5),
          child: Image.asset(
            Assets.iconReportIconB,
            matchTextDirection: true,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
