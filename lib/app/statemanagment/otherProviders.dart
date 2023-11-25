import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Other with ChangeNotifier {
  int? countopen;
  bool? isshowingrate;
  int? maxOpenToRate;
  bool? isFmOn;

  FirstUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("rateapp")) {
      countopen = prefs.getInt("rateapp");
      prefs.setInt("rateapp", countopen! + 1);
    } else {
      prefs.setInt("rateapp", 1);
    }
  }

  dontRateAgring() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("dontRateAgring", true);
    isshowingrate = true;
  }

  ifcontainsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return true;
    } else {
      return false;
    }
  }

  ifCancelRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSetCancelRate", true);
  }

  maxopenToRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("isSetCancelRate")) {
      maxOpenToRate = 10;
    } else {
      maxOpenToRate = 3;
    }
  }

  setCahgeBtnFm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("BtnFm") == true) {
      prefs.setBool("BtnFm", false);
      isFmOn = false;
    } else {
      prefs.setBool("BtnFm", true);
      isFmOn = true;
    }
  }
}
