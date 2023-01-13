import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/screens/DishDetails.dart';
import 'package:restaurant_app/screens/filter_page.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'package:restaurant_app/screens/home_index2.dart';
import 'package:restaurant_app/screens/map_restaurant.dart';
import 'package:restaurant_app/screens/notification_page.dart';
import 'package:restaurant_app/screens/restaurant_menu.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/util/constants.dart';
import 'package:restaurant_app/util/data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  ProgressDialog pr;
  List restaurantList;
  List restaurantOffer;
  bool isLoading = false;
  var sToken, userID, restaurantsId, restaurantResponse, sTypeFood;
  List<String> selectedCuisineList = List();
  List<String> selectedDietList = List();
  List<String> selectedDietListInt = List();
  final Location location = new Location();


  _showInfoDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Demo Application'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Created by Guillaume Bernos'),
                InkWell(
                  child: Text(
                    'https://github.com/Lyokone/flutterlocation',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () =>
                      launch("https://github.com/Lyokone/flutterlocation"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void initState() {
    super.initState();
    pr = new ProgressDialog(context);
    pr.style(
        message: ProgressDialogTitles.USER_LOG_IN,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600));
    getRestaurants(3);
  }

  ReadString(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? 0;
    print('read: $value');
    return value;
  }

  SaveString(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $value');

    restaurantsId = prefs.getString("restaurant") ?? 0;
    print('restaurantsId $restaurantsId');
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    print('url $url');
    print('body $body');
    return http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  getRestaurants(var listFilter) async {
    setState(() {
      isLoading = false;
    });
    // pr.show();
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "cuisines": selectedCuisineList,
      "type": selectedDietListInt,
      "filter": listFilter,
      "lat": "22.7226023",
      "long": "75.8871424",
    });
    //print('REST request $request');
    var response = await createPost(
        APIConstants.API_BASE_URL + 'get-restaurants',
        body: request);
    restaurantResponse = json.decode(response.body);
    print('objectRes $restaurantResponse');

    var sStatus = restaurantResponse['status'];
    String message =
        restaurantResponse['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      setState(() {
        isLoading = true;
        restaurantList = restaurantResponse['restaurant'];
        restaurantOffer = restaurantResponse['offer'];
      });
      return restaurantList;
    } else {
      Constants.showToast(message);
      Navigator.pop(context);
    }
  }

  /*_navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilterPage("")),
    );
    print('result  $result');
    getRestaurants();
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }*/

  Future _buttonTapped(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return FilterPage("",selectedCuisineList,selectedDietList);
    }));
