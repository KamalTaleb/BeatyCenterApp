import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/rounded_image.dart';
import 'package:beauty_center/section_heading.dart';
import 'package:beauty_center/services_card_horizontal.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppbar(
        onPressed: () {},
        title: const Text(
          'Services',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SRoundedImage(
                width: double.infinity,
                imageUrl: 'images/home1.JPG',
                applyImageRadius: true,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Column(
                children: [
                  SSectionHeading(
                    title: 'service one',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 12.0,
                      ),
                      itemBuilder: (context, index) =>
                          const SServicesCardHorizontal(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
