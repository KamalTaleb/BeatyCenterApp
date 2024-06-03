import 'package:beauty_center/appointment_page.dart';
import 'package:beauty_center/guest.dart';
import 'package:beauty_center/map_selection.dart';
import 'package:beauty_center/saved.dart';
import 'package:beauty_center/screens/booking_calendar.dart';
import 'package:beauty_center/screens/cart.dart';
import 'package:beauty_center/screens/checkout.dart';
import 'package:beauty_center/screens/home.dart';
import 'package:beauty_center/screens/navigation_menu.dart';
import 'package:beauty_center/screens/splash.dart';
import 'package:beauty_center/screens/staff_check.dart';
import 'package:beauty_center/sign_in.dart';
import 'package:beauty_center/sign_up.dart';
import 'package:beauty_center/staff_view_as_grid.dart';
import 'package:beauty_center/welcome_screen.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty Center by Sanyar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
