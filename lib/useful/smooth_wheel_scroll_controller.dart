import 'dart:ui' show clampDouble;

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class SmoothWheelScrollController extends ScrollController {
  SmoothWheelScrollController({
    this.duration = const Duration(milliseconds: 380),
    this.curve = Curves.easeOutQuart,
    this.wheelDeltaScale = 0.78,
  });

  final Duration duration;
  final Curve curve;
  final double wheelDeltaScale;

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _SmoothWheelScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      duration: duration,
      curve: curve,
      wheelDeltaScale: wheelDeltaScale,
    );
  }
}

class _SmoothWheelScrollPosition extends ScrollPositionWithSingleContext {
  _SmoothWheelScrollPosition({
    required super.physics,
    required super.context,
    super.oldPosition,
    required this.duration,
    required this.curve,
    required this.wheelDeltaScale,
  });

  final Duration duration;
  final Curve curve;
  final double wheelDeltaScale;
  double? _targetPixels;

  @override
  void pointerScroll(double delta) {
    if (delta == 0) {
      goBallistic(0);
      return;
    }

    final basePixels = _targetPixels ?? pixels;
    final targetPixels = clampDouble(
      basePixels + (delta * wheelDeltaScale),
      minScrollExtent,
      maxScrollExtent,
    );

    if ((targetPixels - basePixels).abs() < 0.5) return;

    _targetPixels = targetPixels;
    animateTo(targetPixels, duration: duration, curve: curve).whenComplete(() {
      if ((pixels - targetPixels).abs() < 1.0) {
        _targetPixels = null;
      }
    });
  }
}
