import 'package:flutter/material.dart';
import 'my_custuom_clip_topbar.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomTopClipper(),
      child: Container(
        color: const Color(0xff095263),
        height: 300,
      ),
    );
  }
}
