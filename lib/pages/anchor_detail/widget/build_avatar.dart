import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/anchor_detail/index.dart';
import 'package:nyako/utils/app_extends.dart';

class BuildAvatar extends StatelessWidget {
  final AnchorDetailLogic logic;
  const BuildAvatar(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(30),
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage(Assets.iconAnchorDefault)),
          border: Border.all(width: 0, color: Colors.transparent)),
      margin: const EdgeInsetsDirectional.only(start: 37),
      child: ClipRRect(
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(30)),
        child: cachedImage(logic.state.portrait, width: 30, height: 30),
      ),
    );
  }
}
