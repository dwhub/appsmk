import 'package:flutter/material.dart';
import 'package:kurikulumsmk/tabs/contact_person.dart';
import 'package:kurikulumsmk/tabs/data_sekolah.dart';
import 'package:kurikulumsmk/tabs/maklumat.dart';
import 'package:kurikulumsmk/tabs/struktur_kurikulum.dart';
import 'package:kurikulumsmk/tabs/ujian_nasional.dart';

class KurikulumSMKApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController( 
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kurikulum SMK"),
          centerTitle: true,
          bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.view_headline, size: 30.0)),
                Tab(icon: Icon(Icons.view_module, size: 30.0)),
                Tab(icon: Icon(Icons.explore, size: 30.0)),
                Tab(icon: Icon(Icons.bookmark, size: 30.0)),
                Tab(icon: Icon(Icons.ac_unit, size: 30.0)),
            ]),
          ),
          body: new TabBarView(children: [
            KurikulumScreen(),
            UjianNasionalScreen(),
            DataSekolahScreen(),
            ContactScreen(),
            MaklumatScreen()
          ])
      )
    );
  }
}

