import 'dart:convert';
import 'package:flutter/services.dart%20';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../models/model_complete_quran.dart';
import '../models/model_quran_reader.dart';
import '../pages/ListenQuran/audio.dart';

class Quran with ChangeNotifier {
  List<Surahs> surahs = [];
  List<Qari> quranreader = [];
  List<AudioSource>? audioSourceList;
  var relvaationreader;
  var qariname;

  Future<List<Surahs>> ReadJsonCompleteQuran() async {
    final jsondata =
        await rootBundle.loadString("asset/json/complete_quran.json");
    Map<String, dynamic> json = jsonDecode(jsondata);
    json['data']['surahs'].forEach((element) {
      if (surahs.length < json['data']['surahs'].length) {
        surahs.add(Surahs.fromJson(element));
      }
    });
    return surahs;
  }

  Future<List<Surahs>> ReadJsonCompleteQuran2() async {
    final jsondata =
        await rootBundle.loadString("asset/json/hafs_smart_v8.json");
    Map<String, dynamic> json = jsonDecode(jsondata);
    json['data']['surahs'].forEach((element) {
      if (surahs.length < json['data']['surahs'].length) {
        surahs.add(Surahs.fromJson(element));
      }
    });
    return surahs;
  }

  Future<List<Qari>> ReadJsonQuranReader() async {
    final jsondata = await rootBundle.loadString("asset/json/quranreader.json");
    List<dynamic> json = jsonDecode(jsondata);
    for (var element in json) {
      if (quranreader.length < json.length) {
        quranreader.add(Qari.fromJson(element));
      }
    }
    quranreader.sort(
      (a, b) => a.name!.compareTo(b.name!),
    );
    return quranreader;
  }

  List<AudioSource> getList() {
    print("get list is on ========================================");
    audioSourceList = [];
    for (var element in surahs) {
      print(
          "https://download.quranicaudio.com/quran/$relvaationreader${correctindex(element.number)}.mp3");
      audioSourceList!.add(
        AudioSource.uri(
            Uri.parse(
                "https://download.quranicaudio.com/quran/$relvaationreader${correctindex(element.number)}.mp3"),
            tag: MediaItem(
                id: "${element.number}",
                title: "${element.name}",
                album: qariname)),
      );
    }
    
    print(audioSourceList!.length);
    return audioSourceList!;
  }
}
