import 'package:flutter/material.dart';

class CustomAppBarWithIcon extends StatelessWidget {
  final icon;
  const CustomAppBarWithIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Column(children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back))
        ]),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 100,
        title: CircleAvatar(
          minRadius: 30,
          maxRadius: 30,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
        ),
        flexibleSpace: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: 80,
            )
          ],
        ));
  }
}
