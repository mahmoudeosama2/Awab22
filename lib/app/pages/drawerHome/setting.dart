import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../customewidget/CustomAppBarwithIcon.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CustomAppBarWithIcon(icon: Icons.settings),
      ],
    ));
  }
}
