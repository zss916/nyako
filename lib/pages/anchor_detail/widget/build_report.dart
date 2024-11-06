import 'package:flutter/material.dart';
import 'package:nyako/dialogs/sheet_report.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_event_bus.dart';

class BuildReport extends StatelessWidget {
  final String? img;
  final String anchorId;

  final String? type;

  const BuildReport(this.anchorId, {super.key, this.img, this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => showReportSheet(anchorId, close: () {
        StorageService.to.updateBlackList(anchorId, true);
        AppEventBus.eventBus.fire(BlackEvent(uid: anchorId));
        AppEventBus.eventBus.fire(ReportEvent(ReportEnum.anchorDetail.index));
      }),
      // onTap: () => ARoutes.toReport(uid: anchorId, type: type),
      child: Container(
        height: 38,
        width: 38,
        //color: Colors.red,
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsetsDirectional.all(0),
        child: Image.asset(
          Assets.iconReportIcon,
          matchTextDirection: true,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
