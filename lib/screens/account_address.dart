import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/CustomUtils.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter/foundation.dart';

class AccountAddress extends StatefulWidget {
  @override
  _AccountAddressState createState() => _AccountAddressState();
}

class _AccountAddressState extends State<AccountAddress> {
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
            "Address",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12), //only(right: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 300,
                            child: Text(
                              "Home",
                              // maxLines: 1,
                              // softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 18),
                            ),
                          ),
                          Text(
                            "In the above configuration, the package is setup to replace the existing launcher icons",
                            maxLines: 2,
                            // softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      flex: 3,
                    ),
                    new Flexible(
                      child: new Text(
                        "Delete",
                        style:
                            TextStyle(fontSize: 14, color: Colors.red.shade600),
                      ),
                      flex: 1,
                    ),
                    // Spacer(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(12), //only(right: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 300,
                            child: Text(
                              "Office",
                              // maxLines: 1,
                              // softWrap: true,
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(fontSize: 18),
                            ),
                          ),
                          Text(
                            "1233, In the above configuration, the package is setup to replace the existing launcher icons",
                            maxLines: 2,
                            // softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      flex: 3,
                    ),
                    new Flexible(
                      child: new Text(
                        "Delete",
                        style:
                            TextStyle(fontSize: 14, color: Colors.red.shade600),
                      ),
                      flex: 1,
                    ),
                    // Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  //Navigator.push(context, new MaterialPageRoute(builder: (context) => CheckOutPage()));
                },
                color: Colors.orange.shade600,
                padding:
                    EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Text(
                  "+ Add",
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
