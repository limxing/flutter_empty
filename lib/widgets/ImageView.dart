import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';

class Imageview extends StatelessWidget {
  const Imageview({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.fit,
    this.alignment,
    this.onTap,
    this.margin,
    this.padding,
    this.borderRadius,
    this.border,
  });

  final Object? imagePath;

  /// The height of the image.
  final double? height;

  /// The width of the image.
  final double? width;

  /// How the image should be inscribed into the box.
  final BoxFit? fit;

  /// Alignment of the image within its container.
  final Alignment? alignment;

  /// Callback triggered when the image is tapped.
  final VoidCallback? onTap;

  /// Margin around the image container.
  final EdgeInsetsGeometry? margin;

  /// Padding inside the image container.
  final EdgeInsetsGeometry? padding;

  /// Border radius of the image container.
  final BorderRadius? borderRadius;

  /// Border of the image container.
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnyImageView(
        imagePath: imagePath,
        width: width,
        height: height,
        onTap: onTap,
        fit: fit,
        alignment: alignment,
        margin: margin,
        padding: padding,
        border: border,
        borderRadius: borderRadius,
      ),
    );
  }
}
