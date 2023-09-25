import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import '../../statemanagment/praiseProvider.dart';

int? num;
int? totalcount;
String? _text;

class ContZekr extends StatefulWidget {
  final zekr;
  final index;
  const ContZekr({super.key, required this.zekr, this.index});

  @override
  State<ContZekr> createState() => _ContZekrtate();
}

class _ContZekrtate extends State<ContZekr> {
  @override
  void initState() {
    super.initState();

    totalcount = int.parse(widget.zekr[1]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var model = Provider.of<Praise>(context);
    return Scaffold(
      floatingActionButton: SpeedDial(
        closedForegroundColor: Theme.of(context).primaryColor,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Theme.of(context).primaryColor,
        labelsBackgroundColor: Colors.white,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.restore_rounded),
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            label: 'البدء من جديد',
            onPressed: () {
              AwesomeDialog(
                context: context,
                btnOkColor: Theme.of(context).primaryColor,
                dialogType: DialogType.infoReverse,
                animType: AnimType.scale,
                title: "تنبيه",
                desc: "هل تريد إعاده البدء من جديد",
                btnCancelText: "لا",
                btnOkText: "نعم",
                btnOkOnPress: () {
                  model.reset(widget.zekr[0], widget.index);
                },
                btnCancelOnPress: () {},
              ).show();
            },
            closeSpeedDialOnPressed: false,
          ),

          //  Your other SpeedDialChildren go here.
        ],
        child: const Icon(Icons.settings),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: height,
        backgroundColor: const Color(0xff095263),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(
            width: width,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Image.asset("asset/icons/prayer.png",
                              color: Colors.grey.withOpacity(0.5),
                              colorBlendMode: BlendMode.modulate),
                        )
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          bottom: 250, left: 15, right: 15),
                      child: Text(
                        "${widget.zekr[0]}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            height: 1.5,
                            fontFamily: "Cairo"),
                      )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              model.num = 0;

                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        Text("العدد  : ${model.num}"),
                        Text("إجمالي العدد : ${model.total}"),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    width: width,
                    height: height,
                    child: InkWell(
                      onTap: () {
                        model.count(widget.zekr[0], widget.index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: const Text(""),
    );
  }
}
