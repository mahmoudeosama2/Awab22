import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart ';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:quran2/app/statemanagment/otherProviders.dart';
import 'app/pages/quran/home_page.dart';
import 'app/pages/navigationbar.dart';
import 'app/statemanagment/radioprovider.dart';
import 'start/splashscreen.dart';
import 'app/statemanagment/athanTimeProvider.dart';
import 'app/statemanagment/praiseProvider.dart';
import 'app/statemanagment/quranProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff095263),
      systemNavigationBarColor: Colors.transparent));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Praise()),
      ChangeNotifierProvider(create: (context) => Quran()),
      ChangeNotifierProvider(create: (context) => AthanTime()),
      ChangeNotifierProvider(create: (context) => Radioprovider()),
      ChangeNotifierProvider(create: (context) => Other())
    ],
    child: const StartApp(),
  ));
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return MaterialApp(
          initialRoute: 'splashscreen',
          debugShowCheckedModeBanner: false,
          routes: {
            'splashscreen': ((context) => const splashscreen()),
            'NavigatorBar': ((context) => const NavigatorBar()),
            'HomePage': ((context) => const HomePage()),
          },
          theme: ThemeData(
            primaryColor: const Color(0xff095263),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff095263))),
            ),
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              displayMedium: TextStyle(
                fontFamily: "Cairo",
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              displaySmall: TextStyle(
                fontFamily: "Cairo",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              headlineMedium: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "Cairo",
              ),
            ),
          ));
    });
  }
}
