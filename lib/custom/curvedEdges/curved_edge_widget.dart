import 'package:beauty_center/custom/curvedEdges/curved_edge.dart';
import 'package:flutter/material.dart';

class SCurvedEdgeWidget extends StatelessWidget {
  const SCurvedEdgeWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SCustomCurvedEdges(),
      child: child,
    );
  }
}
