import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/tabs/contact_person.dart';
import 'package:kurikulumsmk/UI/tabs/school_data.dart';
import 'package:kurikulumsmk/UI/tabs/maklumat.dart';
import 'package:kurikulumsmk/UI/tabs/curriculum_structure.dart';
import 'package:kurikulumsmk/UI/tabs/ujian_nasional.dart';

class KurikulumSMKApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    KurikulumScreen(),
    //UjianNasionalScreen(),
    DataSekolahScreen(),
    ContactScreen(),
    MaklumatScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( 
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kurikulum SMK"),
          centerTitle: true,
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.blue,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.lightBlueAccent,
                textTheme: Theme
                    .of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.white))), // sets the inactive color of the `BottomNavigationBar`
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.list, size: 30.0), title: Text("Kurikulum")),
                //BottomNavigationBarItem(icon: Icon(Icons.class_, size: 30.0), title: Text("U.N.")),
                BottomNavigationBarItem(icon: Icon(Icons.school, size: 30.0), title: Text("Sekolah")),
                BottomNavigationBarItem(icon: Icon(Icons.contacts, size: 30.0), title: Text("Contact")),
                BottomNavigationBarItem(icon: Icon(Icons.info_outline, size: 30.0), title: Text("Maklumat")),
              ]),
          ),
      )
    );
  }

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}
