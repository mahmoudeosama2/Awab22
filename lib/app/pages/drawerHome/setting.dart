import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBarwithIcon(),
    );
  }
}

class CustomAppBarwithIcon extends StatelessWidget {
  final icon;
  const CustomAppBarwithIcon({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Theme.of(context).primaryColor,
      width: double.infinity,
      height: 130,
      child: Column(
        children: [
          Container(height: 75, color: Colors.green, child: Row(children: [])),
          Container(height: 55, color: Colors.red, child: Row(children: [])),
        ],
      ),
    );
  }
}
