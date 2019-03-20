import 'package:flutter/material.dart';
import 'package:kurikulumsmk/home2.dart';
import 'package:kurikulumsmk/utils/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: KurikulumSMKApp(),
      /*title: Text('Kurikulum SMK',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'SourceCodeProMedium',
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 25.0
        ),),*/
      image: Image.asset('assets/splash.jpg', alignment: Alignment.center, fit: BoxFit.contain,),
      backgroundColor: Color.fromRGBO(233, 232, 230, 1.0),
      styleTextUnderTheLoader: TextStyle(color: Colors.red),
      photoSize: 100.0,
      onClick: ()=>print("Sedang Memuat ..."),
      loaderColor: Colors.red
    );
  }
}