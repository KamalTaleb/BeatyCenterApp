import 'package:beauty_center/details.dart';
import 'package:flutter/material.dart';




List<SImageDetails> _images =[
  SImageDetails(imagePath: 'images/nails1.jpg', details: 'Pose vernis', speciality: 'Hoda',title: 'Nails'),
  SImageDetails(imagePath: 'images/makeup1.jpg', details: 'Full makeup', speciality: 'Maria',title: 'Makeup'),
  SImageDetails(imagePath: 'images/nails2.jpg', details: 'Gelish', speciality: 'Siham',title: 'Nails'),
  SImageDetails(imagePath: 'images/hair1.jpg', details: 'Highlights', speciality: 'Sahar',title: 'Hair'),
  SImageDetails(imagePath: 'images/hair2.jpg', details: 'Half-do', speciality: 'Hadil',title: 'Hair'),
  SImageDetails(imagePath: 'images/nails3.jpg', details: 'Extension Gelish', speciality: 'Hoda',title: 'Nails'),
  SImageDetails(imagePath: 'images/makeup2.jpg', details: 'Birdal Glam', speciality: 'Lea',title: 'Makeup'),
  SImageDetails(imagePath: 'images/hair3.jpg', details: 'Half-do', speciality: 'Sahar',title: 'Hair'),


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
            const SizedBox(
              height: 40,
            ),
            const Text(
                'Services Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
  SImageDetails({
    required this.imagePath,
    required this.details,
    required this.speciality,
    required this.title,
  });
}
