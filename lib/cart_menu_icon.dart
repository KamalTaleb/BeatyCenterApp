import 'package:beauty_center/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SCartCounterIcon extends StatelessWidget {
  const SCartCounterIcon(
      {super.key,
      required this.onPressed,
      required this.iconColor,
      required this.counterBgColor,
      required this.counterTextColor});

  final Color iconColor, counterBgColor, counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => SCartScreen()),
          icon: const Icon(
            Iconsax.shopping_bag,
            color: Colors.white,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "2",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: Colors.white, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
