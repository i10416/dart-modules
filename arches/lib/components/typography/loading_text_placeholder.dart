import 'package:arches/components/utility/style/color_utilitiy.dart';
import 'package:flutter/material.dart';

class LoadingTextPlaceholder extends StatelessWidget {
  const LoadingTextPlaceholder(
      {required this.width,
      this.height = 14,
      this.color = ColorUtility.transparentGrey,
      this.padding,
      Key? key})
      : super(key: key);

  final double width;
  final double height;
  final Color color;
  final Padding? padding;

  @override
  Widget build(BuildContext context) => Container(
        decoration: ShapeDecoration(
          color: color,
          shape: const StadiumBorder(),
        ),
        width: width,
        height: height,
      );
}
