import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/match/widget/bubbles/bubble_floating_animation.dart';
import 'package:sa4_migration_kit/stateless_animation/loop_animation.dart';
import 'package:sa4_migration_kit/stateless_animation/play_animation.dart';

///Enum for Setting the Shape of the bubble
enum BubbleShape { circle, square, roundedRectangle }

///Enum for Setting the speed at which the bubbles go through screen
enum BubbleSpeed { fast, normal, slow }

/// Creates Floating Bubbles in the Foreground of Any [widgets].
class FloatingBubbles extends StatefulWidget {
  /// Number of Bubbles to be shown per second. Should be [> 10] and not [null].
  /// Whenever this value is changed, do a **Hot Restart** to see the Changes.
  final int noOfBubbles;

  /// Add Color to the Bubble
  ///
  /// For example `colorOfBubbles = Colors.white.withAlpha(30).`\
  ///`withAlpha(30)` will give a lighter shade to the bubbles.
  final List<Color> colorsOfBubbles;

  /// Add Size Factor to the bubbles
  ///
  /// Typically it should be > 0 and < 0.5. Otherwise the bubble size will be too large.
  final double sizeFactor;

  /// Number of [Seconds] the animation needs to draw on the screen.
  /// If you want the bubbles to be floating always then use the constructor
  /// `FloatingBubbles.alwaysRepeating()`.
  final int? duration;

  /// Opacity of the bubbles. Can take the value between 0 to 255.
  final int opacity;

  /// Painting Style of the bubbles.
  final PaintingStyle paintingStyle;

  /// Stroke Width of the bubbles. This value is effective only if [Painting Style]
  /// is set to [PaintingStyle.stroke].
  final double strokeWidth;

  /// Shape of the Bubble. Default value is [BubbleShape.circle]
  final BubbleShape shape;

  /// controls the speed at which bubbles appear/disappear
  final BubbleSpeed speed;

  /// Creates Floating Bubbles in the Foreground to Any widgets that plays for [duration] amount of time.
  ///
  /// All Fields Are Required to make a new [Instance] of FloatingBubbles.
  /// If you want the bubbles to be floating always then use the constructor
  /// `FloatingBubbles.alwaysRepeating()`.
  FloatingBubbles({
    required this.noOfBubbles,
    required this.colorsOfBubbles,
    required this.sizeFactor,
    required this.duration,
    this.shape = BubbleShape.circle,
    this.opacity = 100,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 0,
    this.speed = BubbleSpeed.normal,
  })  : assert(
          noOfBubbles >= 1,
          'Number of Bubbles Cannot be less than 1',
        ),
        assert(
          sizeFactor > 0 && sizeFactor < 0.5,
          'Size factor cannot be greater than 0.5 or less than 0',
        ),
        assert(duration != null && duration >= 0,
            'duration should not be null or less than 0.'),
        assert(
          opacity >= 0 && opacity <= 255,
          'opacity value should be between 0 and 255 inclusive.',
        ),
        assert(
          colorsOfBubbles.isNotEmpty,
          'Atleast one color must be specified',
        );

  /// Creates Floating Bubbles that always floats and doesn't stop.
  /// All Fields Are Required to make a new [Instance] of FloatingBubbles.
  FloatingBubbles.alwaysRepeating({
    required this.noOfBubbles,
    required this.colorsOfBubbles,
    required this.sizeFactor,
    this.shape = BubbleShape.circle,
    this.opacity = 60,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 0,
    this.duration = 0,
    this.speed = BubbleSpeed.normal,
  })  : assert(
          noOfBubbles >= 1,
          'Number of Bubbles Cannot be less than 1',
        ),
        assert(
          sizeFactor > 0 && sizeFactor < 0.5,
          'Size factor cannot be greater than 0.5 or less than 0',
        ),
        assert(
          opacity >= 0 && opacity <= 255,
          'opacity value should be between 0 and 255 inclusive.',
        );

  @override
  _FloatingBubblesState createState() => _FloatingBubblesState();
}

class _FloatingBubblesState extends State<FloatingBubbles> {
  /// Creating a Random object.
  final Random random = Random();

  ///if [this] value is 0, animation is played, else animation is stopped.
  ///Value of this is never changed when the duration is zero.
  int checkToStopAnimation = 0;

  /// initialises a empty list of bubbles.
  final List<BubbleFloatingAnimation> bubbles = [];

  List<ui.Image?> bubbleImages = [];

  @override
  void dispose() {
    super.dispose();
    for (var element in bubbleImages) {
      element?.dispose();
    }
  }

  @override
  void initState() {
    final _random = new Random();
    for (int i = 0; i < widget.noOfBubbles; i++) {
      bubbles.add(
        BubbleFloatingAnimation(random,
            color: widget.colorsOfBubbles[
                _random.nextInt(widget.colorsOfBubbles.length)],
            speed: widget.speed,
            index: i),
      );
    }
    if (widget.duration != null && widget.duration != 0)
      Timer(Duration(seconds: widget.duration!), () {
        if (mounted) {
          setState(() {
            checkToStopAnimation = 1;
          });
        }
      });
    super.initState();
    getImage();
  }

  void getImage() async {
    bubbleImages = [
      await getAssetImage(
        Assets.finalMc1,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc2,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc3,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc4,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc5,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc6,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc7,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc8,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc9,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc10,
        width: 40,
        height: 40,
      ),
      await getAssetImage(
        Assets.finalMc11,
        width: 40,
        height: 40,
      ),
    ];
  }

  //返回ui.Image
  Future<ui.Image> getAssetImage(String asset, {width, height}) async {
    ByteData data = await rootBundle.load(asset);
    if (data == null) throw 'Unable to read data';
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  /// Function to paint the bubbles to the screen.
  /// This is call the paint function in bubbles_floating_animation.dart.
  CustomPaint drawBubbles({required CustomPainter bubbles}) {
    return CustomPaint(
      painter: bubbles,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Creates a Loop Animation of Bubbles that float around the screen from bottom to top.
    /// If [duration] is 0, then the animation loops itself again and again.
    /// If [duration] is not 0, then the animation plays till the duration and stops.
    return widget.duration == 0 && widget.duration != null
        ? LoopAnimation(
            tween: ConstantTween(1),
            builder: (context, child, value) {
              _simulateBubbles();
              return drawBubbles(
                bubbles: BubbleModel(
                  bubbles: bubbles,
                  sizeFactor: widget.sizeFactor,
                  opacity: widget.opacity,
                  paintingStyle: widget.paintingStyle,
                  strokeWidth: widget.strokeWidth,
                  shape: widget.shape,
                  bubbleImages: bubbleImages,
                ),
              );
            },
          )
        : PlayAnimation(
            duration: checkToStopAnimation == 0
                ? Duration(seconds: widget.duration!)
                : Duration.zero,
            tween: ConstantTween(1),
            builder: (context, child, value) {
              _simulateBubbles();
              if (checkToStopAnimation == 0)
                return drawBubbles(
                  bubbles: BubbleModel(
                    bubbles: bubbles,
                    sizeFactor: widget.sizeFactor,
                    opacity: widget.opacity,
                    paintingStyle: widget.paintingStyle,
                    strokeWidth: widget.strokeWidth,
                    shape: widget.shape,
                    bubbleImages: bubbleImages,
                  ),
                );
              else
                return SizedBox
                    .shrink(); // will display a empty container after playing the animations.
            },
          );
  }

  /// This Function checks whether the bubbles in the screen have to be restarted due to
  /// frame skips.
  _simulateBubbles() {
    bubbles.forEach((bubbles) => bubbles.checkIfBubbleNeedsToBeRestarted());
  }
}
