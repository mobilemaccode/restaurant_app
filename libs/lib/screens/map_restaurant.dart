import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_app/places_search_map.dart';
import 'package:restaurant_app/screens/filter_page.dart';
import 'package:restaurant_app/screens/restaurant_menu.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';


class MapRestaurant extends StatefulWidget {
  List restaurantList;
  MapRestaurant(this.restaurantList);

  @override
  _MapRestaurantState createState() => _MapRestaurantState(restaurantList);
}

class _MapRestaurantState extends State<MapRestaurant> {
  Completer<GoogleMapController> _controller = Completer();
  List restaurantList;
  var sToken, userID, restaurantsId;
  List<String> selectedCuisineList = List();
  List<String> selectedDietList = List();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.719568, 75.857727),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(22.719568, 75.857727),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  _MapRestaurantState(this.restaurantList);

  SaveString(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $value');

    restaurantsId = prefs.getString("restaurant") ?? 0;
    print('restaurantsId $restaurantsId');
  }
//map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       // padding: EdgeInsets.only(left: 10,right: 10),
        children: <Widget>[
          SizedBox(height: 20),
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
                            builder: (context) => FilterPage("",selectedCuisineList,selectedDietList)),
                      );
                    },
                  ),

                ],
              ),
            ],
          ),
          /*SizedBox(height: 10),
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
          ),*/
          SizedBox(
            height: 1,
          ),
          SizedBox(
            height: 280,
            child:PlacesSearchMapSample('Restaurant'), /*GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),*/
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: restaurantList.length,
              itemBuilder: (BuildContext context, int index) {
                Map mapRestaurantList = restaurantList[index];
                return Padding(
                  padding: EdgeInsets.all(15),//only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      var rID = mapRestaurantList['id'];
                      // setState(() {
                      SaveString("restaurant", rID.toString());
                      //  });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return RestaurantMenu(
                                sToken, userID, rID);
                          },
                        ),
                      );
                    },
                    child: Container(
                      // height: 50,
                      width: double.infinity,
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 80,width: 80,
                            child: Stack(
                              children: <Widget>[
                                Center(child: CircularProgressIndicator()),
                                Center(
                                  child:ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: mapRestaurantList['image'],height: 80,width: 80,fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          furniture['image'],
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.fill,
                                        ),
                                      ),*/
                          SizedBox(width: 10),
                          SizedBox(
                            width: 180,
                            height: 80,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  mapRestaurantList['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                Text(
                                  mapRestaurantList['description'],
                                  maxLines: 2,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                Text(
                                  mapRestaurantList['address'],
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Colors.red.shade900),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Color(0xFFf18a01),
                              ),
                              Text(
                                mapRestaurantList['rating'].toString(),
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
}
