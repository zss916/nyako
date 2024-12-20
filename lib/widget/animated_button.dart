import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Widget? child;
  final Function? onCall;

  final bool? isAnimate;

  const AnimatedButton(
      {super.key, this.child, this.isAnimate = false, this.onCall});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse().whenComplete(() {
      widget.onCall?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return widget.isAnimate == false
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              widget.onCall?.call();
            },
            child: widget.child,
          )
        : GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Transform.scale(
              scale: _scale,
              child: widget.child,
            ),
          );
  }

  ///example
  Widget get _animatedButtonUI => Container(
        height: 100,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 30.0,
              offset: Offset(0.0, 30.0),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA7BFE8),
              Color(0xFF6190E8),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'tap!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
