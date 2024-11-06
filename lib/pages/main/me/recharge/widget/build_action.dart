import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/recharge/index.dart';

class BuildAction extends StatelessWidget {
  final RechargeLogic logic;

  const BuildAction(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: actionWidget(logic),
    );
  }

  Widget actionWidget(RechargeLogic logic) => !AppConstants.isFakeMode
      ? Container(
          margin: const EdgeInsetsDirectional.only(end: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            //behavior: HitTestBehavior.translucent,
            onTap: () => logic.pushOrderList(),
            child: Container(
              padding: const EdgeInsetsDirectional.all(5),
              child: Image.asset(
                Assets.iconOrderList,
                matchTextDirection: true,
                width: 24,
                height: 24,
              ),
            ),
          ),
        )
      : const SizedBox.shrink();
}