//    if (results != null && results.containsKey('selection')) {
    if (results != null) {
      setState(() {
        print('before selectedCuisineList $selectedCuisineList');
        print('before selectedDietList $selectedDietList');

        /*if(selectedCuisineList != null){
          selectedCuisineList.clear();
        }
        selectedCuisineList = results['selectedCuisineList'];
        print('recived selectedCuisineList $selectedCuisineList');
        if(selectedDietList != null){
          selectedDietList.clear();
          selectedDietListInt.clear();
        }
        selectedDietList = results['selectedDietList'];
        print('recived selectedDietList $selectedDietList');*/
        if (results.containsKey('selectedDietList')) {
          if(selectedDietListInt!= null)
          selectedDietListInt.clear();
          for (int i = 0; i < selectedDietList.length; i++) {
            if(selectedDietList[i] == "Vegetarian"){
              selectedDietListInt.add("1");
            }
            if(selectedDietList[i] == "Non Vegetarian"){
              selectedDietListInt.add("2");
            }
          }
        }
        getRestaurants(3);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          padding: new EdgeInsets.all(14.0),
          child: isLoading
              ? Column(
                  //padding: EdgeInsets.only(left: 10,right: 10),
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Home",
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
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: IconButton(
                                icon: new Image.asset(
                                  'assets/images/qr.png',
                                  height: 35,
                                  width: 35,
                                ), //Icon(Icons.camera_alt),
                                highlightColor: Color(0xFFf18a01),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScanPage("2")),
                                  );
                                },
                              ),
                              /*Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.black,
                  ),*/
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notification_important,
                                size: 35,
                                color: Colors.grey,
                              ), //Icon(Icons.camera_alt),
                              highlightColor: Color(0xFFf18a01),
                              onPressed: () {
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
                    //  SizedBox(height: 10),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: restaurantOffer.length, //furnitures.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map furniture = restaurantOffer[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return DishDetails(sToken, userID,furniture['restaurant_id'],furniture['category_id'],furniture['menu_id']);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                child: Stack(
                                  children: <Widget>[
                                    Center(child: CircularProgressIndicator()),
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: furniture['offer_image'],
                                          height: 140,
                                          width: 140,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8),

                    Container(
                      height: 35,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[

                          Padding(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            child:  GestureDetector(
                              onTap: () {
                                getRestaurants(1);
                              },
                              child:   Container(
                                padding: new EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: new Text(
                                  "Top Rated",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            child:  GestureDetector(
                              onTap: () {
                                getRestaurants(2);
                              },
                              child:   Container(
                                padding: new EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: new Text(
                                  "Top Offers",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5, left: 5),
                            child:  GestureDetector(
                              onTap: () {
                                getRestaurants(3);
                              },
                              child:   Container(
                                padding: new EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: new Text(
                                  "Near By",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: false,
                      child: Container(
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: furnitures.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map furniture = furnitures[index];
                            return Padding(
                              padding: EdgeInsets.only(right: 15, left: 15),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  child: Text(
                                    furniture['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          restaurantResponse['total_restaurants'].toString() +
                              " RESTAURANT",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: new Image.asset(
                                'assets/images/map.png',
                                height: 33,
                                width: 33,
                                color: Colors.grey,
                              ), //Icon(Icons.map,size: 35,),
                              highlightColor: Color(0xFFf18a01),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MapRestaurant(restaurantList)),
                                );
                              },
                            ),
                            IconButton(
                              icon: new Image.asset(
                                'assets/images/filter.png',
                                height: 35,
                                width: 35,
                              ),
                              highlightColor: Color(0xFFf18a01),
                              onPressed: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FilterPage()),
                                );*/
                                _buttonTapped(context);
                              },
                            ),
                          ],
                        ),
                      ],
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
                            padding: EdgeInsets.all(10), //only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                var rID = mapRestaurantList['id'];
                                SaveString("restaurant", rID.toString());

                               // Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeIndex2(sToken, userID, rID)),
                                );

                               /* Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return HomeIndex2(
                                          sToken, userID, rID);
                                    },
                                  ),
                                );*/
                              },
                              child: Container(
                                // height: 50,
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Stack(
                                        children: <Widget>[
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image:
                                                    mapRestaurantList['image'],
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                    // SizedBox(width: 10),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFf18a01),
                                        ),
                                        Text(
                                          mapRestaurantList['rating']
                                              .toString(),
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
                )
              : ColorLoader3()
      ));
    return FutureBuilder(
        future: getRestaurants(1),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                child: ListView(
              padding: EdgeInsets.only(left: 10, right: 10),
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
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: IconButton(
                            icon: new Image.asset(
                              'assets/images/qr.png',
                              height: 35,
                              width: 35,
                            ), //Icon(Icons.camera_alt),
                            highlightColor: Color(0xFFf18a01),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScanPage("2")),
                              );
                            },
                          ), /*Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.black,
                  ),*/
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.notification_important,
                            size: 35,
                            color: Colors.grey,
                          ), //Icon(Icons.camera_alt),
                          highlightColor: Color(0xFFf18a01),
                          onPressed: () {
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
                    itemCount: restaurantOffer.length, //furnitures.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map furniture = restaurantOffer[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 140,
                            width: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                furniture['offer_image'],
                                height: 90,
                                width: 90,
                              ),
                              /*Image.asset(
                          "${furniture["img"]}",
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                        ),*/
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
                        padding: EdgeInsets.only(right: 15, left: 15),
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
                            child: Text(
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
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: IconButton(
                            icon: new Image.asset(
                              'assets/images/map.png',
                              height: 33,
                              width: 33,
                              color: Colors.grey,
                              // width: double.infinity,
                              //fit: BoxFit.fill,
                            ), //Icon(Icons.map,size: 35,),
                            highlightColor: Color(0xFFf18a01),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MapRestaurant(restaurantList)),
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
                          ),
                          /*Icon(
                      Icons.tune,
                      size: 35,
                      color: Colors.black,
                    ),*/ //Icon(Icons.camera_alt),
                          highlightColor: Color(0xFFf18a01),
                          onPressed: () {
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
                Container(
                  // height: 310,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: restaurantList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map furniture = restaurantList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            var rID = furniture['id'];
                            print('sToken: $sToken');
                            print('userID: $userID');
                            print('rID: $rID');

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomeIndex2(sToken, userID, rID);
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
                                  child: Image.network(
                                    furniture['image'],
                                    height: 90,
                                    width: 90,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        furniture['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        furniture['description'],
                                        maxLines: 2,
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        furniture['address'],
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
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFf18a01),
                                    ),
                                    Text(
                                      "4.5", //furniture['name'],
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
            ));
          }
        });
  }
}
