import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Praise with ChangeNotifier {
  String alreadyexis = "Erorr : This Praise Already Existing";
  int? total;
  int num = 0;
  List<List<String>>? praiseslist = [];

  count(String zekr, int index) {
    total = total! + 1;
    num = num + 1;
    praiseslist![index][1] = (int.parse(praiseslist![index][1]) + 1).toString();
    countpraise(zekr);
    notifyListeners();
  }

  void addPraisesName(String zekr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> praises = [];
    if (prefs.getStringList("praises") == null) {
      praises.add(zekr);
      prefs.setStringList("praises", praises);
    } else {
      praises = prefs.getStringList("praises")!;
      praises.add(zekr);
      await prefs.remove("praises");
      prefs.setStringList("praises", praises);
    }
  }

  addPraise(String zekr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> alreadyExistingPraises = [];
    if (prefs.containsKey("praises") == false) {
      addPraisesName(zekr);
      praiseslist?.add([zekr, "0"]);
      prefs.setStringList(zekr, [zekr, "0"]);
    } else {
      alreadyExistingPraises = prefs.getStringList("praises")!;
      if (alreadyExistingPraises.contains(zekr)) {
        return print(alreadyexis);
      } else {
        addPraisesName(zekr);
        praiseslist?.add([zekr, "0"]);
        prefs.setStringList(zekr, [zekr, "0"]);
      }
      notifyListeners();
    }
  }

  countpraise(String zekr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int temp;
    temp = 0;
    List<String> praise = [];
    praise = prefs.getStringList(zekr)!;
    temp = int.parse(praise[1]) + 1;
    prefs.remove(zekr);
    prefs.setStringList(zekr, [zekr, temp.toString(), "0"]);
    notifyListeners();
    return praise;
  }

  void deletepraise(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listpraises = prefs.getStringList("praises")!;
    listpraises.remove(key);
    prefs.setStringList("praises", listpraises);
    praiseslist?.removeWhere((element) => element[0] == key);
    notifyListeners();
    await prefs.remove(key);
  }

  Future<List<List<String>>> showallpraises() async {
    List<String>? temp;
    List<String> praisesName = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<List<String>> allpraises = [];
    if (prefs.getStringList("praises") != null) {
      praisesName = prefs.getStringList("praises")!;
      // ignore: unnecessary_null_comparison
      if (praisesName != null) {
        for (var element in praisesName) {
          temp = prefs.getStringList(element)!;
          allpraises.add(temp);
          temp = null;
        }
      } else {
        print("error get all prises name");
      }
      praiseslist = null;
      praiseslist = allpraises;
      notifyListeners();
    }

    return allpraises;
  }

  void reset(String zekr, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(zekr, [zekr, "0"]);
    praiseslist![index][1] = (0).toString();
    num = 0;
    total = 0;
    notifyListeners();
  }
}

//---------------------------------------------------------------------------------


