import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/filter_page.dart';
import 'package:restaurant_app/screens/map_restaurant.dart';
import 'package:restaurant_app/screens/notification_page.dart';
import 'package:restaurant_app/screens/restaurant_menu.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/util/data.dart';

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 10,right: 10),
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),

              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: new Image.asset(
                      'assets/images/qr.png',
                      height: 35,
                      width: 35,
                    ),//Icon(Icons.camera_alt),
                    highlightColor: Color(0xFFf18a01),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanPage("2")),
                      );
                    },
                  ),/*Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.black,
                  ),*/
                  ),
                  /*Image.asset(
                                  'assets/images/login_bg.png',
                                  width: double.infinity,
                                  //fit: BoxFit.fill,
                                ),*/

                /*  Padding(padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.notification_important,
                      size: 35,
                      color: Colors.grey,
                    ),),*/


                  IconButton(
                    icon: Icon(
                      Icons.notification_important,
                      size: 35,
                      color: Colors.grey,
                    ),//Icon(Icons.camera_alt),
                    highlightColor: Color(0xFFf18a01),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: furnitures.length,
              itemBuilder: (BuildContext context, int index) {
                Map furniture = furnitures[index];

                return Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 140,
                      width: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "${furniture["img"]}",
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: furnitures.length,
              itemBuilder: (BuildContext context, int index) {
                Map furniture = furnitures[index];
                return Padding(
                  padding: EdgeInsets.only(right: 15,left: 15),
                  child: GestureDetector(
                    onTap: () {
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return Details();
                          },
                        ),
                      );*/
                    },
                    child: Container(
                      //height: 50,
                      //width: double.infinity,
                      child:Text(
                        furniture['name'],
                        style: TextStyle(
                          //fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "29 RESTAURANT",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),

              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0),
                    child: IconButton(
                      icon: new Image.asset(
                        'assets/images/map.png',
                       height: 33,
                       width: 33,
                       color: Colors.grey,
                       // width: double.infinity,
                        //fit: BoxFit.fill,
                      ),//Icon(Icons.map,size: 35,),
                      highlightColor: Color(0xFFf18a01),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapRestaurant()),
                        );
                      },
                    ),
                  ),
                  /*Image.asset(
                                  'assets/images/login_bg.png',
                                  width: double.infinity,
                                  //fit: BoxFit.fill,
                                ),*/

                  IconButton(
                    icon: new Image.asset(
                      'assets/images/filter.png',
                      height: 35,
                      width: 35,
                    ),/*Icon(
                      Icons.tune,
                      size: 35,
                      color: Colors.black,
                    ),*///Icon(Icons.camera_alt),
                    highlightColor: Color(0xFFf18a01),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilterPage()),
                      );
                    },
                  ),


                ],
              ),
            ],
          ),
          Container(
            // height: 310,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: furnitures.length,
              itemBuilder: (BuildContext context, int index) {
                Map furniture = furnitures[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 5,),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return RestaurantMenu();
                          },
                        ),
                      );
                    },
                    child: Container(
                      // height: 50,
                      width: double.infinity,
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "${furniture["img"]}",
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  furniture['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                Text(
                                  furniture['name']+" This example",
                                  maxLines: 2,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "Test "+furniture['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.red.shade900),
                                ),

                              ],
                            ),
                          ),

                          SizedBox(width: 10),
                          Row(
                            children: <Widget>[
                              Icon(Icons.star,color: Color(0xFFf18a01),),
                              Text(
                                "4.5",//furniture['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFFf18a01)),
                              ),
                            ],
                          )


                          //  middleSection,
                        ],
                      ),
                    ),


                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  final middleSection = new Container(
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.access_time,
                color: Colors.grey,
                size: 20,
              ),
              new Text("2 mint"),
            ],
          ),
        ),
        Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.casino,
                color: Colors.grey,
                size: 20,
              ),
              new Text(
                "205",
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
