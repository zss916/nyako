import 'package:flutter/material.dart';

///按钮缩放动画
class BuildScaleTransition extends StatefulWidget {
  final Widget child;

  const BuildScaleTransition({super.key, required this.child});

  @override
  State<BuildScaleTransition> createState() => _BuildScaleTransitionState();
}

class _BuildScaleTransitionState extends State<BuildScaleTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleAnimationController;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    scale = Tween(begin: 0.8, end: 1.0).animate(
      _scaleAnimationController,
    );
    _scaleAnimationController.repeat(reverse: true);
    _scaleAnimationController.drive(
      CurveTween(curve: Curves.easeInToLinear),
    );
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ScaleTransition(
        scale: scale,
        child: widget.child,
      ),
    );
  }
}
