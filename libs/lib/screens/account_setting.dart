import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/account_address.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/CustomUtils.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter/foundation.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  // var orderType = false;
  bool orderType = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
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
            "Account Setting",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountAddress()),
                  ); /*setState(() {});*/
                },
                child: Container(
                  padding: EdgeInsets.all(12), //only(right: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Address",
                        maxLines: 2,
                        softWrap: true,
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(fontSize: 20),
                      ),
                      // Spacer(),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountAddress()),
                  ); /*setState(() {});*/
                },
                child: Container(
                  padding: EdgeInsets.all(12), //only(right: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Payment",
                        maxLines: 2,
                        softWrap: true,
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(fontSize: 20),
                      ),
                      // Spacer(),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountAddress()),
                  ); /*setState(() {});*/
                },
                child: Container(
                  padding: EdgeInsets.all(12), //only(right: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "App Setting",
                        maxLines: 2,
                        softWrap: true,
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(fontSize: 20),
                      ),
                      // Spacer(),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
