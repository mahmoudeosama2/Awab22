import 'package:flutter/material.dart';

import 'my_custom_clip _bottombar.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomBottomClipper(),
      child: Container(
        color: const Color(0xff095263),
        height: 300,
      ),
    );
  }
}
