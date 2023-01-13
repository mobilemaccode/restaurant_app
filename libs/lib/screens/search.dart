import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/screens/filter_page.dart';
import 'package:restaurant_app/screens/restaurant_menu.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ProgressDialog pr;
  List restaurantList,recentSearchList;
  bool isLoading = false;
  var sToken, userID, restaurantsId,restaurantResponse, msg,recentSearch;
  var sStatus = false;
  var isRecentSearch = false;

  List<String> selectedCuisineList = List();
  List<String> selectedDietList = List();
  //////////////////
  Widget appBarTitle = new Text(
    "Search Example",
    style: new TextStyle(color: Colors.grey),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.grey,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();

  _SearchListExampleState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }


  /////////////////////

  void initState() {
    super.initState();
    _isSearching = false;
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
    getHistory();
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

  getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
    });
    var response =
    await createPost(APIConstants.API_BASE_URL + 'get-recent-search', body: request);
    recentSearch = json.decode(response.body);
    print('response $recentSearch');

    var status = recentSearch['status'];
    msg = recentSearch['message']; //dataResponse['data']['f_name'];
    if (status == true) {
      isRecentSearch =true;
      recentSearchList = recentSearch['data'];
      if(recentSearchList != null){
        isRecentSearch =true;
      }else{
        isRecentSearch =false;
      }
      setState(() {
       isLoading = true;
      });
      return isRecentSearch;
    } else {
      isRecentSearch =false;
      setState(() {
        isLoading = true;
      });
      //Constants.showToast(msg);
    }
    /*}else{
      setState(() {
        isLoading  = true;
        Constants.showToast("Cart is Empty!");
      });
    }*/
  }


  getRestaurants(String name) async {
    setState(() {
      isLoading = false;
    });

    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "menu": name,
    });
    var response = await createPost(
        APIConstants.API_BASE_URL + 'search',
        body: request);
     pr.hide().then((isHidden) {
     });
    restaurantResponse = json.decode(response.body);
    print('objectRes $restaurantResponse');
    sStatus = restaurantResponse['status'];
     msg = restaurantResponse['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      setState(() {
        restaurantList = restaurantResponse['data'];
        isLoading = true;
      });
      return restaurantList;
    } else {
      setState(() {
        isLoading = true;
      });
      Constants.showToast(msg);
    }
  }

  SaveString(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $value');

    restaurantsId = prefs.getString("restaurant") ?? 0;
    print('restaurantsId $restaurantsId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // key: globalKey,
      //appBar: buildAppBar(context),
      body: isLoading?Column(
        //padding: EdgeInsets.only(left: 20),
        children: <Widget>[
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 10,),
                  SizedBox(
                    child: Text(
                      "Search",
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
                  Icon(
                    Icons.notification_important,
                    size: 30,
                    color: Colors.grey,
                  ),
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
                            builder: (context) => FilterPage("SearchList",selectedCuisineList,selectedDietList)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          Container(
              //width: 320,
              padding: EdgeInsets.only(left: 15,right: 15,top: 15),
              child: TextField(
                autocorrect: true,
                textInputAction: TextInputAction.search,onSubmitted: (value){
                /*setState(() {
              sStatus = false;
              restaurantList.clear();
            });*/
                print(value);
                getRestaurants(value.toString());
              },
                decoration: InputDecoration(

                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(Icons.search,color: Colors.grey,),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),)
          ),


          /*Container(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 1,
          ),

          TextField( textInputAction: TextInputAction.search,onSubmitted: (value){
            *//*setState(() {
              sStatus = false;
              restaurantList.clear();
            });*//*
            print(value);
            getRestaurants(value.toString());
          },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: 'Search ',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
            height: 1.0,
            color: Colors.grey,
          ),*/
          SizedBox(
            height: 20,
          ),
          Container(
            // height: 310,
            child: sStatus?ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: restaurantList.length,
              itemBuilder: (BuildContext context, int index) {
                Map mapRestaurantList = restaurantList[index];
                return Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      var rID = mapRestaurantList['id'];
                      print('sToken: $sToken');
                      print('userID: $userID');
                      print('rID: $rID');
                     SaveString("restaurant", rID.toString());
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 90,width: 90,
                            child: Stack(
                              children: <Widget>[
                                Center(child: CircularProgressIndicator()),
                                Center(
                                  child:ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: mapRestaurantList['image'],height: 90,width: 90,fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
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
            ):isRecentSearch?ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: recentSearchList.length,
              itemBuilder: (BuildContext context, int index) {
                Map mapRecentSearchList = recentSearchList[index];
                return Padding(
                  padding: EdgeInsets.only(left: 20,right: 15,bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      var rName = mapRecentSearchList['name'];
                      print('name: $rName');
                      getRestaurants(rName);
                    },
                    child: Text(
                      mapRecentSearchList['name'],
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey.shade600),
                    ),
                  ),
                );
              },
            ):Center(child: Text("",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))
          ),
        ],
      ):ColorLoader3()
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.grey,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.grey,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.grey),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.grey)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.grey,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.grey),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}


