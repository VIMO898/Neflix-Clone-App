import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final double opacity;
  const PlaceholderImage(
      {super.key,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.opacity = 1.0});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/placeholder.jpg',
      width: width,
      height: height,
      fit: fit,
      opacity: AlwaysStoppedAnimation(opacity),
    );
  }
}
