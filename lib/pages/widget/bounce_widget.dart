import 'package:flutter/material.dart';

class BounceWidget extends StatefulWidget {
  final Widget child;
  bool? reversal;

   BounceWidget({
    Key? key,
    required this.child,
     this.reversal,
  }) : super(key: key);

  @override
  _BounceWidgetState createState() => _BounceWidgetState();
}

class _BounceWidgetState extends State<BounceWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      reverseDuration: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    animation = Tween<double>(
      begin: widget.reversal == true? 0.9:1.05,
      end: widget.reversal == true? 1.05:0.9,
    ).animate(animController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
