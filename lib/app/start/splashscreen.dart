import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:quran2/app/statemanagment/radioprovider.dart';
import 'package:workmanager/workmanager.dart';
import '../customewidget/bottombar.dart';
import '../customewidget/topbar.dart';
import '../notification/Local_notification.dart';
import '../pages/navigationbar.dart';
import '../statemanagment/athanTimeProvider.dart';
import '../statemanagment/praiseProvider.dart';
import '../statemanagment/quranProvider.dart';

List<Color> colors = [const Color(0xff095263)];

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future showNotification() async {
  int randomIndex = Random().nextInt(smallDo3a2.length - 1);
  var bigTextStyleInformation = BigTextStyleInformation(
      '${smallDo3a2[randomIndex]}'); //multi-line show style

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('$randomIndex', 'Awab',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          styleInformation: bigTextStyleInformation);

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin!.show(
    randomIndex,
    'Awab',
    smallDo3a2[randomIndex],
    platformChannelSpecifics,
  );
}

void callbackDispatcher() {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin!.initialize(
    initializationSettings,
  );
  Workmanager().executeTask((task, inputData) {
    showNotification();
    return Future.value(true);
  });
}

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Future.delayed(
       Duration(seconds: 3),
      () {
        var praisemodel = Provider.of<Praise>(context, listen: false);
        var quranmodel = Provider.of<Quran>(context, listen: false);
        var athan = Provider.of<AthanTime>(context, listen: false);
        var radio =Provider.of<Radioprovider>(context, listen: false);
        praisemodel.showallpraises();
        quranmodel.ReadJsonCompleteQuran();
        quranmodel.ReadJsonQuranReader();
        athan.ReadJsonGovernorateEgy();
        athan.lastprayertimes();
        radio.play_pause_choose();
        Workmanager().initialize(callbackDispatcher);
        Workmanager().registerPeriodicTask(
          "1",
          "",
          frequency: Duration(minutes: 15),
        );

        //super.initState();
      },
    ).then((value) => Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (ctx) => const NavigatorBar())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(height: 190, child: TopBar()),
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 180, bottom: 190),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: width,
                        child: const Image(
                            image: AssetImage("asset/images/Mosque.png"))),
                  ],
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  SizedBox(height: 190, child: BottomBar()),
                ],
              ),
            ],
          ),
        ));
  }
}
