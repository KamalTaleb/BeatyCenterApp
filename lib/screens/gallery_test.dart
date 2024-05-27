import 'package:beauty_center/screens/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beauty_center/details.dart';

class SGalleryTest extends StatefulWidget {
  const SGalleryTest({super.key});

  @override
  _SGalleryTestState createState() => _SGalleryTestState();
}

class _SGalleryTestState extends State<SGalleryTest> {
  List<SImageDetails> _images = [];
  Set<int> _likedImages = {};

  @override
  void initState() {
    super.initState();
    _fetchGalleryImages();
    _fetchLikedImages();
  }

  Future<void> _fetchGalleryImages() async {
    try {
      var response = await http
          .get(Uri.parse('http://192.168.1.9/senior/get_gallery_images.php'));
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }
      if (response.statusCode == 200) {
        List<dynamic> galleryList = json.decode(response.body);
        setState(() {
          _images = galleryList.map((image) {
            return SImageDetails(
              imageId: int.parse(image['id']),
              imagePath: image['image'] ?? '',
              details: image['details'] ?? '',
              speciality: image['speciality'] ?? '',
              title: image['title'] ?? '',
            );
          }).toList();
        });
      } else {
        if (kDebugMode) {
          print('Failed to load gallery');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> _fetchLikedImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    if (userId == null) return;

    try {
      var response = await http.get(Uri.parse(
          'http://192.168.1.9/senior/get_liked_images.php?user_id=$userId'));
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }
      if (response.statusCode == 200) {
        List<dynamic> likedImages = json.decode(response.body);
        setState(() {
          _likedImages =
              likedImages.map((image) => int.parse(image['image_id'])).toSet();
        });
      } else {
        if (kDebugMode) {
          print('Failed to load liked images');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> _toggleLike(int imageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    if (userId == null) return;

    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'user_id': userId, 'image_id': imageId});

    if (_likedImages.contains(imageId)) {
      // Unlike
      var response = await http.post(
        Uri.parse('http://192.168.1.9/senior/unlike_image.php'),
        headers: headers,
        body: body,
      );
      if (kDebugMode) {
        print('Unlike response body: ${response.body}');
      }
      if (response.statusCode == 200) {
        setState(() {
          _likedImages.remove(imageId);
        });
      } else {
        if (kDebugMode) {
          print('Failed to unlike image');
        }
      }
    } else {
      // Like
      var response = await http.post(
        Uri.parse('http://192.168.1.9/senior/like_image.php'),
        headers: headers,
        body: body,
      );
      if (kDebugMode) {
        print('Like response body: ${response.body}');
      }
      if (response.statusCode == 200) {
        setState(() {
          _likedImages.add(imageId);
        });
      } else {
        if (kDebugMode) {
          print('Failed to like image');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homePage()),
                        );
                      },
                      icon: const Icon(
                        FontAwesomeIcons.longArrowAltLeft,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Services Gallery',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      child: Stack(
                        children: [
                          Hero(
                            tag: 'logo$index',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: _images[index].imagePath.isNotEmpty
                                      ? NetworkImage(
                                          'http://192.168.1.9/senior/${_images[index].imagePath}')
                                      : const AssetImage('images/default.jpg')
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -7.5,
                            right: -7.5,
                            child: IconButton(
                              icon: Icon(
                                _likedImages.contains(_images[index].imageId)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _likedImages
                                        .contains(_images[index].imageId)
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () {
                                _toggleLike(_images[index].imageId);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: _images.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SImageDetails {
  final int imageId;
  final String imagePath, speciality, title, details;

  SImageDetails({
    required this.imageId,
    required this.imagePath,
    required this.details,
    required this.speciality,
    required this.title,
  });
}
