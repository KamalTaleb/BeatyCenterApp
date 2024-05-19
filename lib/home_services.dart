import 'package:beauty_center/vertical_image_text.dart';
import 'package:flutter/material.dart';

class SHomeServices extends StatelessWidget {
  const SHomeServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return SVerticalImageText(
            image: "images/onboarding1.PNG",
            title: 'test',
            onTap: () {},
          );
        },
      ),
    );
  }
}
