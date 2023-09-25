import 'package:quran2/app/pages/ListenQuran/audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../customewidget/custom_counter.dart';
import '../../customewidget/customtextField.dart';
import '../../models/model_complete_quran.dart';
import '../../services/control_audio.dart';
import '../../statemanagment/quranProvider.dart';

List<Surahs>? surah;
List<Surahs>? filter;

class QuranListAudio extends StatefulWidget {
  const QuranListAudio({super.key});
  @override
  State<QuranListAudio> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranListAudio> {
  void updatelist(String value) {
    setState(() {
      filter = surah
          ?.where((element) => removetachkil(element.name)
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Quran>(context);
    surah ??= model.surahs;
    filter ??= surah;

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
          ),
        ],
        toolbarHeight: 50,
        backgroundColor: const Color(0xff095263),
        elevation: 0,
      ),
      body: Hero(
        tag: "tag",
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 7, left: 10, right: 10),
                child: CustomTextField(
                  onchange: (value) => updatelist(value),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: filter!.length,
                itemBuilder: (context, i) {
                  return List_of_surah(
                    index: i,
                    quran: filter![i],
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class List_of_surah extends StatelessWidget {
  final quran;
  final index;
  const List_of_surah({super.key, required this.quran, required this.index});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Quran>(context);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              model.getList();
              return AudioPlayerScreen(
                index: index,
                audioSourceList: model.audioSourceList,
              );
            },
          ));
        },
        child: ListTile(
            trailing: Text(
              quran.name,
              style: const TextStyle(
                fontFamily: "me_quran",
                fontSize: 22,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            title: Text(
              quran.englishName,
              style: const TextStyle(
                fontFamily: "me_quran",
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(quran.revelationType),
            leading: CounterIcons(
              num: quran.number,
            )),
      ),
    );
  }
}
