import 'package:flutter/material.dart';

class SServicePriceText extends StatelessWidget {
  const SServicePriceText(
      {
        super.key,
        this.currenySign = '\$',
        required this.price,
        this.maxlines = 1,
        this.isLarge = false,
        this.lineThrough = false,
      }
      );

  final String currenySign, price;
  final int maxlines;
  final bool isLarge;
  final bool lineThrough;


  @override
  Widget build(BuildContext context) {
    return Text(
      currenySign + price,
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(decoration: lineThrough
          ? TextDecoration.lineThrough
          : null)
          : Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough
          ? TextDecoration.lineThrough
          : null ),

    );
  }
}
