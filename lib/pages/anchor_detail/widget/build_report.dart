import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildReport extends StatelessWidget {
  final String? img;
  final String anchorId;

  final String? type;

  const BuildReport(this.anchorId, {super.key, this.img, this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => ARoutes.toReport(uid: anchorId, type: type),
      child: Container(
        height: 38,
        width: 38,
        //color: Colors.red,
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsetsDirectional.all(0),
        child: Image.asset(
          Assets.iconReportIcon,
          matchTextDirection: true,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
