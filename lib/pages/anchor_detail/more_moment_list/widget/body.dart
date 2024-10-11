import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_moment_entity.dart';
import 'package:oliapro/pages/anchor_detail/more_moment_list/index.dart';
import 'package:oliapro/pages/anchor_detail/more_moment_list/widget/build_report.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/pages/widget/like_btn.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/app_extends.dart';

class MoreDynamicBody extends StatelessWidget {
  const MoreDynamicBody({super.key});

  @override
  Widget build(BuildContext context) {
    //return _item(DynamicLogic(), LinkContent(), 0);
    return GetBuilder<MoreDynamicLogic>(
        assignId: true,
        init: MoreDynamicLogic(),
        builder: (logic) {
          return logic.moments.isNotEmpty
              ? buildList(logic)
              : const BaseEmpty();
        });
  }

  Widget buildList(MoreDynamicLogic logic) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 14, bottom: 0),
      itemCount: logic.moments.length,
      itemBuilder: (context, index) =>
          _item(logic, logic.moments[index], index),
    );
  }

  Widget _item(MoreDynamicLogic logic, MomentDetail item, int index) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 10),
            child: Text(
              item.dynamicStartTime,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(20)),
            padding: const EdgeInsetsDirectional.only(
                start: 15, end: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.content != null)
                  Container(
                    margin:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 10),
                    child: Text(
                      item.content ?? '--',
                      softWrap: true,
                      style: const TextStyle(
                          color: Color(0xFF4E5358),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                if ((item.pathArray ?? []).isNotEmpty) _showImg(item),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 15),
                  child: Row(
                    children: [
                      const Spacer(),
                      BuildMoreReport(item),
                      const SizedBox(
                        width: 12,
                      ),
                      LikeBtn(item),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gridViewImg(List<String> medias, MomentDetail item) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      alignment: Alignment.topCenter,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: medias.length,
          padding: const EdgeInsets.only(top: 0),
          itemBuilder: (context, index) {
            return medias[index] == "null"
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: () =>
                        ARoutes.toMomentDetail(data: item, index: index),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: cachedImage(medias[index]),
                    ),
                  );
          }),
    );
  }

  Widget gridViewImg2(List<String> medias, MomentDetail item) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      alignment: Alignment.topCenter,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: medias.length,
          padding: const EdgeInsetsDirectional.only(end: 60),
          itemBuilder: (context, index) {
            return medias[index] == "null"
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: () =>
                        ARoutes.toMomentDetail(data: item, index: index),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: cachedImage(medias[index]),
                    ),
                  );
          }),
    );
  }

  Widget _bigImg(MomentDetail item) {
    //debugPrint("_bigImg ===>>> $url");
    return item.pathArray[0] == "null"
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () => ARoutes.toMomentDetail(data: item),
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(top: 0),
              alignment: AlignmentDirectional.centerStart,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: cachedImage(item.pathArray[0], width: 189, height: 189),
              ),
            ),
          );
  }

  Widget _showImg(MomentDetail item) {
    switch (item.pathArray.length) {
      case 1:
        return _bigImg(item);
      case 2:
      case 4:
        return gridViewImg2(item.pathArray, item);
      case 3:
      case 6:
        return gridViewImg(item.pathArray, item);
      default:
        return gridViewImg(item.pathArray, item);
    }
  }
}
