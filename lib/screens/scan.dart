import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/data.dart';

class ScanPage extends StatefulWidget {
  //ScanPage({Key key, this.status}) : super(key: key);
  //final String status;
  final String status;
  ScanPage(this.status,);

  @override
  _ScanPageState createState() => _ScanPageState(status);
}

class _ScanPageState extends State<ScanPage> {
  final String status;
  _ScanPageState(this.status,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 20),
          children: <Widget>[
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      child: Text(
                        "Scan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    // Icon(Icons.star, size: 50),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.close),
                      highlightColor: Colors.pink,
                      onPressed: () {
                        if(status == "1"){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeIndex()),
                          );
                        }else
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            SizedBox(
              height: 15,
            ),


            Center(
              child: Text(
                "In the above configuration, the package is setup to replace the existing launcher icons",
                maxLines: 2,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 80,
            ),


            IconButton(
              icon: new Image.asset(
                'assets/images/image_qr.png',
                height: 180,
                width: 180,
              ),///Icon(Icons.camera_alt),
              highlightColor: Colors.pink,
              iconSize: 180,
              onPressed: () {
                //Navigator.pop(context);
              },
            ),

            Center(
              child: Text(
                "Scan Image or QR Code",
                style: TextStyle(color: Color(0xFFf18a01), fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: 20,
            ),




            Center(
              child:  RaisedButton(
                onPressed: () {
                  if(status == "1"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeIndex()),
                    );
                  }else
                    Navigator.pop(context);
                },
                color: Colors.blue.shade600,
                padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Text(
                  "Browse Restaurant",
                  style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      )

    );
  }
}
