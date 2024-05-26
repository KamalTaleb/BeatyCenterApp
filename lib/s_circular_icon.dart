import 'package:beauty_center/helper_functions.dart';
import 'package:flutter/material.dart';

class SCircularIcon extends StatelessWidget {
  const SCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = 32.0,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : SHelperFunction.isDarkMode(context)
                ? Colors.black.withOpacity(0.9)
                : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
