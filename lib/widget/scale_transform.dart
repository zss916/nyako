import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScaleTransform extends StatelessWidget {
  final Widget child;

  ScaleTransform({Key? key, required this.child}) : super(key: key);

  double get photoScale => Get.width / Get.height;
  double designScale = 375 / 812;
  double get _baseScale => designScale / photoScale;
  double get _scale => _baseScale >= 1 ? 1 : _baseScale;
  bool get isSmall => ScreenUtil().screenHeight < 600;

  @override
  Widget build(BuildContext context) {
    Matrix4 m = Matrix4.identity()..scale(_scale, _scale);
    return Transform(
      alignment: AlignmentDirectional.center,
      transform: isSmall ? m : Matrix4.identity(),
      child: child,
    );
  }
}
