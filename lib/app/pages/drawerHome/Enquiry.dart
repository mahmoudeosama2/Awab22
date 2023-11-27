import 'package:flutter/material.dart';

import '../../customewidget/CustomAppBarwithIcon.dart';
import '../../services/sharedprefrances.dart';

class Enquiry extends StatefulWidget {
  const Enquiry({super.key});

  @override
  State<Enquiry> createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomAppBarWithIcon(icon: Icons.question_mark_rounded),
          ],
        ));
  }
}
