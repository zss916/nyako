import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/translate/app_translate_util.dart';
import 'package:simple_animations/simple_animations.dart';

class BuildTranslateIcon extends StatefulWidget {
  final bool? isTranslated;
  final String? content;
  final Function(String)? fun;

  const BuildTranslateIcon(
      {super.key, this.isTranslated, this.content, this.fun});

  @override
  State<BuildTranslateIcon> createState() => _BuildSwitchState();
}

class _BuildSwitchState extends State<BuildTranslateIcon>
    with TickerProviderStateMixin {
  late final AnimationController _manualController;
  late final Animation<double> _manualAnimation;

  @override
  void initState() {
    super.initState();
    _manualController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..addListener(() {
        // 获取动画当前的状态
        var status = _manualController.status;
        if (status == AnimationStatus.completed) {
          _manualController.forward(from: 0.0);
        }
      })
      ..forward();
    _manualAnimation =
        Tween<double>(begin: 0, end: 1).animate(_manualController);
    _manualController.stop();
  }

  @override
  void dispose() {
    _manualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isTranslated == true
        ? Image.asset(
            Assets.imgTranslated,
            matchTextDirection: true,
            width: 20,
            height: 20,
          )
        : GestureDetector(
            onTap: () {
              _manualController.play();
              Future.delayed(const Duration(seconds: 3), () {
                _manualController.stop();
                AppTranslateUtil()
                    .translate(widget.content ?? "")
                    .then((value) {
                  if (value.isNotEmpty) {
                    widget.fun?.call(value.first);
                  }
                }).whenComplete(() => _manualController.stop());
              });
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                RotationTransition(
                  turns: _manualAnimation,
                  child: Image.asset(
                    Assets.imgTranslated,
                    matchTextDirection: true,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
          );
  }
}
