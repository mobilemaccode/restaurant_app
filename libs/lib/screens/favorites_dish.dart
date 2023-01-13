import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/screens/DishDetails.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/data.dart';


import 'dart:async';
import 'package:restaurant_app/util/const.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoritesDish extends StatefulWidget {
  @override
  _FavoritesDishState createState() => _FavoritesDishState();
}

class _FavoritesDishState extends State<FavoritesDish> {
  ProgressDialog pr;
  var favList,userID,sToken;
  // List restaurantOffer;
  bool isLoading  = false;


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
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)
    );
    //_buildProgressIndicator();

    getFavourite();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    return http.post(url, headers: {"Content-Type": "application/json"}, body: body).then((http.Response response) {
      print(response.body.toString());
      var objectRes = json.decode(response.body);

      print('REST LIST RESPONSE $objectRes');

      var sStatus = objectRes['success'];
      print(sStatus);
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  getFavourite() async {
    /*setState(() {
      isLoading  = false;
    });*/
    // pr.show();
    final prefs = await SharedPreferences.getInstance();
     userID = prefs.getString("user_id") ?? 0;
     sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      //"token": sToken,
     // "restaurant_id": restaurantsId,
    });
    print('favourite request $request');
    var response = await createPost(APIConstants.API_BASE_URL+ 'get-saved-favourite',
        body: request);
    var objectRes = json.decode(response.body);
    print('favourite response $objectRes');
    var sStatus = objectRes['status'];
    String message = objectRes['message'];//dataResponse['data']['f_name'];
    favList = objectRes['data'];
   // catNameList2.clear();
    /*setState(() {
      isLoading  = true;
    });*/
    if (sStatus == true) {
      // Constants.SaveString("token", userToken);
      setState(() {
        //catNameList2.clear();
        isLoading  = true;
      });
      //Constants.showToast(message);
      // Navigator.push(context,MaterialPageRoute(builder: (context) => AudioScanner()),);
    } else {
      Navigator.pop(context);
      Constants.showToast(message);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Fevorite Dish",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: isLoading?ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: favList.length,
        itemBuilder: (BuildContext context, int index) {
          Map mapFavList = favList[index];
          return Padding(
            padding: EdgeInsets.all(15),//only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return DishDetails(sToken, userID,mapFavList['restaurant_id'],mapFavList['category_id'],mapFavList['menu_id']);
                    },
                  ),
                );

                /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return DishDetails(sToken, userID,restaurantsId,menuList['category_id'],menuList['id']);
                          },
                        ),
                      );*/
              },
              child: Container(
                // height: 50,
                width: double.infinity,
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        children: <Widget>[
                          Center(child: SizedBox(height: 15,width: 15,child: CircularProgressIndicator(),),),
                          Center(
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: mapFavList['image'],height: 80,width: 80,fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 180,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            mapFavList['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          Text(
                            mapFavList['description'],
                            maxLines: 2,
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Text(
                            "Vag",//+furniture['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8),
                    Row(
                      children: <Widget>[
                        //Icon(Icons.star,color: Color(0xFFf18a01),),
                        Text(
                          "\$"+mapFavList['half_price'].toString(),//furniture['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFFf18a01)),
                        ),
                      ],
                    )
                  ],
                ),
              ),


            ),
          );
        },
      ):
      ColorLoader3()
    );
  }

}
