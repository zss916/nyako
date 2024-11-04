import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/dialogs/sheet_report.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/discover/widget/discover/follow.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_event_bus.dart';

class BuildFront extends StatelessWidget {
  final HostDetail data;
  final String? index;

  const BuildFront(this.data, {super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            /*Container(
              width: 30,
              height: 30,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsetsDirectional.all(3),
              margin: const EdgeInsetsDirectional.only(top: 12, start: 12),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xFF4CE263)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: cachedNetImage(data.showPortrait),
              ),
            ),*/
            const Spacer(),
            GestureDetector(
              onTap: () {
                /*ARoutes.toReport(
                    uid: data.getUid,
                    type: ReportEnum.discover.index.toString(),
                    mid: index);*/
                StorageService.to.eventBus.fire('pauseDiscover');
                showReportSheet(data.getUid, close: () {
                  StorageService.to.updateBlackList(data.getUid, true);
                  AppEventBus.eventBus.fire(BlackEvent(uid: data.getUid));
                  StorageService.to.updateMediaReportList(index);
                  AppEventBus.eventBus.fire(ReportEvent(
                      ReportEnum.discover.index,
                      discoverIndex: index));
                });

                // showReportSheet(anchorId);
              },
              child: Container(
                // color: Colors.red,
                margin: const EdgeInsetsDirectional.only(top: 12, end: 12),
                child: Image.asset(
                  Assets.iconCallReport,
                  width: 36,
                  height: 36,
                  matchTextDirection: true,
                ),
              ),
            )
          ],
        ),
        const Spacer(),
        InkWell(
          //behavior: HitTestBehavior.translucent,
          onTap: () {
            StorageService.to.eventBus.fire('pauseDiscover');
            ARoutes.toAnchorDetail(data.getUid);
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xB3000000),
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(24),
                    topStart: Radius.circular(24))),
            padding: const EdgeInsetsDirectional.only(
                bottom: 5, top: 13, start: 16, end: 16),
            child: Row(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 180),
                        child: AutoSizeText(
                          data.showNickName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 30,
                          minFontSize: 15,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      /*Text(
                        "ID:${data.getUid}",
                        style: const TextStyle(
                            color: Color(0x99FFFFFF), fontSize: 15),
                      )*/
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 8),
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 4, vertical: 3),
                            decoration: BoxDecoration(
                                color: const Color(0x1AFF3881),
                                borderRadius:
                                    BorderRadiusDirectional.circular(5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Assets.iconSmallWoman,
                                  width: 14,
                                  height: 14,
                                  matchTextDirection: true,
                                ),
                                Text(
                                  data.showBirthday,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: AppConstants.fontsRegular,
                                      color: const Color(0xFFFF3881)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 4, vertical: 3),
                            decoration: BoxDecoration(
                                color: const Color(0x1A3BC2FF),
                                borderRadius:
                                    BorderRadiusDirectional.circular(5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Assets.iconIdSmallIcon,
                                  width: 14,
                                  height: 14,
                                  matchTextDirection: true,
                                ),
                                Text(
                                  data.getUid,
                                  style: TextStyle(
                                      color: const Color(0xFF3BC2FF),
                                      fontFamily: AppConstants.fontsRegular,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ]),
                const Spacer(),
                Follow(data),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(13),
                      color: const Color(0x26FFFFFF)),
                  width: 57,
                  height: 36,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
