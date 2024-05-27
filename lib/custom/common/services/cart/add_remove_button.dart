import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/s_circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SServicesQuantityWithAddRemoveButton extends StatelessWidget {
  const SServicesQuantityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SCircularIcon(
          icon: Iconsax.minus,
          width: 32.0,
          height: 32.0,
          size: 16.0,
          color:
              SHelperFunction.isDarkMode(context) ? Colors.white : Colors.black,
          backgroundColor:
              SHelperFunction.isDarkMode(context) ? Colors.grey : Colors.white,
        ),
        const SizedBox(
          width: 16.0,
        ),
        Text(
          '2',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: 16.0,
        ),
        const SCircularIcon(
          icon: Iconsax.add,
          width: 32.0,
          height: 32.0,
          size: 16.0,
          color: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }
}
