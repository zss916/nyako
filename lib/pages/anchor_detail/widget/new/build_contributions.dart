import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_contribute_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildContributions extends StatelessWidget {
  final List<ContributeEntity> contributions;

  const BuildContributions(this.contributions, {super.key});
  //String sortTitle = LanguageKey.app_ranking.tr;
  //String contributeTitle = LanguageKey.app_contribution.tr;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsetsDirectional.only(start: 0, end: 0, bottom: 80),
      itemCount: contributions.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: buildItem(index, contributions[index]),
        );
      },
    );
  }

  Widget buildItem(int index, ContributeEntity data) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        children: [
          Text(
            "${index + 1}.",
            style: TextStyle(
                color: getIndexColor(index),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: 30,
            height: 30,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: getIndexColor(index)),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: cachedImage(data.portrait ?? ""),
            ),
          ),
          Expanded(
            child: Text(
              data.showNickName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 3, right: 3),
            child: Image.asset(
              Assets.imgAppLogo,
              width: 14,
              height: 14,
              matchTextDirection: true,
            ),
          ),
          Text(
            (data.amount ?? 0).toString(),
            style: const TextStyle(
                color: Color(0xFFFF8806),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Color getIndexColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFF890E);
      case 1:
        return const Color(0xFF3FCDFF);
      case 2:
        return const Color(0xFFFF2A48);
      default:
        return const Color(0xFFBAAEB7);
    }
  }
}
