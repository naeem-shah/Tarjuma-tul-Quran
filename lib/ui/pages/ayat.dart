import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:tarjuma_tul_quran/quran_data/data.dart';

class Ayat extends StatelessWidget {
  final int index;

  const Ayat({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            QuranData.surahNameEng[index],
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          itemBuilder: (_, int index) {
            String quran = surahQuran[index];
            String translation = translations[index];

            int? ayatNo;

            if (![0, 8].contains(this.index) && index == 0) {
              ayatNo = null;
            } else {
              ayatNo = [0, 8].contains(this.index) ? index+1 : index;
            }
            return Card(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    leading: Text("${ayatNo ?? ""}"),
                    title: SelectableText(
                      quran.trim(),
                      style: const TextStyle(
                          fontFamily: "Noorehuda", fontSize: 24, height: 1.5),
                    ),
                    subtitle: SelectableText(translation,
                        style: const TextStyle(
                            fontFamily: "Jameel", fontSize: 22, height: 1.5)),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            FlutterClipboard.copy(quran)
                                .then((value) => toaster(context));
                          },
                          icon: const Icon(Icons.copy),
                          label: const Text("قرآن کاپی")),
                      TextButton.icon(
                          onPressed: () {
                            FlutterClipboard.copy(translation)
                                .then((value) => toaster(context));
                          },
                          icon: const Icon(Icons.copy),
                          label: const Text("ترجمہ کاپی")),
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: surahQuran.length,
        ),
      ),
    );
  }

  List<String> get surahQuran {
    final List<String> list = [];
    for (int i = QuranData.surahIndexInfo[index];
        i < QuranData.surahIndexInfo[index + 1];
        i++) {
      list.add(QuranData.quranArabic[i]);
    }
    return list;
  }

  List<String> get translations {
    final List<String> list = [];
    for (int i = QuranData.surahIndexInfo[index];
        i < QuranData.surahIndexInfo[index + 1];
        i++) {
      list.add(QuranData.translation[i]);
    }
    return list;
  }

  void toaster(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text(
        'Copy to Clipboard',
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
      duration: const Duration(milliseconds: 400),
      elevation: 4.0,
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * 0.2,
      shape: const StadiumBorder(),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
