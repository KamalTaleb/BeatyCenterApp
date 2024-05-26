import 'package:beauty_center/circular_container.dart';
import 'package:beauty_center/custom/curvedEdges/curved_edge_widget.dart';
import 'package:flutter/material.dart';

class SPrimaryHeaderContainer extends StatelessWidget {
  const SPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SCurvedEdgeWidget(
      child: Container(
        color: Colors.teal[700],
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 300,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: SCircularContainer(
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: SCircularContainer(
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
