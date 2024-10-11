import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => ARoutes.toRewardDetails(),
        child: Container(
          padding: const EdgeInsetsDirectional.all(5),
          child: Image.asset(
            Assets.imgShareSet,
            width: 25,
            height: 25,
            matchTextDirection: true,
          ),
        ),
      ),
    );
  }
}
