import 'package:flutter/material.dart';
import 'package:restaurant_app/BookYourTable/book_your_table.dart';
import 'package:restaurant_app/screens/Login.dart';
import 'dart:async';

import 'package:restaurant_app/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/HomeScreen');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookYourTable(),
        ));
    //  MaterialPageRoute(builder: (context) => Login()),
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          new Image.asset(
            'assets/images/splash_screen.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ],
      ),

      /*Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/splash_screen.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),*/

      /*body: new Center(
        child: new Image.asset('assets/images/splash_screen.png'),
      ),*/
    );
  }
}
