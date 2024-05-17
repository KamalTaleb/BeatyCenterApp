import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SSearchContainer extends StatelessWidget {
  const SSearchContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            const Icon(
              Iconsax.search_normal,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              "Search",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
