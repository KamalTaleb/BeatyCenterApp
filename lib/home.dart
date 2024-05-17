import 'package:beauty_center/appbar.dart';
import 'package:beauty_center/curved_edge.dart';
import 'package:beauty_center/curved_edge_widget.dart';
import 'package:beauty_center/primary_header_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'circular_container.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  SAppbar(
                    title: Column(
                      children: [
                        Text(
                          "hello",
                        ),
                        Text(
                          "sanyar",
                        ),
                      ],
                    ),
                    actions: [
                      Stack(
                        children: [
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(Iconsax.shopping_bag),
                          // ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
