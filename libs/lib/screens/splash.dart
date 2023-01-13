import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/Login.dart';
import 'package:restaurant_app/screens/audio_scanner.dart';
import 'dart:async';
import 'package:restaurant_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    final prefs = await SharedPreferences.getInstance();
    //final key = 'my_int_key';
    var userId = prefs.getString("user_id") ?? 0;
    print(userId);
    print('userId $userId');

    //prefs.setString("user_id", "0");
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage(userId));
  }

  navigationPage(var userId) {
    //Navigator.of(context).pushReplacementNamed('/HomeScreen');
    print('userId $userId');
    if (userId != 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AudioScanner()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
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
      body: Center(
        child: new Image.asset(
          'assets/images/splash_screen.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
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
