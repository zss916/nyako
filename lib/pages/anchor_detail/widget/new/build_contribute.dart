import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_contribute_entity.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildContribute extends StatelessWidget {
  final List<ContributeEntity> contributions;
  final String anchorId;
  final HostDetail host;

  const BuildContribute(
      {Key? key,
      required this.contributions,
      required this.anchorId,
      required this.host})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ARoutes.toContributeList(anchorId: anchorId, host: host),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            height: 60,
            width: double.maxFinite,
            margin: const EdgeInsetsDirectional.only(top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(12),
                gradient: const LinearGradient(
                    colors: [Color(0xFFFFE0D4), Color(0xFFFFF4C0)])),
            child: Row(
              children: [
                Container(
                  margin:
                      const EdgeInsetsDirectional.only(bottom: 17, start: 47),
                  child: Image.asset(Assets.iconN1N3, width: 144, height: 43),
                ),
                const Spacer(),
                // if (widget.logic.state.contributions.isNotEmpty)
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    (contributions.length >= 3)
                        ? Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsetsDirectional.only(start: 48),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.transparent),
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        contributions[2].showPortrait))),
                            foregroundDecoration: const BoxDecoration(
                                image: DecorationImage(
                                    matchTextDirection: true,
                                    image: ExactAssetImage(Assets.iconN3))),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsetsDirectional.only(start: 48),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.transparent),
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: ExactAssetImage(
                                        Assets.iconSortAvatar))),
                            foregroundDecoration: const BoxDecoration(
                                image: DecorationImage(
                                    matchTextDirection: true,
                                    image: ExactAssetImage(Assets.iconN1))),
                          ),
                    (contributions.length >= 2)
                        ? Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsetsDirectional.only(start: 24),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.transparent),
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        contributions[1].showPortrait))),
                            foregroundDecoration: const BoxDecoration(
                                image: DecorationImage(
                                    matchTextDirection: true,
                                    image: ExactAssetImage(Assets.iconN2))),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsetsDirectional.only(start: 24),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.transparent),
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: ExactAssetImage(
                                        Assets.iconSortAvatar))),
                            foregroundDecoration: const BoxDecoration(
                                image: DecorationImage(
                                    matchTextDirection: true,
                                    image: ExactAssetImage(Assets.iconN1))),
                          ),
                    (contributions.isNotEmpty)
                        ? Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsetsDirectional.only(start: 0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.transparent),
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        contributions[0].showPortrait))),
                            foregroundDecoration: const BoxDecoration(
                                image: DecorationImage(
                                    matchTextDirection: true,
                                    image: ExactAssetImage(Assets.iconN1))),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsetsDirectional.only(start: 0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Colors.transparent),
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: ExactAssetImage(
                                        Assets.iconSortAvatar))),
                            foregroundDecoration: const BoxDecoration(
                                image: DecorationImage(
                                    matchTextDirection: true,
                                    image: ExactAssetImage(Assets.iconN1))),
                          ),
                  ],
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 12),
                  child: Image.asset(
                    Assets.iconNextY,
                    matchTextDirection: true,
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            Assets.iconWeekSort,
            width: 66,
            height: 66,
            matchTextDirection: true,
          )
        ],
      ),
    );
  }
}
