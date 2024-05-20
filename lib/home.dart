import 'package:beauty_center/appbar.dart';
import 'package:beauty_center/cart_menu_icon.dart';
import 'package:beauty_center/curved_edge.dart';
import 'package:beauty_center/curved_edge_widget.dart';
import 'package:beauty_center/home.dart';
import 'package:beauty_center/home_appbar.dart';
import 'package:beauty_center/home_services.dart';
import 'package:beauty_center/promo_slider.dart';
import 'package:beauty_center/rounded_image.dart';
import 'package:beauty_center/search_container.dart';
import 'package:beauty_center/primary_header_container.dart';
import 'package:beauty_center/section_heading.dart';
import 'package:beauty_center/vertical_image_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'circular_container.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SPrimaryHeaderContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  SSearchContainer(text: "search"),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      children: [
                        SSectionHeading(
                          title: "Popular Services",
                          showActivityButton: false,
                          textColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SHomeServices(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SPromoSlider(
                banners: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
