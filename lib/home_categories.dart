import 'package:beauty_center/sub_categories.dart';
import 'package:beauty_center/vertical_image_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SHomeCategories extends StatelessWidget {
  const SHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index){
          return SVerticalImageText(
            image: 'image',
            title: 'title',
            onTap: ()=> Get.to(()=> const SubCategoriesScreen()),
          );
          },
      ),
    );
  }
}
