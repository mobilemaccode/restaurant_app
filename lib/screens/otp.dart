import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:restaurant_app/screens/otp_verification.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter/foundation.dart';

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
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
                Text("Create New \n   Account",
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
                Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
                  new TextField(
                    controller: _controller,
                    decoration: new InputDecoration(
                        labelText: "Enter your Mobile number"),
                    //decoration: new InputDecoration.collapsed(hintText: 'Mobile number'),
                    keyboardType: TextInputType.phone,
                  ),
                  new FlatButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      child: new Icon(Icons.clear))
                ]),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTPVerification()),
                      );
                    },
                    color: Color(0xFFf18a01),
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Next".toUpperCase(),
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
