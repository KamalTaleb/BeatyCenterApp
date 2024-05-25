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
          ],
        ),
      ),
    );
  }
}
