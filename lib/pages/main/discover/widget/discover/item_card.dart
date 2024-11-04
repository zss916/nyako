import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/discover/widget/discover/better_net_video.dart';
import 'package:oliapro/pages/main/discover/widget/discover/build_front.dart';
import 'package:oliapro/utils/app_extends.dart';

class ItemCard extends StatelessWidget {
  final HostDetail data;
  final int index;
  final bool isShow;
  const ItemCard(this.data, this.index, this.isShow, {super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint("ItemCard====>>>> ${data.showNickName}");
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 60, top: 20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.cover,
            matchTextDirection: true,
            image: ExactAssetImage(Assets.iconAnchorDefault)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: (isShow)
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0, color: Colors.transparent),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      data.showPortrait,
                    ),
                    fit: BoxFit.cover),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
        child: Stack(
          children: [
            if (isShow && !AppConstants.isFakeMode)
              Positioned.fill(child: video(data.showVideo, index, isShow)),
            if (isShow)
              BuildFront(
                data,
                index: index.toString(),
              ),
          ],
        ),
      ),
    );
  }

  Widget video(String path, int index, bool isShow) {
    //debugPrint("=====>>>>${path}" ) BetterNetVideo;
    return Container(
      key: ValueKey("video$path"),
      foregroundDecoration: (isShow)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              gradient: foregroundBoxDecoration3)
          : const BoxDecoration(),
      child: BetterNetVideo(path, double.maxFinite, double.maxFinite),
    );
    // child: NetVideo(path , double.maxFinite, double.maxFinite),);
  }
}
