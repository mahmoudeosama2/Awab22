import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/model_complete_quran.dart';
import '../models/model_quran_reader.dart';

class ApiServices {
  List<Surahs> surahs = [];
  List<Qari> quranreader = [];

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
}
