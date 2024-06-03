import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/screens/cart.dart';
import 'package:beauty_center/screens/staff_view_as_grid.dart';
import 'package:beauty_center/staff_view_as_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SCheckStaff extends StatelessWidget {
  const SCheckStaff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: SAppbar(
          onPressed: () {
            Get.to(() => const SCartScreen());
          },
          showBackArrow: true,
          title: Text(
            'Choose Your Professional',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: StaffViewAsGrid(selectedServices: [], userId: null,),
      ),
    );
  }
}
