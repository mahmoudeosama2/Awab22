import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quran2/app/pages/athan/prayertime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../statemanagment/athanTimeProvider.dart';


Prayertime prayertime = Prayertime();
LocationPermission? permission;
bool IsSmallSize = false;
List<String> salawat = [
  "صلاة الفجر",
  "صلاة الشروق",
  "صلاة الظهر",
  "صلاة العصر",
  "صلاة المغرب",
  "صلاة العشاء"
];
String? city;

class Athan extends StatefulWidget {
  const Athan({Key? key}) : super(key: key);

  @override
  State<Athan> createState() => _AthanState();
}

class _AthanState extends State<Athan> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();
  get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context).width < 360.0 ||
            MediaQuery.sizeOf(context).height < 770.0
        ? IsSmallSize = true
        : IsSmallSize = false;

    var model = Provider.of<AthanTime>(context);
    if (model.city != null) {
      city = model.city;
    }

    double height = MediaQuery.of(context).size.height - 210;
    List<String> governorates = [];

    for (int i = 0; i < model.governorate.length; i++) {
      governorates.add(model.governorate[i].governorateNameAr.toString());
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await model.handlePermission(false) == false) {
              if (model.msgError == "يرجي تفعل زر الوصول للموقع") {
                AwesomeDialog(
                  context: context,
                  btnOkColor: Theme.of(context).primaryColor,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  descTextStyle: const TextStyle(fontSize: 16),
                  desc: 'هل تريد تشغيل خدمة تحديد المواقع؟',
                  btnCancelOnPress: () {
                    Fluttertoast.showToast(
                      msg: "${model.msgError}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey[800],
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  btnOkOnPress: () {
                    model.openloctionset();
                  },
                ).show();
              } else {
                Fluttertoast.showToast(
                  msg: "${model.msgError}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.grey[800],
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            } else {
              model.city = null;
              city = model.city;
              await model.getMylocationTimes();
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.gps_fixed),
        ),
        body: IsSmallSize == true
            ? Container(
                margin: const EdgeInsets.only(
                  top: 100,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.only(
                  bottom: 40,
                ),
                height: height,
                child: Column(children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Opacity(
                        opacity: 1,
                        child: Image.asset(
                          "asset/images/prayertimeMosque.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff095263),
                                Color.fromARGB(209, 9, 82, 99),
                                Color.fromARGB(255, 194, 194, 194),
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                          ),
                          child: model.prayerstime == null &&
                                  model.handlePermission(false) == true
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: InkWell(
                                    onTap: () {
                                      print("asd");
                                    },
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: DropdownButton<String>(
                                          hint: Text("أختر المحافظة",
                                              style: TextStyle(
                                                color: Colors.grey[200],
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          iconEnabledColor: Colors.white,
                                          menuMaxHeight: 200,
                                          dropdownColor: Color(0xff095263),
                                          alignment: Alignment.center,
                                          value: city,
                                          items: governorates
                                              .map((String item) =>
                                                  DropdownMenuItem<String>(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      value: item,
                                                      child: Text(item,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[200],
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))))
                                              .toList(),
                                          onChanged: (item) {
                                            setState(() {
                                              city = item;
                                              model.getlatlongbycity(item!);
                                              model.city = city;
                                              model.getTimesByLatAndlong(
                                                model.coordinates![0],
                                                model.coordinates![1],
                                              );
                                            });
                                          },
                                        )),
                                        Expanded(
                                          flex: 8,
                                          child: MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: ListView.builder(
                                                itemCount: salawat.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    dense: true,
                                                    trailing: Text(
                                                      salawat[index],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[200],
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "me_quran"),
                                                    ),
                                                    leading: Text(
                                                      model.prayerstime![index],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[200],
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "me_quran"),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )))
                ]))
            : Container(
                margin: const EdgeInsets.only(
                  top: 100,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                height: height,
                child: Column(children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Opacity(
                        opacity: 1,
                        child: Image.asset(
                          "asset/images/prayertimeMosque.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff095263),
                                Color.fromARGB(209, 9, 82, 99),
                                Color.fromARGB(255, 194, 194, 194),
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                          ),
                          child: model.prayerstime == null &&
                                  model.handlePermission(false) == true
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: InkWell(
                                    onTap: () {
                                      print("asd");
                                    },
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: DropdownButton<String>(
                                          hint: Text("أختر المحافظة",
                                              style: TextStyle(
                                                color: Colors.grey[200],
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          iconEnabledColor: Colors.white,
                                          menuMaxHeight: 200,
                                          dropdownColor: Color(0xff095263),
                                          alignment: Alignment.center,
                                          value: city,
                                          items: governorates
                                              .map((String item) =>
                                                  DropdownMenuItem<String>(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      value: item,
                                                      child: Text(item,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[200],
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))))
                                              .toList(),
                                          onChanged: (item) {
                                            setState(() {
                                              city = item;
                                              model.getlatlongbycity(item!);
                                              model.city = city;
                                              model.getTimesByLatAndlong(
                                                model.coordinates![0],
                                                model.coordinates![1],
                                              );
                                            });
                                          },
                                        )),
                                        Expanded(
                                          flex: 8,
                                          child: MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: ListView.builder(
                                                // physics:
                                                //     NeverScrollableScrollPhysics(),
                                                itemCount: salawat.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    height: 50,
                                                    child: ListTile(
                                                      trailing: Text(
                                                        salawat[index],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[200],
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                "me_quran"),
                                                      ),
                                                      leading: Text(
                                                        model.prayerstime![
                                                            index],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[200],
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                "me_quran"),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )))
                ])));
  }
}
