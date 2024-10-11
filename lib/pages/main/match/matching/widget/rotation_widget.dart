import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class RotationWidget extends StatefulWidget {
  const RotationWidget({Key? key}) : super(key: key);

  @override
  _RotationWidgetState createState() => _RotationWidgetState();
}

class _RotationWidgetState extends State<RotationWidget>
    with TickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(duration: const Duration(seconds: 6), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _ctrl,
      child: Image.asset(
        Assets.iconScan,
        width: 280,
        height: 280,
        matchTextDirection: true,
      ),
    );
  }
}
