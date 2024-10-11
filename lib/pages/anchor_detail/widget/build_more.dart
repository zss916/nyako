import 'package:flutter/material.dart';
import 'package:oliapro/dialogs/dialog_confirm_black.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';

class BuildMore extends StatelessWidget {
  final AnchorDetailLogic logic;

  const BuildMore(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        showBlackDialog(
            host: logic.state.host,
            callback: (i) {
              logic.handleBlack();
            });
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(5),
        child: Image.asset(
          Assets.imgBlack,
          matchTextDirection: true,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
