import 'package:beauty_center/add_feedback.dart';
import 'package:beauty_center/admin.dart';
import 'package:beauty_center/cancel_booking.dart';
import 'package:beauty_center/gallery_test.dart';
import 'package:beauty_center/help_center.dart';
import 'package:beauty_center/home.dart';
import 'package:beauty_center/splash.dart';
import 'package:beauty_center/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Admin(),
    );
  }
}
