import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';

class Imageview extends StatelessWidget {
  const Imageview({super.key, this.imagePath, this.height, this.width});

  final Object? imagePath;

  /// The height of the image.
  final double? height;

  /// The width of the image.
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnyImageView(imagePath: imagePath, width: width, height: height),
    );
  }
}
