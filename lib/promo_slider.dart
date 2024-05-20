import 'package:beauty_center/circular_container.dart';
import 'package:beauty_center/home_controller.dart';
import 'package:beauty_center/rounded_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SPromoSlider extends StatelessWidget {
  const SPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

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
              imageUrl: 'images/home1.jpg',
            ),
            SRoundedImage(
              imageUrl: 'images/home2.jpg',
            ),
            SRoundedImage(
              imageUrl: 'images/home3.jpg',
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 3; i++)
                  SCircularContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carouselCurrentIndex.value == i
                              ? Colors.blue
                              : Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
