import 'package:beauty_center/add_feedback.dart';
import 'package:beauty_center/appointment_page.dart';
import 'package:beauty_center/booking_calendar.dart';
import 'package:beauty_center/booking_page.dart';
import 'package:beauty_center/cancel_booking.dart';
import 'package:beauty_center/home.dart';
import 'package:beauty_center/navigation_menu.dart';
import 'package:beauty_center/services_card_horizontal.dart';
import 'package:beauty_center/services_card_vertical.dart';
import 'package:beauty_center/upcoming_page.dart';

// import 'package:beauty_center/gallery_test.dart';
// import 'package:beauty_center/help_center.dart';
// import 'package:beauty_center/home.dart';
// import 'package:beauty_center/sign_in.dart';
// import 'package:beauty_center/splash.dart';
// import 'package:beauty_center/staff_test.dart';
// import 'package:beauty_center/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NavigationMenu(),
    );
  }
}
