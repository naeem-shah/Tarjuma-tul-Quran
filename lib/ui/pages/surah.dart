import 'package:flutter/material.dart';
import 'package:tarjuma_tul_quran/quran_data/data.dart';
import 'package:tarjuma_tul_quran/ui/pages/ayat.dart';

class Surah extends StatelessWidget {
  const Surah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("سورتیں",style: TextStyle(fontFamily: "Jameel")),centerTitle: true,),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
          itemBuilder: (_, int index){
            String quran = QuranData.surahName[index];
            return Card(
              child: ListTile(
                leading: Text("${index+1}"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 18,),
                title: Text(quran.trim(),style: const TextStyle(fontFamily: "Noorehuda",fontSize: 24),),
                onTap: (){
                  Navigator.push (
                    context,
                    MaterialPageRoute (
                      builder: (BuildContext context) => Ayat(index: index,),
                    ),
                  );
                },
              ),
            );
          }, itemCount: QuranData.surahName.length,),
      ),
    );
  }
}
