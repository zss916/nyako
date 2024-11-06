import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/msg/index.dart';

class BuildMore extends StatelessWidget {
  final MsgListLogic logic;

  const BuildMore(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return _moreAction(logic);
  }

  Widget _moreAction(MsgListLogic logic) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => logic.showMore(),
        child: Container(
          padding: const EdgeInsetsDirectional.all(0),
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
