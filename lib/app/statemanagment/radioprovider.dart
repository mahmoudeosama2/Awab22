import 'package:flutter/material.dart';
import 'package:quran2/app/services/control_audio.dart';

class Radioprovider with ChangeNotifier {
  bool? radio_play_pause_icon;

  void play_pause_choose(){
    
      radio_play_pause_icon = getprefs("play_pause_choose");
      
  }
}
