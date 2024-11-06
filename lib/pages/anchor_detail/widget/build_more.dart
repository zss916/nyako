import 'package:flutter/material.dart';
import 'package:nyako/dialogs/dialog_confirm_black.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/anchor_detail/index.dart';

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
          Assets.iconBlackIcon,
          matchTextDirection: true,
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
