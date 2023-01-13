import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:restaurant_app/screens/Register.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter/foundation.dart';

class OTPVerification extends StatefulWidget {
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final TextEditingController _controller = new TextEditingController();

  // var orderType = false;
  bool orderType = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFf18a01),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "OTP",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 5),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text("        OTP \n   Verification",
                    maxLines: 2,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 40,
                ),
                Text(
                    "Please enter a valid phone number\n to create your new Account",
                    maxLines: 2,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 40,
                ),
                /*Text(
                    "Or Sign up with Social network",
                    maxLines: 2,
                    // softWrap: true,
                    style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.normal)
                ),*/
                SizedBox(
                  child: Text(
                    "-    -    -    -",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Resend OTP?",
                    maxLines: 2,
                    // softWrap: true,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFf18a01),
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity, // match_parent
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xFFf18a01))),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    color: Color(0xFFf18a01),
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Submit".toUpperCase(),
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
