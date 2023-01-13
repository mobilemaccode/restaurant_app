import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/Login.dart';
import 'dart:async';

import 'package:restaurant_app/screens/main_screen.dart';
import 'package:restaurant_app/screens/scan.dart';

class AudioScanner extends StatefulWidget {
  @override
  _AudioScannerState createState() => new _AudioScannerState();
}

class _AudioScannerState extends State<AudioScanner> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/HomeScreen');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ScanPage("1")));
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
        body: Container(
      color: Color(0xFF04101a),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(),
            Image.asset(
              'assets/scanner.gif',
            ),
          ],
        ),
      ),
    )
        /*Center(
        child: new Image.asset('assets/scanner.gif',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),*/

        /*body: new Center(
        child: new Image.asset('assets/images/splash_screen.png'),
      ),*/
        );
  }
}
