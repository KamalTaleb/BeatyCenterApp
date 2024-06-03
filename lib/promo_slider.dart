import 'package:beauty_center/home_controller.dart';
import 'package:beauty_center/rounded_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SPromoSlider extends StatelessWidget {
  const SPromoSlider({
    super.key,
    // required this.banners,
  });

  // final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index)),
          items: const [
            SRoundedImage(
              imageUrl: 'images/teal1.jpg',
            ),
            SRoundedImage(
              imageUrl: 'images/teal2.jpg',
            ),
            SRoundedImage(
              imageUrl: 'images/teal3.jpg',
            ),
            SRoundedImage(
              imageUrl: 'images/teal4.jpg',
            ),
            SRoundedImage(
              imageUrl: 'images/teal3.jpg',
            ),
          ],
        ),

      ],
    );
  }
}
