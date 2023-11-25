import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quran2/app/pages/praise/zekr.dart';
import 'package:provider/provider.dart';

import '../../services/sharedprefrances.dart';
import '../../statemanagment/praiseProvider.dart';

var whereempty;
String? newpraise;

class AzkarHome extends StatefulWidget {
  final totalzekr;
  const AzkarHome({super.key, this.totalzekr});

  @override
  State<AzkarHome> createState() => _PraiseState();
}

class _PraiseState extends State<AzkarHome> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Praise>(context);
    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0))),
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Form(
                          key: _globalKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: TextFormField(
                                    cursorColor: const Color(0xff095263),
                                    onSaved: (newValue) {
                                      newpraise = newValue!;
                                    },
                                    textAlign: TextAlign.center,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      hintText: '   أسم الإستغفار   ',
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xff095263)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff095263)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _globalKey.currentState!.save();

                                      model.addPraise(newpraise!);

                                      Navigator.of(context).pop();
                                      setState(() {});
                                    },
                                    child: const Text("حفظ")),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ));
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: model.praiseslist!.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onLongPress: () {
                    AwesomeDialog(
                      context: context,
                      btnOkColor: Theme.of(context).primaryColor,
                      dialogType: DialogType.question,
                      btnCancelText: "لا",
                      btnOkText: "نعم",
                      animType: AnimType.scale,
                      desc: 'هل تريد حذف التسبيح ؟',
                      btnOkOnPress: () {
                        model.deletepraise(model.praiseslist![index][0]);
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  onPressed: () {
                    model.total = int.parse(model.praiseslist![index][1]);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ContZekr(
                          zekr: model.praiseslist![index],
                          index: index,
                        );
                      },
                    ));
                  },
                  child: ListTile(
                      title: Text(
                        textDirection: TextDirection.rtl,
                        model.praiseslist![index][0],
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "ElMessiri"),
                      ),
                      leading: Text(
                        model.praiseslist![index][1],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "ElMessiri"),
                      )),
                ));
          },
        ));
  }

  showBottomSheet() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                          cursorColor: const Color(0xff095263),
                          onSaved: (newValue) {
                            newpraise = newValue!;
                          },
                          textAlign: TextAlign.center,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: '   أسم الإستغفار   ',
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xff095263)),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xff095263)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () async {
                            _globalKey.currentState!.save();
                            await addPraise(newpraise!);
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text("Save")),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ));
  }
}
