import 'package:flutter/material.dart';
import 'package:nyako/pages/main/discover/index.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/widget/app_click_widget.dart';

class Refresh extends StatefulWidget {
  const Refresh({Key? key}) : super(key: key);

  @override
  _FreshState createState() => _FreshState();
}

class _FreshState extends State<Refresh> with TickerProviderStateMixin {
  /// 手动控制动画的控制器
  late final AnimationController _manualController;

  /// 手动控制
  late final Animation<double> _manualAnimation;

  @override
  void initState() {
    super.initState();

    /// 不设置重复，使用代码控制进度，动画时间1秒
    _manualController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _manualAnimation =
        Tween<double>(begin: 0, end: 1).animate(_manualController);
  }

  @override
  void dispose() {
    _manualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppClickWidget(
      type: AppClickType.debounce,
      onTap: () {
        /// 获取动画当前的值
        var value = _manualController.value;

        /// 1代表 360弧度
        if (value == 1) {
          _manualController.animateTo(0);
        } else {
          _manualController.animateTo(1);
        }
        safeFind<MomentLogic>()
            ?.refreshDiscoverData(isLoading: true, isShowClean: true);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          /*RotationTransition(
            turns: _manualAnimation,
            child: Image.asset(
              Assets.imgDiscoverRefresh,
              matchTextDirection: true,
              width: 25,
              height: 25,
            ),
          ),*/
        ],
      ),
    );
  }
}
