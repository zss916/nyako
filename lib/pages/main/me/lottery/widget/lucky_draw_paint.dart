import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';

/// 等比例圆盘
class LuckyDrawPaint extends CustomPainter {
  LuckyDrawPaint({
    required this.contents,
    required this.selectSize,
    required this.colors,
    required this.images,
  })  : assert(contents.length == selectSize && colors.length == selectSize),
        super();

  int selectSize;

  List<String> contents = [];

  List<Color> colors = [];

  List<ui.Image?> images = [];

  @override
  void paint(Canvas canvas, Size size) {
    drawAcr(canvas, size);
  }

  void drawAcr(Canvas canvas, Size size) {
    double startAngles = 0;
    // 把画布坐标放中间1
    canvas.translate(size.width / 2, size.height / 2);
    // 因为现在0度在右边x轴，先逆时针90度，为了从上边作为第一个，顺时针绘制
    canvas.rotate(-pi);

    /// 中心
    Rect rect = Rect.fromCircle(center: Offset.zero, radius: size.width / 2);
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    // 根据总扇形数划分各扇形对应结束角度
    List<double> angles = List.generate(
        selectSize, (index) => (2 * pi / selectSize) * (index + 1));
    //画扇形
    for (int i = 0; i < selectSize; i++) {
      // paint.color = colors[i];
      paint.color = Colors.transparent;
      // paint.color = Colors.black;
      // - (pi / 2) 是为了圆形绘制起始点在头部，而不是右手边
      double acStartAngles = startAngles - (pi / 2);
      canvas.drawArc(rect, acStartAngles, angles[i] - startAngles, true, paint);
      startAngles = angles[i];
    }

    startAngles = 0;
    for (int i = 0; i < contents.length; i++) {
      canvas.save();

      // 新建一个段落建造器，然后将文字基本信息填入;
      ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontFamily: AppConstants.fontsRegular,
        fontSize: 10,
      ));
      pb.pushStyle(ui.TextStyle(color: Colors.transparent));

      pb.addText(contents[i]);
      // 设置文本的宽度约束
      ui.ParagraphConstraints pc = const ui.ParagraphConstraints(width: 55);
      // 这里需要先layout,将宽度约束填入，否则无法绘制
      ui.Paragraph paragraph = pb.build()..layout(pc);

      // 记得 - (pi / 2) 跟上边的处理一样，保证起始标准一致
      double acStartAngles = startAngles - (pi / 2);
      double acTweenAngles = angles[i] - (pi / 2);
      // + pi 的原因是 文本做了向左偏移到另一边的操作，为了文本方向是从外到里，偏移后旋转半圈，即一个pi
      double roaAngle = acStartAngles / 2 + acTweenAngles / 2 + pi;

      // 先把画布转到指定扇形中心，这时x轴在扇形中心，绘制文字会在扇形方向
      canvas.rotate((1) * roaAngle);
      // 先沿x轴移动一定距离，再转动90度，绘制文字就在扇形中心垂直方向了
      canvas.translate(80 + 20, 0);
      canvas.rotate(pi / 2);
      // 文字左上角起始点
      Offset offset = Offset(0 - paragraph.width / 2, -0);
      canvas.drawParagraph(paragraph, offset);

      // 位置 图片宽高36
      Rect pR = const Rect.fromLTWH(-22, -45, 45, 45);
      var image = images[i];
      if (image != null) {
        // 图片
        Rect iR = Rect.fromLTRB(
            0, 0, image.width.toDouble(), image.height.toDouble());
        canvas.drawImageRect(image, iR, pR, paint..color = Colors.white);
      }

      startAngles = angles[i];

      //画一个白色的Container
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              const Rect.fromLTRB(-20, -10, 20, 10), const Radius.circular(20)),
          paint
            ..color =
                contents[i].isNotEmpty ? Colors.white : Colors.transparent);

      ////
      // 新建一个段落建造器，然后将文字基本信息填入;
      ui.ParagraphBuilder pb2 = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 13,
      ));
      pb2.pushStyle(ui.TextStyle(color: const Color(0xFF9341FF)));

      pb2.addText(contents[i]);
      // 设置文本的宽度约束
      ui.ParagraphConstraints pc2 = const ui.ParagraphConstraints(width: 55);
      // 这里需要先layout,将宽度约束填入，否则无法绘制
      ui.Paragraph paragraph2 = pb2.build()..layout(pc2);
      // 文字左上角起始点
      Offset offset2 = Offset(0 - paragraph.width / 2, -8);
      canvas.drawParagraph(paragraph2, offset2);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  double maxHeight(Size size, double angle) {
    final double radius = size.width / 2;
    var maxHeight = radius * 2 * sin(angle / 2);
    maxHeight = maxHeight * 0.75;
    return maxHeight;
  }

  TextPainter _getTextPainter(TextSpan span, Size size, double angle) {
    // 文本的画笔
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    );
    tp.layout(minWidth: size.width / 4, maxWidth: size.width / 4);
    // 计算文本高度，超出自适应大小
    if (tp.height > maxHeight(size, angle)) {
      var temSpan = TextSpan(
        style: span.style!.copyWith(
          fontSize: span.style!.fontSize! - 1.0,
        ),
        text: span.text,
      );
      tp = _getTextPainter(temSpan, size, angle);
    }
    return tp;
  }
}
