import 'package:flutter/material.dart';

class SRoundedImage extends StatelessWidget {
  const SRoundedImage({
    super.key,
    this.width = 300,
    this.height = 5,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = Colors.transparent,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 16.0,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.0)),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.circular(16.0),
          child: Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
