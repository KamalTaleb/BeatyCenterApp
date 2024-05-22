import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/rounded_container.dart';
import 'package:beauty_center/rounded_image.dart';
import 'package:beauty_center/s_circular_icon.dart';
import 'package:beauty_center/service_title_text.dart';
import 'package:beauty_center/shadows.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';



class SServiceCardVertical extends StatelessWidget {
  const SServiceCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() {}) ,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [SShadowStyle.horizontalProductShadow],
          borderRadius: BorderRadius.circular(16.0),
          color: dark ? Colors.grey : Colors.white,
        ),
        child: Column(
          children: [
            SRoundedContainer(
              height: 200,
              padding: const EdgeInsets.all(8.0),
              backgroundColor: dark ? const Color(0xFF272727): const Color(0xFFF6F6F6),
              child: Stack(
                children: [
                  const SRoundedImage(imageUrl: 'images/home2.JPG', applyImageRadius: true,),
                  Positioned(
                    top: 12,
                    child: SRoundedContainer(
                      radius: 8.0,
                      backgroundColor: Color(0xFFFFE24B).withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                      child: Text(
                        '25%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black),
                      ),
                    ),
                  ),
                  // const Positioned(
                  //   top: 0,
                  //     right: 0,
                  //     child: SCircularIcon(
                  //       icon: Iconsax.heart5,
                  //       color: Colors.red,
                  //     ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SServiceTitleText(
                    title: 'Service 1',
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'hair styling',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Iconsax.verify5,
                        color: Colors.blue,
                        size: 16.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$15.5',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                        ),
                        child: const SizedBox(
                          width: 24.0 * 1.2,
                          height: 24.0 * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
