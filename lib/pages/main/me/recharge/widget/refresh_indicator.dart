import 'package:flutter/material.dart';
import 'package:nyako/pages/main/me/recharge/index.dart';

class Refresh extends StatelessWidget {
  final bool isRefresh;
  final Widget child;
  final RechargeLogic logic;

  const Refresh(
      {super.key,
      required this.isRefresh,
      required this.child,
      required this.logic});

  @override
  Widget build(BuildContext context) {
    return isRefresh
        ? RefreshIndicator(
            color: Colors.deepPurple,
            onRefresh: () => refresh(logic),
            child: child,
          )
        : child;
  }

  Future<void> refresh(RechargeLogic logic) async {
    logic.loadPayList();
    await Future.delayed(const Duration(seconds: 1));
  }
}
