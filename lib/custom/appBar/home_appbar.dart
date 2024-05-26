import 'package:beauty_center/cart_menu_icon.dart';
import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:flutter/material.dart';

class SHomeAppBar extends StatelessWidget {
  const SHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SAppbar(
      title: const Column(
        children: [
          Text(
            "hello",
          ),
          Text(
            "sanyar",
          ),
        ],
      ),
      actions: [
        SCartCounterIcon(
          onPressed: () {},
          iconColor: Colors.white,
        )
      ],
    );
  }
}
