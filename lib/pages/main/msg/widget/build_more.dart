import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/msg/index.dart';

class BuildMore extends StatelessWidget {
  final MsgListLogic logic;

  const BuildMore(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return _moreAction(logic);
  }

  Widget _moreAction(MsgListLogic logic) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => logic.showMore(),
        child: Container(
          padding: const EdgeInsetsDirectional.all(5),
          child: Image.asset(
            Assets.iconMore,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
