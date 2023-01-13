import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/filter_page.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class MapRestaurant extends StatefulWidget {
  @override
  _MapRestaurantState createState() => _MapRestaurantState();
}

class _MapRestaurantState extends State<MapRestaurant> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
                  IconButton(
                    icon: new Icon(Icons.close),
                    highlightColor: Colors.orange,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Text(
                    "RESTAURENT",
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
                    highlightColor: Colors.orange,
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
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(
                Icons.search,
                size: 20,
                color: Colors.grey,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context){
                          return SearchList();
                        },
                      ),
                    );
                  },
                  child: new Text(
                    "Search",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),

          SizedBox(
            height: 250,
            /*child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),*/
            child: Image.asset('assets/map1.png',
              height: 250,
              width: 250,
              fit: BoxFit.fill,
            ),
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
                            return Details();
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
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
