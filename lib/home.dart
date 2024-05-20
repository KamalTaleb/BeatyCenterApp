import 'package:beauty_center/gallery_test.dart';
import 'package:beauty_center/home_services.dart';
import 'package:beauty_center/promo_slider.dart';
import 'package:beauty_center/search_container.dart';
import 'package:beauty_center/primary_header_container.dart';
import 'package:beauty_center/section_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//
// List<SImageDetails> _images =[
//   SImageDetails(imagePath: 'imagePath', details: 'details', photographer: 'photographer', price: 'price', title: 'title'),
//   SImageDetails(imagePath: 'imagePath', details: 'details', photographer: 'photographer', price: 'price', title: 'title'),
//   SImageDetails(imagePath: 'imagePath', details: 'details', photographer: 'photographer', price: 'price', title: 'title'),
//   SImageDetails(imagePath: 'imagePath', details: 'details', photographer: 'photographer', price: 'price', title: 'title'),
//   SImageDetails(imagePath: 'imagePath', details: 'details', photographer: 'photographer', price: 'price', title: 'title'),
// ];

class homePage extends StatelessWidget {
  const homePage({super.key});

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
              child: Column(
                children: [
                  SPromoSlider(),
                  SizedBox(
                    height: 32.0,
                  ),
                  // SGalleryTest(),
                ],
                // banners: [],
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            // SGalleryTest(),

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
//
// class SImageDetails{
//   final String imagePath, price, photographer, title, details;
//   SImageDetails({required this.imagePath,
//     required this.details,
//     required this.photographer,
//     required this.price,
//     required this.title,});
// }
