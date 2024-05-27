import 'package:beauty_center/appointment_page.dart';
import 'package:beauty_center/map_selection.dart';
import 'package:beauty_center/saved.dart';
<<<<<<< HEAD
import 'package:beauty_center/screens/checkout.dart';
=======
import 'package:beauty_center/screens/cart.dart';
>>>>>>> f458b44f7dfb6ad2864282a02d41e35b837e7356
import 'package:beauty_center/screens/home.dart';
import 'package:beauty_center/sign_in.dart';
import 'package:beauty_center/sign_up.dart';

// import 'package:beauty_center/gallery_test.dart';
// import 'package:beauty_center/help_center.dart';
// import 'package:beauty_center/home.dart';
// import 'package:beauty_center/sign_in.dart';
// import 'package:beauty_center/splash.dart';
// import 'package:beauty_center/staff_test.dart';
// import 'package:beauty_center/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty Center by Sanyar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: MapSelectionScreen(),
=======
      home: SCartScreen(),
>>>>>>> f458b44f7dfb6ad2864282a02d41e35b837e7356
    );
  }
}
