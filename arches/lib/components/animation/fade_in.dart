import 'package:flutter/widgets.dart';

class FadeIn extends StatelessWidget {
  const FadeIn(
      {required this.child,
      this.delay = 0,
      this.duration = const Duration(milliseconds: 300),
      Key? key})
      : super(key: key);

  final Widget child;
  final double delay;
  final Duration duration;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
      child: child,
      curve: Interval(delay, 1, curve: Curves.easeInOut),
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      builder: (context, tick, _child) => Opacity(
            opacity: tick,
            child: _child,
          ));
}
