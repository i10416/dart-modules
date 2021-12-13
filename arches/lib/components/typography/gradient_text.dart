import 'package:flutter/material.dart';

const Gradient purpleLinearGradient = LinearGradient(
  transform: GradientRotation(120),
  colors: [
    Color.fromRGBO(242, 85, 207, 1),
    Color.fromRGBO(181, 105, 255, 1),
    Color.fromRGBO(135, 137, 255, 1),
  ],
  tileMode: TileMode.clamp,
);

class GradientText extends StatelessWidget {
  const GradientText(this.text,
      {this.style,
      this.align = TextAlign.left,
      this.textOverflow = TextOverflow.clip,
      this.gradient = purpleLinearGradient,
      Key? key})
      : super(key: key);

  final TextStyle? style;
  final String text;
  final Gradient gradient;
  final TextAlign align;
  final TextOverflow textOverflow;

  @override
  Widget build(context) => ShaderMask(
        shaderCallback: (bounds) => gradient.createShader(
          Rect.fromLTRB(0, 0, bounds.width, bounds.height),
        ),
        child: Text(
          text,
          overflow: textOverflow,
          style: style?.copyWith(color: Colors.white) ??
              Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
          textAlign: align,
        ),
      );
}
