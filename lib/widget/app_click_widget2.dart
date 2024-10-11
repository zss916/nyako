import 'dart:async';

import 'package:flutter/material.dart';

enum AppClickType {
  /// 无限制
  none,

  /// 事件节流 在当前事件未执行完成时，该事件再次触发时会被忽略
  throttle,

  /// 指定时间节流 指定时间内（默认500ms）再次触发事件会被忽略
  throttleWithTimeout,

  /// 防抖
  /// 防抖是在事件触发时，不立即执行事件的目标操作逻辑，而是延迟指定时间再执行，
  /// 如果该时间内事件再次触发，则取消上一次事件的执行并重新计算延迟时间，
  /// 直到指定时间内事件没有再次触发时才执行事件的目标操作。
  debounce
}

/// 自定义点击控件
class AppClickWidget2 extends StatelessWidget {
  final Widget child;
  final Function? onTap;
  final AppClickType type;
  final int? timeout;
  final GestureDragDownCallback? onHorizontalDragDown;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragDownCallback? onVerticalDragDown;
  final GestureDragStartCallback? onVerticalDragStart;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final GestureDragEndCallback? onVerticalDragEnd;

  const AppClickWidget2({
    super.key,
    required this.child,
    this.onTap,
    this.type = AppClickType.throttleWithTimeout,
    this.timeout,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      onTap: _getOnTap(),
      child: child,
    );
  }

  VoidCallback? _getOnTap() {
    if (type == AppClickType.throttle) {
      return onTap?.throttle();
    } else if (type == AppClickType.throttleWithTimeout) {
      return onTap?.throttleWithTimeout(timeout: timeout);
    } else if (type == AppClickType.debounce) {
      return onTap?.debounce(timeout: timeout);
    }
    return () => onTap?.call();
  }
}

/// 对Function进行扩展
extension FunctionExt on Function {
  VoidCallback throttle() {
    return FunctionProxy(this).throttle;
  }

  VoidCallback throttleWithTimeout({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).throttleWithTimeout;
  }

  VoidCallback debounce({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).debounce;
  }
}

/// 节流、防抖 实现方式
class FunctionProxy {
  static final Map<String, bool> _funcThrottle = {};
  static final Map<String, Timer> _funcDebounce = {};
  final Function? target;

  final int timeout;

  FunctionProxy(this.target, {int? timeout}) : timeout = timeout ?? 500;

  /// 点击的回调执行完才能响应下次
  void throttle() async {
    String key = hashCode.toString();
    bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      try {
        await target?.call();
      } catch (e) {
        rethrow;
      } finally {
        _funcThrottle.remove(key);
      }
    }
  }

  /// 指定时间后才能响应下次
  void throttleWithTimeout() {
    String key = hashCode.toString();
    bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      Timer(Duration(milliseconds: timeout), () {
        _funcThrottle.remove(key);
      });
      target?.call();
    }
  }

  /// 防抖，实现方式是点击后不立即执行先计时
  void debounce() {
    String key = hashCode.toString();
    Timer? timer = _funcDebounce[key];
    timer?.cancel();
    timer = Timer(Duration(milliseconds: timeout), () {
      Timer? t = _funcDebounce.remove(key);
      t?.cancel();
      target?.call();
    });
    _funcDebounce[key] = timer;
  }
}
