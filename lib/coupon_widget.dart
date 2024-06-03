import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/rounded_container.dart';
import 'package:flutter/material.dart';

class SCoupon extends StatelessWidget {
  const SCoupon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return SRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? Colors.black : Colors.white,
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        right: 8.0,
        left: 16.0,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}