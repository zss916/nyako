import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_contribute_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/new/sort_avatar.dart';
import 'package:oliapro/routes/a_routes.dart';

class SortList extends StatelessWidget {
  final List<ContributeEntity> contributions;
  final AnchorDetailLogic logic;

  final double? margin;

  const SortList(this.contributions, this.logic, {super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ARoutes.toContributeList(
            anchorId: logic.state.anchorId.toString(), host: logic.state.host);
      },
      child: Container(
        height: 64,
        width: double.maxFinite,
        margin: EdgeInsetsDirectional.only(
            start: margin ?? 12, end: margin ?? 12, bottom: 0, top: 10),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                matchTextDirection: true,
                image: ExactAssetImage(Assets.imgSortListBg))),
        child: Row(
          children: [
            const Spacer(),
            Container(
                margin: const EdgeInsetsDirectional.only(start: 5),
                height: double.maxFinite,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return SortAvatar(
                        (index) < contributions.length
                            ? contributions[index].showPortrait
                            : "--",
                        index);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 5,
                  ),
                  itemCount: 3,
                )),
            Image.asset(
              Assets.imgArrowEnd,
              width: 20,
              height: 20,
              matchTextDirection: true,
            )
          ],
        ),
      ),
    );
  }
}
