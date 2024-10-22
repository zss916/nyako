import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildChatReport extends StatelessWidget {
  final String? img;
  final String anchorId;
  final bool isBlack;
  final String? type;

  const BuildChatReport(this.anchorId,
      {super.key, this.img, required this.isBlack, this.type});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => ARoutes.toReport(uid: anchorId, type: type),
        child: Container(
          padding: const EdgeInsetsDirectional.all(5),
          child: Image.asset(
            Assets.iconReportIconB,
            matchTextDirection: true,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
