import 'package:flutter/material.dart';

class GradientIcon extends Icon {
  const GradientIcon(IconData icon, {double size = 24, Key? key})
      : super(icon, size: size, key: key);

  @override
  Widget build(BuildContext context) => ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          transform: GradientRotation(120),
          colors: [
            Color.fromRGBO(242, 85, 207, 1),
            Color.fromRGBO(181, 105, 255, 1),
            Color.fromRGBO(135, 137, 255, 1),
          ],
          tileMode: TileMode.clamp,
        ).createShader(bounds),
        child: Icon(
          icon,
          color: Colors.white,
          size: size,
        ),
      );
}
