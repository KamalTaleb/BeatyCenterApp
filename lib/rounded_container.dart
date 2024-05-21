import 'package:flutter/material.dart';

class SRoundedContainer extends StatelessWidget {
  const SRoundedContainer({super.key, this.width , this.height, this.radius = 16.0, this.child, this.showBorder = false,  this.borderColor= const Color(0xFF090909),  this.backgroundColor= Colors.white, this.padding, this.margin});


  final double? width,height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding, margin;




  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor):null,
      ),
      child: child,
    );
  }
}
