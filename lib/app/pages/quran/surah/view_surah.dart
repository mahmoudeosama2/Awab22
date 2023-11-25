import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart%20';
import '../../../models/model_complete_quran.dart';
import '../../../services/control_audio.dart';

List<Ayahs> ayahs = [];
ArabicNumbers arabicNumber = ArabicNumbers();
List<TextSpan>? textspan = [];
bool? isplay = false;
bool? skip = false;
List<bool> chngCol = [];

class ViewSurah extends StatefulWidget {
  final surah;
  const ViewSurah({super.key, required this.surah});
  @override
  State<ViewSurah> createState() => _ViewSurahtate();
}

class _ViewSurahtate extends State<ViewSurah> {
  @override
  void initState() {
    audiodisbose();
    chngCol.removeRange(0, chngCol.length);
    ayahs = widget.surah.ayahs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var model = Provider.of<Audioplayers>(context);

    totalayat() {
      textspan = [];
      bool test = false;
      removebasmal(ayahs[0].text!) == null ? test = true : test = false;

      for (int i = 0; i < ayahs.length; i++) {
        chngCol.add(false);

        if (test) {
          if (i != 0) {
            textspan!.add(TextSpan(children: <InlineSpan>[
              TextSpan(
                text: " ${ayahs[i].text!} ",
                style: TextStyle(
                  color: chngCol[i] == true ? Colors.green : Colors.black,
                  fontSize: 20,
                  
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (isplay == false) {
                      chngcoloror = true;
                      chngCol[i] = chngcoloror!;
                      getaudio("${ayahs[i].audio}");
                      setState(() {
                        chngCol[i] = chngcoloror!;
                      });

                      isplay = true;
                    } else if (isplay == true) {
                      chngCol[i] = false;
                      pauseaudio();
                      isplay = false;
                    }

                    // callMyFunction();
                  },
                  
              ),
              TextSpan(
                text: " \uFD3F ${arabicNumber.convert(i)} \uFD3E",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ]));
          }
        } else {
          if (i == 0) {
            ayahs[i].text = removebasmal(ayahs[i].text!);
          }
          textspan!.add(TextSpan(children: <InlineSpan>[
            TextSpan(
              text: " ${ayahs[i].text!} ",
              style: TextStyle(
                color: chngCol[i] == true ? Colors.green : Colors.black,
                fontSize: 20,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (isplay == false) {
                    chngcoloror = true;
                    chngCol[i] = chngcoloror!;
                    getaudio("${ayahs[i].audio}");
                    setState(() {
                      chngCol[i] = chngcoloror!;
                    });

                    isplay = true;
                  } else if (isplay == true) {
                    chngCol[i] = false;
                    pauseaudio();
                    isplay = false;
                  }

                  // callMyFunction();
                },
            ),
            TextSpan(
              text: " \uFD3F ${arabicNumber.convert(i + 1)} \uFD3E",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ]));
          if (test == true) {
            textspan!.remove(0);
          }
        }
      }
      print(chngCol[1]);
    }

    totalayat();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    double width = MediaQuery.of(context).size.width;

    return Hero(
      tag: "surah${widget.surah.number}",
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: WillPopScope(
          onWillPop: () async {
            pauseaudio();
            return true;
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                actions: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff095263),
                            Color(0xff095263),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18))),
                    width: width,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Image.asset("asset/images/quranRail.png",
                                  color: Colors.grey.withOpacity(0.4),
                                  colorBlendMode: BlendMode.modulate),
                            )
                          ],
                        ),
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: Text(
                                    "${widget.surah.name}",
                                    style: const TextStyle(
                                      fontFamily: "me_quran",
                                      color: Colors.white,
                                      fontSize: 28,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "عدد الأيات : ${arabicNumber.convert(ayahs.length)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      Text(
                                        "الجزء : ${arabicNumber.convert(ayahs[1].juz)} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "رقم السوره : ${arabicNumber.convert(widget.surah.number)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      Text(
                                        widget.surah.revelationType == "Meccan"
                                            ? "نوع السوره : مكيه "
                                            : "نوع السوره : مدنيه ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    pauseaudio();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                toolbarHeight: 150,
                elevation: 0,
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(children: [
                    Center(
                        child: Container(
                      child: Text(
                        widget.surah.number == 9
                            ? ""
                            : "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                        style: const TextStyle(
                          fontFamily: "me_quran",
                          fontSize: 23,
                          color: Colors.black,
                        ),
                      ),
                    )),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "me_quran"),
                            children: textspan as List<TextSpan>)),
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}
