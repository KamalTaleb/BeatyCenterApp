import 'package:beauty_center/appbar.dart';
import 'package:beauty_center/cart_menu_icon.dart';
import 'package:beauty_center/curved_edge.dart';
import 'package:beauty_center/curved_edge_widget.dart';
import 'package:beauty_center/home_appbar.dart';
import 'package:beauty_center/search_container.dart';
import 'package:beauty_center/primary_header_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'circular_container.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  // const SHomeAppBar(),
                  const SizedBox(
                    height: 32.0,
                  ),
                  SSearchContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
