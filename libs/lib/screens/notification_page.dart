import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {

  ProgressDialog pr;
  List restaurantOffer;
  bool isLoading = false;
  var sToken, userID, restaurantsId;
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
    getRestaurants();
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

  getRestaurants() async {
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
    });
    //print('REST request $request');
    var response = await createPost(
        APIConstants.API_BASE_URL + 'notification',
        body: request);
    var objectRes = json.decode(response.body);
    print('objectRes $objectRes');

    var sStatus = objectRes['status'];
    String message = objectRes['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      setState(() {
        restaurantOffer = objectRes['data'];
        isLoading = true;
      });
      return restaurantOffer;
    } else {
      setState(() {
        isLoading = true;
      });
      Constants.showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Column(
        //padding: EdgeInsets.only(left: 10,right: 10),
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Notification",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: new Icon(Icons.close),
                  highlightColor: Colors.orange,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: restaurantOffer.length,
              itemBuilder: (BuildContext context, int index) {
                Map mapRestaurantOffer = restaurantOffer[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10,),
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      width: double.infinity,
                      child: Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(width: 10,),
                          SizedBox(height: 70,width: 70,
                            child: Stack(
                              children: <Widget>[
                                Center(child: CircularProgressIndicator()),
                                Center(
                                  child:ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: mapRestaurantOffer['offer_image'],height: 70,width: 70,fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Flexible(
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      mapRestaurantOffer['restaurant_name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),

                                    Text(
                                      mapRestaurantOffer['offer_percentage'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.orange.shade600),
                                    ),
                                  ],
                                ),

                                Text(
                                  mapRestaurantOffer['offer_description'],
                                  maxLines: 2,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),


                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
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
      ):
    ColorLoader3());
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
