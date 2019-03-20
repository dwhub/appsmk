// Background color : R:220 G:53 B:69

import 'package:flutter/material.dart';
import 'package:kurikulumsmk/UI/tabs/contact_person.dart';
import 'package:kurikulumsmk/UI/tabs/curriculum_structure.dart';
import 'package:kurikulumsmk/UI/tabs/maklumat.dart';
import 'package:kurikulumsmk/UI/tabs/school_data.dart';
import 'package:kurikulumsmk/UI/tabs/standar.dart';
import 'package:kurikulumsmk/UI/tabs/ujian_nasional.dart';
import 'package:kurikulumsmk/utils/rich_text_view.dart';

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
    return Container( 
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Kurikulum SMK"),
          elevation: .1,
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: OrientationBuilder(
            builder: (context, orientation) {
                double displayHeight = MediaQuery.of(context).size.height;
                double displayWidth = MediaQuery.of(context).size.width;

                int axisCount = orientation == Orientation.portrait ? 2 : 3;

                if (displayWidth > 600 && displayHeight >= 768) {
                  axisCount = 4;
                }
                return GridView.count(
                crossAxisCount: axisCount,
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  makeDashboardItem("Standar Nasional Pendidikan SMK/MAK", Icons.collections_bookmark, "sn", context),
                  makeDashboardItem("Spektrum Struktur Kurikulum KI & KD", Icons.list, "kr", context),
                  makeDashboardItem("Ujian Nasional 2019", Icons.book, "unas", context),
                  makeDashboardItem("Data Sekolah", Icons.school, "sk", context),
                  makeDashboardItem("Contact Person", Icons.contacts, "ct", context),
                  makeDashboardItem("Maklumat", Icons.info_outline, "mk", context)
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon, String code, BuildContext context) {
    //double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;

    EdgeInsets paddingCard = EdgeInsets.all(15.0);
    double iconBoxHeight = 30.0;
    double iconSize = 55.0;
    EdgeInsets titlePadding = EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0);

    if (displayWidth > 375 && displayWidth <= 414) {
      // iPhone 5.5 inch - iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus
      paddingCard = EdgeInsets.all(20.0);
      iconBoxHeight = 28;
      iconSize = 50;
    } else if (displayWidth > 320 && displayWidth <= 375) {
      // iPhone 4.7 inch - iPhone 6, iPhone 6S, iPhone 7, iPhone 8
      paddingCard = EdgeInsets.all(15.0);
      iconBoxHeight = 25;
      iconSize = 50;
    } else if (displayWidth <= 320) {
      // iPhone 4-inch - iPhone 5, iPhone 5S, iPhone 5C, iPhone SE
      // iPhone 3.5-inch - iPhone 4, iPhone 4S
      paddingCard = EdgeInsets.all(10.0);
      iconBoxHeight = 20;
      iconSize = 40;
      titlePadding = EdgeInsets.only(left: 5.0, right: 5.0, bottom: 8.0);
    } else if (displayWidth > 414 && displayWidth <= 568) {
      // Landscape
      // iPhone 4-inch - iPhone 5, iPhone 5S, iPhone 5C, iPhone SE
      // iPhone 3.5-inch - iPhone 4, iPhone 4S
      paddingCard = EdgeInsets.all(20.0);
      iconBoxHeight = 40;
      iconSize = 40;
    } else if (displayWidth > 568) {
      // Landscape - rest of iPhone
      paddingCard = EdgeInsets.all(20.0);
      iconBoxHeight = 40;
      iconSize = 40;
    }

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      color: Color.fromRGBO(220, 53, 69, 1.0),
      elevation: 1.0,
      margin: paddingCard,
      child: Container(
        //decoration: BoxDecoration(color: Color.fromRGBO(220, 53, 69, 1.0)),
        child: InkWell(
          onTap: () {
            menuInkWell(code, context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: iconBoxHeight),
              Center(
                child: Icon(
                icon,
                size: iconSize,
                color: Colors.white,
              )),
              //SizedBox(height: 10.0),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: titlePadding,
                    child: RichTextView(
                        text: title,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                    )
                        //style:
                        //    TextStyle(fontSize: 15.0, color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void menuInkWell(String code, BuildContext context) {
    if (code == "kr") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KurikulumScreen(),
        ),
      );
    } else if (code == "sk") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DataSekolahScreen(),
        ),
      );
    } else if (code == "ct") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactScreen(),
        ),
      );
    } else if (code == "mk") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MaklumatScreen(),
        ),
      );
    } else if (code == "unas") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NationalExamScreen(),
        ),
      );
    } else if (code == "sn") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NationalEducationScreen(),
        ),
      );
    }
  }
}
