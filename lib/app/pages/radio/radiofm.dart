import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran2/app/services/control_audio.dart';

import '../../statemanagment/otherProviders.dart';

class RadioFm extends StatefulWidget {
  const RadioFm({super.key});

  @override
  State<RadioFm> createState() => _ViewSurahtate();
}

class _ViewSurahtate extends State<RadioFm> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool? _isplay;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // model.radio_play_pause_icon != null
    //     ? _isplay = model.radio_play_pause_icon!
    //     : print("");

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> onBackPressed() {
    dispose();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Other>(context);
    _isplay = model.isFmOn;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: WillPopScope(
            onWillPop: onBackPressed,
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                    padding: const EdgeInsets.only(
                      top: 100,
                      bottom: 100,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "إذاعة القرءان الكريم",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 33,
                            color: Color(0xff095263),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            "asset/images/radio-tower_9421452.png",
                            color: const Color(0xff095263),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            change_icon();
                          },
                          child: AnimatedIcon(
                            progress: _controller,
                            size: 80,
                            icon: AnimatedIcons.play_pause,
                            color: const Color(0xff095263),
                          ),
                        )
                      ],
                    )))));
  }

  change_icon() {
    if (_isplay == false) {
      _controller.forward();
      getaudio("https://stream.radiojar.com/8s5u5tpdtwzuv");
      _isplay = true;
    } else {
      _controller.reverse();
      pauseaudio();
      _isplay = false;
    }
    setprefsbool("play_pause_choose", _isplay!);
  }
}
