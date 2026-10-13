import 'package:flutter/material.dart';
import 'package:home_furniture_ui/constants/animation_constant.dart';

class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset begin;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: AnimationConstant.animNormal),
    this.begin = const Offset(0, AnimationConstant.fadeSlideOffsetY),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration + delay,
      curve: Interval(
        delay.inMilliseconds / (duration + delay).inMilliseconds,
        1,
        curve: AnimationConstant.easeOutCubic,
      ),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(begin.dx * (1 - value) * 100, begin.dy * (1 - value) * 100),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
