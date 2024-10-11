import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_link_content_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/blacklist/utils/state.dart';
import 'package:oliapro/pages/main/me/moment_list/index.dart';
import 'package:oliapro/pages/widget/app_preview.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/pages/widget/circular_progress.dart';
import 'package:oliapro/utils/app_extends.dart';

class DynamicBody extends StatelessWidget {
  const DynamicBody({super.key});

  @override
  Widget build(BuildContext context) {
    //return _item(DynamicLogic(), LinkContent(), 0);
    return GetBuilder<DynamicLogic>(
        assignId: true,
        init: DynamicLogic(),
        builder: (logic) {
          return buildContent(logic.state, logic);
        });
  }

  Widget buildContent(int state, DynamicLogic logic) {
    return switch (state) {
      _ when state == Status.EMPTY.index => buildEmpty(logic),
      _ when state == Status.DATA.index => Container(
          margin: const EdgeInsetsDirectional.only(top: 90),
          child: buildList(logic),
        ),
      _ => const CircularProgress(),
    };
  }

  Widget buildEmpty(DynamicLogic logic) => GestureDetector(
        onTap: () => logic.loadDta(),
        child: const BaseEmpty(),
      );

  Widget buildList(DynamicLogic logic) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 0),
      itemCount: logic.list.length,
      itemBuilder: (context, index) => _item(logic, logic.list[index], index),
    );
  }

  Widget _item(DynamicLogic logic, LinkContent item, int index) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [Color(0xFFFFD6E3), Color(0x33FFD6E3)]),
          borderRadius: BorderRadiusDirectional.circular(16)),
      padding: const EdgeInsetsDirectional.only(
          top: 12, start: 12, end: 12, bottom: 0),
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 10),
            child: Text(
              item.dynamicTime,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.transparent,
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
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                if ((item.pathArray ?? []).isNotEmpty) _showImg(item),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 15),
                  child: Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () =>
                            logic.showRemoveDialog(item.rid.toString(), index),
                        child: Image.asset(
                          Assets.imgCloseDialog,
                          width: 22,
                          height: 22,
                          matchTextDirection: true,
                        ),
                      ),
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

  Widget gridViewImg(List<String> medias) {
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
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: medias[index] == "null"
                  ? const SizedBox.shrink()
                  : cachedImage(medias[index]),
            );
          }),
    );
  }

  Widget gridViewImg2(List<String> medias) {
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
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: medias[index] == "null"
                  ? const SizedBox.shrink()
                  : cachedImage(medias[index]),
            );
          }),
    );
  }

  Widget _bigImg(LinkContent item) {
    //debugPrint("_bigImg ===>>> $url");
    return item.showArray[0] == "null"
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () {
              showPreview(item.pathArray,
                  initIndex: 0, uid: item.userId ?? "", type: 0);
            },
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(top: 0),
              alignment: AlignmentDirectional.centerStart,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: cachedImage(item.showArray[0], width: 185, height: 248),
              ),
            ),
          );
  }

  Widget _showImg(LinkContent item) {
    switch (item.showArray.length) {
      case 1:
        return _bigImg(item);
      case 2:
      case 4:
        return gridViewImg2(item.showArray);
      case 3:
      case 6:
        return gridViewImg(item.showArray);
      default:
        return gridViewImg(item.showArray);
    }
  }
}
