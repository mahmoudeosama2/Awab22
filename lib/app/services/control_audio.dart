import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

AudioPlayer _player = AudioPlayer();
bool status = false;
removebasmal(String word) {
  String result = word.replaceAll("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ", "");
  result = word.replaceAll("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ", "");
  if (result.length < 2) {
    return null;
  } else {
    return result;
  }
}

Future getaudio(url) async {
  await _player.play(UrlSource(url));
}

void audiodisbose() async {
  if (status == true) {
    await _player.dispose();
    status = false;
  }
}

Future pauseaudio() async {
  await _player.pause();
}

removetachkil(var str) {
  List tachkil = ['ِ', 'ُ', 'ٓ', 'ٰ', 'ْ', 'ٌ', 'ٍ', 'ً', 'ّ', 'َ', ' ّ'];

  for (var element in tachkil) {
    str = str.replaceAll(element, "");
  }
  return str;
}

setprefs(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

setprefsbool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

getprefs(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if ( prefs.containsKey(key)) {
     return prefs.getBool(key);
  }

}
