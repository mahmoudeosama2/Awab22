import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:quran2/app/pages/praise/azkar.dart';
import 'package:quran2/app/pages/radio/radiofm.dart';
import 'package:workmanager/workmanager.dart';

import '../start/splashscreen.dart';
import 'ListenQuran/qari_list.dart';
import 'athan/athan.dart';
import 'compass/compass.dart';
import 'quran/home_page.dart';
import 'package:hijri/hijri_calendar.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  void initState() {
    // _onappreview();

    super.initState();
  }

  int index = 2;

  final NavigationKey = GlobalKey<CurvedNavigationBarState>();
  final _today = HijriCalendar.now();
  final List<Widget> _widgetsList = [
    const HomePage(),
    const QariList(),
    const Athan(),
    const AzkarHome(),
    const RadioFm(),
    const Compass(),
  ];
  List<Widget> items = [
    const Icon(Icons.auto_stories, size: 30, color: Colors.white),
    const Icon(Icons.music_note, size: 30, color: Colors.white),
    SizedBox(
        height: 40,
        child: Image.asset(
          "asset/icons/prayert.png",
          color: Colors.white,
          width: 40,
        )),
    SizedBox(
        height: 28,
        child: Image.asset(
          "asset/icons/rosary.png",
          color: Colors.white,
          width: 28,
        )),
    SizedBox(
        height: 35,
        child: Image.asset(
          "asset/images/radiofm.png",
          color: Colors.white,
          width: 35,
        )),
    const Icon(Icons.explore, size: 30, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    print("yes");
                    Workmanager().initialize(callbackDispatcher);

                    Workmanager().registerPeriodicTask(
                      "1",
                      "الف مبروو",
                      frequency: Duration(minutes: 15),
                    );
                  },
                  child: Text(_today.toFormat("dd MMMM yyyy"))),
            ],
          ),
          backgroundColor: const Color(0xff095263),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 75.0,
          key: NavigationKey,
          animationDuration: const Duration(milliseconds: 400),
          color: const Color(0xff095263),
          backgroundColor: Colors.transparent,
          items: items,
          index: index,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
        ),
        body: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: _widgetsList[index]));
  }
}

_onappreview() async {
  final InAppReview inAppReview = InAppReview.instance;

  if (await inAppReview.isAvailable()) {
    inAppReview.openStoreListing(
        microsoftStoreId:
            "https://play.google.com/store/apps/details?id=com.onatcipli.awab");
  }
}
