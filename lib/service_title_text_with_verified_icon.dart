import 'package:beauty_center/enums.dart';
import 'package:beauty_center/service_title_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';



class SServiceTitleWithVerifiedIcon extends StatelessWidget {
  const SServiceTitleWithVerifiedIcon({super.key, required this.title, this.maxlines = 1, this.textColor, this.iconColor = Colors.blue, this.textAlign = TextAlign.center, this.brandTextSize = TextSizes.small});


  final String title;
  final int maxlines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: SServiceTitleText(
              title: title,
              color: textColor,
              maxLines: maxlines,
              brandTextSize: brandTextSize
            )
        ),
        const SizedBox(
          width: 4.0,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: 16.0,
        ),
      ],
    );
  }
}
