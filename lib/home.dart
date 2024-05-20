import 'package:beauty_center/home_services.dart';
import 'package:beauty_center/promo_slider.dart';
import 'package:beauty_center/search_container.dart';
import 'package:beauty_center/primary_header_container.dart';
import 'package:beauty_center/section_heading.dart';
import 'package:flutter/material.dart';


class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  // const SHomeAppBar(),
                  SizedBox(
                    height: 32.0,
                  ),
                  SSearchContainer(text: "search"),
                  SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: Column(
                      children: [
                        SSectionHeading(
                          title: "Popular Services",
                          showActivityButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
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
              padding: EdgeInsets.all(8.0),
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
