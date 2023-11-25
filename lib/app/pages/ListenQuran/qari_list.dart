import 'package:flutter/material.dart';
import 'package:quran2/app/pages/ListenQuran/quran_list_audio.dart';
import 'package:provider/provider.dart';

import '../../customewidget/customtextField.dart';
import '../../models/model_quran_reader.dart';
import '../../statemanagment/quranProvider.dart';

List<Qari>? quranreader;
List<Qari>? filter;

class QariList extends StatefulWidget {
  const QariList({super.key});
  @override
  State<QariList> createState() => _QariListState();
}

class _QariListState extends State<QariList> {
  void updatelist(String value) {
    setState(() {
      filter = quranreader
          ?.where((element) =>
              element.arabicName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Quran>(context);
    quranreader ??= model.quranreader;
    filter ??= quranreader;
    double height = MediaQuery.of(context).size.height - 230;
    return SafeArea(
        child: ListView(
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            child: CustomTextField(
              onchange: (value) => updatelist(value),
            )),
        SizedBox(
            height: height,
            child: ListView.builder(
              itemCount: filter!.length,
              itemBuilder: (context, i) {
                return ListTileQuranReader(readerinformation: filter![i]);
              },
            ))
      ],
    ));
  }
}

class ListTileQuranReader extends StatelessWidget {
  final Qari readerinformation;
  const ListTileQuranReader({super.key, required this.readerinformation});
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Quran>(context);
    return Hero(
      tag: "tag",
      child: Card(
        child: InkWell(
          onTap: () async {
            model.relvaationreader = "${readerinformation.relativePath}";
            model.qariname =
                readerinformation.arabicName ?? readerinformation.name;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const QuranListAudio();
              },
            ));
          },
          child: ListTile(
            
            title: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${readerinformation.arabicName ?? readerinformation.name}",
                          style: const TextStyle(
                            fontFamily: "me_quran",
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${readerinformation.name ?? readerinformation.arabicName}",
                          style: const TextStyle(
                            fontFamily: "me_quran",
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),)
      ),
    );
  }
}
