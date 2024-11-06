import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nyako/generated/assets.dart';

class DragWebp extends StatefulWidget {
  final Widget child;
  const DragWebp({super.key, required this.child});

  @override
  State<DragWebp> createState() => _DragWebpState();
}

class _DragWebpState extends State<DragWebp> {
  bool hadShowDrag = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    hadShowDrag = true;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        hadShowDrag = false;
        if (_timer != null) {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          widget.child,
          if (hadShowDrag)
            IgnorePointer(
              child: Container(
                padding: const EdgeInsetsDirectional.only(bottom: 50),
                color: Colors.black45,
                height: double.infinity,
                width: double.infinity,
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Lottie.asset(
                    Assets.jsonAnimaDrag,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
