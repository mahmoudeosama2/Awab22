import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:quran2/app/pages/drawerHome/setting.dart';
import 'package:quran2/app/pages/praise/azkar.dart';
import 'package:quran2/app/pages/radio/radiofm.dart';
import 'ListenQuran/qari_list.dart';
import 'athan/athan.dart';
import 'compass/compass.dart';
import 'quran/home_page.dart';
import 'package:hijri/hijri_calendar.dart';

class ZoomDrawerBeforeNavigatBar extends StatelessWidget {
  const ZoomDrawerBeforeNavigatBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      angle: 0,
      mainScreenScale: 0.1,
      menuScreen: MenuScreenPage(),
      mainScreen: NavigatorBar(),
      borderRadius: 24.0,
      showShadow: true,
      duration: const Duration(milliseconds: 500),
      menuBackgroundColor: Color(0xff095263),
      closeCurve: Curves.bounceIn,
    );
  }
}

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  void initState() {
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
        extendBody: true,
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => ZoomDrawer.of(context)!.toggle(),
              child: Icon(Icons.menu)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 50,
          title: Text(_today.toFormat("dd MMMM yyyy")),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff095263),
                      Color(0xff095263),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)))),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 75.0, // change this value to be between 0 and 75.0
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
            height: double.infinity,
            color: Colors.white,
            width: double.infinity,
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

class ZoomDrwer extends StatefulWidget {
  const ZoomDrwer({super.key});

  @override
  State<ZoomDrwer> createState() => _ZoomDrwerState();
}

class _ZoomDrwerState extends State<ZoomDrwer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        // controller: drawerController,
        style: DrawerStyle.style1,
        menuScreen: MenuScreenPage(),
        mainScreen: NavigatorBar(),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        mainScreenOverlayColor: Theme.of(context).primaryColor,
        menuScreenOverlayColor: Theme.of(context).primaryColor,
        duration: const Duration(milliseconds: 500),
        menuBackgroundColor: Theme.of(context).primaryColor,

        slideWidth: MediaQuery.of(context).size.width * 0.65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}

class MenuScreenPage extends StatelessWidget {
  const MenuScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 60,
            width: 65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            alignment: Alignment.center,
            child: const Text(
              'H',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'الاشعارات',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.bedtime_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'الوضع المظلم',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_mark_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'حول',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Setting();
                    },
                  ));
                },
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  'الاعدادات',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  exit(0);
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  'خروج',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
