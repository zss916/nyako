import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LongPressGestureDetector extends StatelessWidget {
  final Widget child;

  // 长按回调
  final GestureLongPressDownCallback? onLongPressDown;

  // 长按移动回调
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  // 长按开始回调
  final GestureLongPressStartCallback? onLongPressStart;

  // 长按结束回调
  final GestureLongPressEndCallback? onLongPressEnd;

  //长按取消回调
  final GestureLongPressCancelCallback? onLongPressCancel;

  final GestureLongPressCallback? onLongPress;

  const LongPressGestureDetector(
      {super.key,
      required this.child,
      this.onLongPressDown,
      this.onLongPressMoveUpdate,
      this.onLongPressStart,
      this.onLongPressEnd,
      this.onLongPressCancel,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: onLongPressDown,
      onLongPress: onLongPress,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: onLongPressEnd,
      onLongPressCancel: onLongPressCancel,
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
