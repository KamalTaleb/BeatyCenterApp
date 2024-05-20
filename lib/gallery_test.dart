import 'package:beauty_center/gallery_details.dart';
import 'package:flutter/material.dart';




List<SImageDetails> _images =[
  SImageDetails(imagePath: 'images/home6.jpg', details: 'details', speciality: 'photographer',title: 'title'),
  SImageDetails(imagePath: 'images/logo.png', details: 'details', speciality: 'photographer',title: 'title'),
  SImageDetails(imagePath: 'images/logo1.PNG', details: 'details', speciality: 'photographer',title: 'title'),
  SImageDetails(imagePath: 'images/splash.png', details: 'details', speciality: 'photographer',title: 'title'),
  SImageDetails(imagePath: 'images/onboarding1.PNG', details: 'details', speciality: 'photographer',title: 'title'),
];


class SGalleryTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
                'Services Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
                  itemBuilder: (context, index){
                return RawMaterialButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SGalleryDetails(
                        imagePath: _images[index].imagePath,
                        title: _images[index].title,
                        speciality: _images[index].speciality,
                        details: _images[index].details,
                        index: index,
                      ),
                      ),
                    );
                  },
                child: Hero(
                  tag: 'logo$index',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(_images[index].imagePath),
                      ),
                    ),
                  ),
                ),
                );
                  },
                itemCount: _images.length,
              ),
            ),
            ),
          ],
        ),
      )
    );
  }
}


class SImageDetails{
  final String imagePath, speciality, title, details;
  SImageDetails({required this.imagePath,
    required this.details,
    required this.speciality,
    required this.title,});
}
