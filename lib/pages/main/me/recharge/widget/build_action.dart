import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';

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
                Assets.imgShareSet,
                matchTextDirection: true,
                width: 24,
                height: 24,
              ),
            ),
          ),
        )
      : const SizedBox.shrink();
}
