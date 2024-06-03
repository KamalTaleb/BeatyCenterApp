import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/rounded_container.dart';
import 'package:beauty_center/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SBillingPaymentSection extends StatelessWidget {
  const SBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Column(
      children: [
        const SSectionHeading(
          title: 'Payment method',
          showActivityButton: false,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Row(
          children: [
            SRoundedContainer(
              height: 60,
              width: 35,
              backgroundColor: dark ? const Color(0xFFF6F6F6) : Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: const Icon(FontAwesomeIcons.houseUser, color: Colors.teal,),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              'Pay at the Venue',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        )
      ],
    );
  }
}
