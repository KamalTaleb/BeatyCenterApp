import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/custom/common/services/cart/cart_Items.dart';
import 'package:beauty_center/grid_layout.dart';
import 'package:beauty_center/screens/checkout.dart';
import 'package:beauty_center/screens/home.dart';
import 'package:beauty_center/screens/staff_check.dart';
import 'package:beauty_center/services_card_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SCartScreen extends StatelessWidget {
  const SCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppbar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const homePage()),
          );
        },
        showBackArrow: true,
        title: Text(
          'Services',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SGridLayout(
                  itemCount: 10,
                  itemBuilder: (_, index) => const SServicesCardHorizontal())
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SCheckStaff(),
              ),
            );
          },
          child: const Text('Checkout \$213.0'),
        ),
      ),
    );
  }
}
