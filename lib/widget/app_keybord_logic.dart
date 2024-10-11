import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

/// 监听键盘弹出
mixin AppKeyboardLogic<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!mounted) return;
    final temp = keyboardVisible;
    if (_keyboardVisible == temp) return;
    _keyboardVisible = temp;
    onKeyboardChanged(keyboardVisible);
    // AppLog.debug('KeyboardLogic bottom = ${getKeyBordHeight()}');
  }

  double getKeyBordHeight(BuildContext context) {
    var wb = WidgetsBinding.instance;
    double dpr = View.of(context).devicePixelRatio;
    if (wb != null) {
      var bottom = EdgeInsets.fromViewPadding(
        WidgetsBinding.instance!.window.viewInsets,
        dpr,
      ).bottom;
      return math.max(bottom, 278);
    }
    return 278;
  }

  void onKeyboardChanged(bool visible);

  bool get keyboardVisible =>
      EdgeInsets.fromViewPadding(
        WidgetsBinding.instance!.window.viewInsets,
        WidgetsBinding.instance!.window.devicePixelRatio,
      ).bottom >
      100;
}
