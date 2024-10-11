import 'package:flutter/material.dart';

class BottomArrowWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBack;

  const BottomArrowWidget({super.key, required this.child, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            onBack?.call();
          },
          child: const SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
          ),
        )),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onBack?.call(),
          child: Container(
            margin: const EdgeInsetsDirectional.only(bottom: 10),
            width: 40,
            height: 6,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
          ),
        ),
        child,
      ],
    );
  }
}
