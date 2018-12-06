import 'package:flutter/material.dart';
import 'package:kurikulumsmk/home.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new KurikulumSMKApp(),
      title: new Text('Kurikulum SMK',
      style: new TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      image: Image.asset('assets/logo.png'),
      backgroundColor: Colors.lightBlueAccent,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Now loading ..."),
      loaderColor: Colors.red
    );
  }
}