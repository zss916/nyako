import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/discover/widget/discover/follow.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_extends.dart';

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
            Container(
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
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                StorageService.to.eventBus.fire('pauseDiscover');
                ARoutes.toReport(
                    uid: data.getUid,
                    type: ReportEnum.discover.index.toString(),
                    mid: index);
              },
              child: Container(
                // color: Colors.red,
                margin: const EdgeInsetsDirectional.only(top: 12, end: 12),
                child: Image.asset(
                  Assets.iconReport,
                  width: 24,
                  height: 24,
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
                color: Colors.black,
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
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "ID:${data.getUid}",
                        style: const TextStyle(
                            color: Color(0x99FFFFFF), fontSize: 15),
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
