import 'package:beauty_center/guest.dart';
import 'package:beauty_center/home_services.dart';
import 'package:beauty_center/promo_slider.dart';
import 'package:beauty_center/screens/cart.dart';
import 'package:beauty_center/screens/home.dart';
import 'package:beauty_center/search_container.dart';
import 'package:beauty_center/primary_header_container.dart';
import 'package:beauty_center/section_heading.dart';
import 'package:beauty_center/show_gallery.dart';
import 'package:beauty_center/show_staff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GuestHome extends StatelessWidget {
  const GuestHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  const SSearchContainer(text: "search"),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      children: [
                        SSectionHeading(
                          title: "Popular Services",
                          showActivityButton: true,
                          textColor: Colors.white,
                          onPressed: () {
                              Get.to(() => const guest());
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const SHomeServices(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SPromoSlider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  SShowStaff(
                    title: 'Meet Our Staff Members',
                    imageUrls: ['images/mua1.jpg', 'images/lashtech1.jpg', 'images/nailtech1.jpg'],
                    buttonText: 'Show',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SShowGallery(
                    title: 'Our Gallery',
                    imageUrls: ['images/nails1.jpg', 'images/makeup2.jpg', 'images/hair1.jpg'],
                    buttonText: 'Show',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
