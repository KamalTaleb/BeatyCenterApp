import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/rounded_container.dart';
import 'package:beauty_center/rounded_image.dart';
import 'package:beauty_center/service_price_text.dart';
import 'package:beauty_center/service_title_text.dart';
import 'package:beauty_center/service_title_text_with_verified_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class SServicesCardHorizontal extends StatelessWidget {
  const SServicesCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: dark ? const Color(0xFF939393) : const Color(0xFFF4F4F4),
        ),
        child: Row(
          children: [
            SRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(8.0),
              backgroundColor:
                  dark ? const Color(0xFF272727) : const Color(0xFFF6F6F6),
              // child: Stack(
              //   children: [
              //     const SizedBox(
              //       height: 120,
              //       width: 120,
              //       // child: SRoundedImage(
              //       //   imageUrl: 'images/home2.JPG',
              //       //   applyImageRadius: true,
              //       // ),
              //     ),
              //     // Positioned(
              //     //   top: 12,
              //     //   child: SRoundedContainer(
              //     //     radius: 8.0,
              //     //     backgroundColor: const Color(0xFFFFE24B).withOpacity(0.8),
              //     //     padding: const EdgeInsets.symmetric(
              //     //         horizontal: 8.0, vertical: 4.0),
              //     //     child: Text(
              //     //       '25%',
              //     //       style: Theme.of(context)
              //     //           .textTheme
              //     //           .labelLarge!
              //     //           .apply(color: Colors.black),
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SServiceTitleText(
                          title: 'service one',
                          smallSize: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SServiceTitleWithVerifiedIcon(title: 'hair'),
                      ],
                    ),
                    // const Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SServiceTitleText(
                    //       title: 'service one',
                    //       smallSize: true,
                    //     ),
                    //     SizedBox(
                    //       height: 8.0,
                    //     ),
                    //     SServiceTitleWithVerifiedIcon(title: 'hair'),
                    //   ],
                    // ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: SServicePriceText(
                            price: '256.0',
                          ),
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
                            width: 32.0 * 1.2,
                            height: 32.0 * 1.2,
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.plus,
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
            ),
          ],
        ),
      ),
    );
  }
}
