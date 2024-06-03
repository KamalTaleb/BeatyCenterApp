import 'package:beauty_center/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(
          title: 'Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_history,
              color: Colors.teal,
              size: 16,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              'Tripoli, at the Venue',
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ),
          ],
        ),
      ],
    );
  }
}
