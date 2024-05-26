import 'package:beauty_center/home_services.dart';
import 'package:beauty_center/promo_slider.dart';
import 'package:beauty_center/search_container.dart';
import 'package:beauty_center/primary_header_container.dart';
import 'package:beauty_center/section_heading.dart';
import 'package:beauty_center/show_gallery.dart';
import 'package:beauty_center/show_staff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SPrimaryHeaderContainer(
              child: Column(
                children: [
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
                          showActivityButton: true,
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SPromoSlider(),
                  const SizedBox(
                    height: 32.0,
                  ),
                  SShowStaff(
                    title: 'Meet Our Staff Members',
                    imageUrl: 'images/home1.JPG',
                    buttonText: 'Show',
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  SShowGallery(
                    title: 'Show Gallery',
                    imageUrl: 'images/home2.JPG',
                    buttonText: 'Show',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),

            // Expanded(
            //     child: GridView.builder(
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3,crossAxisSpacing: 10, mainAxisSpacing: 10),
            //       itemBuilder: (context, index){
            //         return RawMaterialButton(
            //             onPressed: (){},
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(15.0),
            //               image: DecorationImage(image: AssetImage(_images[index].imagePath),
            //               fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //       itemCount: _images.length,
            //     ),
            // ),
          ],
        ),
      ),
    );
  }
}
