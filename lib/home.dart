import 'package:beauty_center/curved_edge.dart';
import 'package:beauty_center/curved_edge_widget.dart';
import 'package:beauty_center/proimary_header_container.dart';
import 'package:flutter/material.dart';

import 'circular_container.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SPrimaryHeaderContainer(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
