import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/storage_service.dart';

class BuildCallButton extends StatelessWidget {
  final HostDetail anchor;

  final double _scale = 0.9;

  const BuildCallButton(this.anchor, {super.key});

  @override
  Widget build(BuildContext context) {
    return (anchor.isChat && (!AppConstants.isFakeMode))
        ? InkWell(
            onTap: () {
              StorageService.to.eventBus.fire('pauseDiscover');
              ARoutes.toLocalCall(anchor.getUid, anchor.showPortrait);
            },
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      stops: [
                        0.2,
                        1
                      ],
                      colors: [
                        Color(0xFFAC53FB),
                        Color(0xFF7934F0),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(60)),
              child: Center(
                child: RepaintBoundary(
                  child: Image.asset(
                    Assets.animaCall,
                    width: 30,
                    height: 30,
                    matchTextDirection: true,
                  ),
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              StorageService.to.eventBus.fire('pauseDiscover');
              ARoutes.toChatPage(anchor.getUid);
            },
            child: Image.asset(
              Assets.iconToMsgIcon,
              matchTextDirection: true,
              width: 54,
              height: 54,
            ),
          );
  }
}
