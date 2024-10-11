import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oliapro/pages/main/match/widget/bubbles/bubbles.dart';
import 'package:sa4_migration_kit/sa4_migration_kit.dart';

enum _OffsetProps { x, y }

/// This class Creates the animation of the bubbles flowing from bottom to top in the screen.
class BubbleFloatingAnimation {
  /// Creates a tween between x and y coordinates.
  late MultiTween<_OffsetProps> tween;

  /// Size of the bubble
  late double size;

  ///Duration of each bubble to reach to top from bottom.
  late Duration duration;

  /// Start Time duration of each bubble.
  late Duration startTime;

  /// Random object.
  final Random random;

  /// Color of the bubble
  final Color color;

  /// Speed of the bubble
  final BubbleSpeed speed;

  BubbleFloatingAnimation(this.random,
      {required this.color, required this.speed}) {
    _restart();
    _shuffle();
  }

  /// Function to Restart the floating bubble animation.
  _restart() {
    final startPosition = Offset(
      -0.2 + 1.4 * random.nextDouble(),
      1.2,
    );
    final endPosition = Offset(
      -0.2 + 1.4 * random.nextDouble(),
      -0.2,
    );

    tween = MultiTween<_OffsetProps>()
      ..add(
        _OffsetProps.x,
        Tween(
          begin: startPosition.dx,
          end: endPosition.dx,
        ),
      )
      ..add(
        _OffsetProps.y,
        Tween(
          begin: startPosition.dy,
          end: endPosition.dy,
        ),
      );

    duration = Duration(
          milliseconds: speed == BubbleSpeed.fast
              ? 1500
              : speed == BubbleSpeed.normal
                  ? 3000
                  : 6000,
        ) +
        Duration(
          milliseconds: random.nextInt(
            speed == BubbleSpeed.fast
                ? 3000
                : speed == BubbleSpeed.normal
                    ? 6000
                    : 12000,
          ),
        );

    startTime = Duration(
      milliseconds: DateTime.now().millisecondsSinceEpoch,
    );

    /// Size of each Bubble is calculated through this.
    size = 0.2 + random.nextDouble() * 0.4;
  }

  /// Shuffles the position of bubbles around the screen.
  void _shuffle() {
    startTime -= Duration(
      milliseconds:
          (this.random.nextDouble() * duration.inMilliseconds).round(),
    );
  }

  /// A Function to Check if a bubble needs to be recontructed in the ui.
  checkIfBubbleNeedsToBeRestarted() {
    if (progress() == 1.0) {
      _restart();
    }
  }

  /// This Function Checks whether a bubble has reached from bottom to top.
  ///
  /// if the progress returns 1, then that bubble has reached the top.
  double progress() {
    return ((Duration(
                  milliseconds: DateTime.now().millisecondsSinceEpoch,
                ).inMicroseconds -
                startTime.inMicroseconds) /
            duration.inMicroseconds)
        .clamp(0.0, 1.0)
        .toDouble();
  }
}

/// This Class paints the bubble in the screen.
class BubbleModel extends CustomPainter {
  /// List of all bubbles in the screen at a given time.
  final List<BubbleFloatingAnimation> bubbles;

  /// Size factor of the bubble.
  final double sizeFactor;

  /// Opacity of the bubbles.
  final int opacity;

  ///Painting Style of the bubbles.
  final PaintingStyle paintingStyle;

  /// Stroke Width of the bubbles. This value is effective only if [Painting Style]
  /// is set to [PaintingStyle.stroke].
  final double strokeWidth;

  /// Shape of the Bubble.
  final BubbleShape shape;

  /// This Class paints the bubble in the screen.
  ///
  /// All Fields are Required.
  BubbleModel({
    required this.bubbles,
    required this.sizeFactor,
    required this.opacity,
    required this.paintingStyle,
    required this.strokeWidth,
    required this.shape,
  });

  /// Painting the bubbles in the screen.
  @override
  void paint(Canvas canvas, Size size) {
    bubbles.forEach((particle) {
      final paint = Paint()
        ..color = particle.color.withAlpha(opacity)
        ..style = paintingStyle
        ..strokeWidth = strokeWidth; //can be from 5 to 15.
      final progress = particle.progress();
      final MultiTweenValues animation = particle.tween.transform(progress);
      final position = Offset(
        animation.get<double>(_OffsetProps.x) * size.width,
        animation.get<double>(_OffsetProps.y) * size.height,
      );
      if (shape == BubbleShape.circle)
        canvas.drawCircle(
          position,
          size.width * sizeFactor * particle.size,
          paint,
        );
      else if (shape == BubbleShape.square)
        canvas.drawRect(
            Rect.fromCircle(
              center: position,
              radius: size.width * sizeFactor * particle.size,
            ),
            paint);
      else {
        Rect rect() => Rect.fromCircle(
              center: position,
              radius: size.width * sizeFactor * particle.size,
            );
        canvas.drawRRect(
            RRect.fromRectAndRadius(
              rect(),
              Radius.circular(size.width * sizeFactor * particle.size * 0.5),
            ),
            paint);
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
