import 'package:flutter/material.dart';

class BuildPopScope extends StatefulWidget {
  final Widget? child;

  const BuildPopScope({super.key, this.child});

  @override
  State<BuildPopScope> createState() => _BuildPopScopeState();
}

class _BuildPopScopeState extends State<BuildPopScope> {
  late int lastClickTime = 0;
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (bool didPop, _) {
        int nowTime = DateTime.now().millisecondsSinceEpoch;
        if (nowTime - lastClickTime < 800 && lastClickTime != 0) {
          if (mounted) {
            setState(() {
              canPop = true;
            });
          }
          return;
        }
        lastClickTime = nowTime;
        if (mounted) {
          setState(() {
            canPop = false;
          });
        }
      },
      child: widget.child!,
    );
  }
}
