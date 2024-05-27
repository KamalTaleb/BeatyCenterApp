import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/screens/cart.dart';
import 'package:beauty_center/staff_view_as_grid.dart';
import 'package:flutter/material.dart';

class SCheckStaff extends StatelessWidget {
  const SCheckStaff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: SAppbar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SCartScreen()),
            );
          },
          showBackArrow: true,
          title: Text(
            'Choose Your Professional',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: const ViewAsGrid(),
      ),
    );
  }
}
