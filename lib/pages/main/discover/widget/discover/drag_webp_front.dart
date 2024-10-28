import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/services/storage_service.dart';

class DragWebpFront extends StatefulWidget {
  final Widget child;
  const DragWebpFront({super.key, required this.child});

  @override
  State<DragWebpFront> createState() => _DragWebpState();
}

class _DragWebpState extends State<DragWebpFront> {
  bool? hadShowDrag;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    hadShowDrag =
        StorageService.to.prefs.getBool(AppConstants.hadShowMatchDragTip);
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (hadShowDrag != true) {
        setState(() {
          hadShowDrag = true;
          StorageService.to.prefs
              .setBool(AppConstants.hadShowMatchDragTip, true);
          if (_timer != null) {
            _timer?.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        widget.child,
        if (hadShowDrag != true)
          IgnorePointer(
            child: Container(
              padding: const EdgeInsetsDirectional.only(start: 40),
              color: Colors.black45,
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Lottie.asset(
                  Assets.jsonAnimaDrag,
                  height: 190,
                  width: 170,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
