import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/generated/assets.dart';

class SplashBg extends StatefulWidget {
  final Widget? child;

  const SplashBg({
    super.key,
    this.child,
  });

  @override
  State<SplashBg> createState() => _SplashBackgroundState();
}

class _SplashBackgroundState extends State<SplashBg> {
  final ScrollController _controller = ScrollController();
  final picHeight = Get.width * 2.74;

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      _scrollBg();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollBg() {
    _controller.jumpTo(0);
    _controller
        .animateTo(
      picHeight,
      duration: const Duration(seconds: 10),
      curve: Curves.linear,
    )
        .then((value) {
      if (mounted) {
        _scrollBg();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: ListView.builder(
              controller: _controller,
              itemCount: 3,
              itemExtent: picHeight,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Assets.imgSplashBg,
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
        ),
        Positioned.fill(child: widget.child ?? const SizedBox.shrink())
      ],
    );
  }
}
