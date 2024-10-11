import 'package:flutter/material.dart';
import 'package:oliapro/dialogs/dialog_confirm_black.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/black.dart';

class BuildBlack extends StatelessWidget {
  final AnchorDetailLogic logic;
  const BuildBlack(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBlackDialog(
            host: logic.state.host,
            callback: (i) {
              logic.handleBlack();
            });
      },
      child: const Black(),
    );
  }
}
