import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/entities/app_draw_user_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/app_extends.dart';

class RechargeDrawAnimation extends StatefulWidget {
  final DrawUserEntity data;
  const RechargeDrawAnimation(this.data, {super.key});

  @override
  State<StatefulWidget> createState() => _RechargeDrawAnimationState();
}

class _RechargeDrawAnimationState extends State<RechargeDrawAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;
  late final AnimationController _animationController1;
  late final Animation<Offset> _animation1;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 2000), () {
            _animationController1.forward();
          });
        }
      });
    var begin = const Offset(-2.0, .0);
    var end = const Offset(0.0, .0);
    _animation = Tween(begin: begin, end: end).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    //开始动画
    _animationController.forward();
    _animationController1 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    var begin1 = const Offset(0.0, .0);
    var end1 = const Offset(-2.0, .0);
    _animation1 = Tween(begin: begin1, end: end1).animate(CurvedAnimation(
      parent: _animationController1,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation1,
      child: SlideTransition(
        position: _animation,
        child: Container(
          margin: const EdgeInsetsDirectional.only(top: 100),
          alignment: Alignment.center,
          width: double.maxFinite,
          child: buildText(widget.data),
        ),
      ),
    );
  }

  Widget buildText(DrawUserEntity data) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          width: Get.width,
          margin: const EdgeInsetsDirectional.only(end: 30),
          constraints: const BoxConstraints(minHeight: 60),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsetsDirectional.only(
              top: 5, bottom: 5, start: 10, end: 50),
          decoration: const BoxDecoration(
              //color: Colors.blue,
              image: DecorationImage(
                  matchTextDirection: true,
                  centerSlice: Rect.fromLTRB(150, 5, 200, 45),
                  image: ExactAssetImage(Assets.iconRewardInfoBg),
                  fit: BoxFit.fill)),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsetsDirectional.only(end: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                foregroundDecoration: const BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child:
                      cachedImage(data.portrait ?? "", width: 30, height: 30),
                ),
              ),
              Expanded(
                  child: AutoSizeText(data.getContent(),
                      maxFontSize: 12,
                      minFontSize: 6,
                      maxLines: 2,
                      style: TextStyle(
                          color: const Color(0xFFFFFA6D),
                          fontFamily: AppConstants.fontsRegular,
                          fontSize: 12))),
            ],
          ),
        ),
        PositionedDirectional(
            end: 10,
            child: Image.asset(
              Assets.iconRechargeGift,
              width: 50,
              height: 50,
              matchTextDirection: true,
            ))
      ],
    );
  }
}
