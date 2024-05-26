import 'package:beauty_center/details.dart';
import 'package:flutter/material.dart';

List<SImageDetails> _images = [
  SImageDetails(
      imagePath: 'images/hairstylist1.jpg',
      details: 'details',
      speciality: 'Nails',
      title: 'Hoda'),
  SImageDetails(
      imagePath: 'images/facial1.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'title'),
  SImageDetails(
      imagePath: 'images/hairstylist2.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'title'),
  SImageDetails(
      imagePath: 'images/lashtech1.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'title'),
  SImageDetails(
      imagePath: 'images/nailtech1.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'title'),
  SImageDetails(
      imagePath: 'images/mua1.jpg',
      details: 'details',
      speciality: 'Makeup Artist',
      title: 'Maria'),
  SImageDetails(
      imagePath: 'images/lashtech2.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'title'),
  SImageDetails(
      imagePath: 'images/facial2.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'title'),
  SImageDetails(
      imagePath: 'images/mua2.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'title'),
  SImageDetails(
      imagePath: 'images/nailtech2.jpg',
      details: 'details',
      speciality: 'photographer',
      title: 'Siham'),
];

class SStaffTest extends StatelessWidget {
  const SStaffTest({super.key});

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
                'Staff Members',
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SGalleryDetails(
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
        ));
  }
}

class SImageDetails {
  final String imagePath, speciality, title, details;

  SImageDetails({
    required this.imagePath,
    required this.details,
    required this.speciality,
    required this.title,
  });
}
