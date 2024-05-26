import 'package:beauty_center/custom/button.dart';
import 'package:beauty_center/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SAppointmentBooked extends StatelessWidget {
  const SAppointmentBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset(
                'assets/success.json',
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successful Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: SButton(
                width: double.infinity,
                title: 'Back to home page',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
