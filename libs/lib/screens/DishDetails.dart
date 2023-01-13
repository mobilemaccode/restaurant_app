import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'dart:async';
import 'package:restaurant_app/util/const.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class DishDetails extends StatefulWidget {
  var sToken, userID, restaurantsId, catId, menuId;

  DishDetails(
      this.sToken, this.userID, this.restaurantsId, this.catId, this.menuId);

  @override
  _DishDetailsState createState() =>
      _DishDetailsState(sToken, userID, restaurantsId, catId, menuId);
}

class _DishDetailsState extends State<DishDetails> {
  var sToken, userID, restaurantsId, catId, menuId,saveStatus;
  bool isLoading = false;
  ProgressDialog pr;
var isEat = 0;
  var dishDetails;

  _DishDetailsState(
      this.sToken, this.userID, this.restaurantsId, this.catId, this.menuId);

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
    //_buildProgressIndicator();
    getDishDetails();
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    print('url: $url');
    print('body: $body');
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

  getDishDetails() async {
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "category_id": catId,
      "id": menuId,
      "restaurant_id": restaurantsId,
    });
    var response =
        await createPost(APIConstants.API_BASE_URL + 'get-dish', body: request);
    setState(() {
      dishDetails = json.decode(response.body);
      print('response: $dishDetails');
      saveStatus = dishDetails['dish']['favourite_status'];
      isEat = dishDetails['is_eat'];
    });
    var sStatus = dishDetails['status'];
    String message = dishDetails['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      setState(() {
        isLoading = true;
      });
      } else {
      setState(() {
        isLoading = true;
      });
      //Constants.showToast(message);
    }
  }

  save() async {
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
    pr.show();
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "category_id": catId,
      "id": menuId,
      "restaurant_id": restaurantsId,
    });
    var response = await createPost(
        APIConstants.API_BASE_URL + 'save-favourite',
        body: request);
    pr.hide().then((isHidden) {
    });
    final dataResponse = jsonDecode(response.body);
    var objectRes = json.decode(response.body);
    var sStatus = objectRes['status'];
    String message = dataResponse['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      saveStatus == '1'? setState(() {
        saveStatus == "0";
        getDishDetails();
      }) :setState(() {
        saveStatus == "1";
        getDishDetails();
      });
    } else {
      Constants.showToast(message);
    }
  }

  addToCart(var price) async {
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
    pr.show();
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "category_id": catId,
      "menu_id": menuId,
      "restaurant_id": restaurantsId,
      "quantity": "1",
      "type": "3",
      "price": price,

    });
    var response = await createPost(
        APIConstants.API_BASE_URL + 'add-to-cart',
        body: request);
    pr.hide().then((isHidden) {
    });
    final dataResponse = jsonDecode(response.body);
    var objectRes = json.decode(response.body);
    var sStatus = objectRes['status'];
    String message = dataResponse['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      setState(() {});
      Constants.showToast(message);
      Navigator.of(context).pop(true);
    } else {
      Constants.showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading
          ? NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    }),

                actions: <Widget>[
                  IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.share, color: Colors.white,),
                  )
                ],

                expandedHeight: 550.0,
                //backgroundColor: Colors.grey,
                floating: true,
                pinned: true,
                snap: false,
                elevation: 50,
                //backgroundColor: Colors.pink,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(dishDetails['dish']['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 577,
                          //constraints: BoxConstraints.expand(),
                          decoration: new BoxDecoration(
                              image: new DecorationImage(image: new NetworkImage( dishDetails['dish']['image']),
                                //fit: BoxFit.fill
                                //fit: BoxFit.fitHeight
                                fit: BoxFit.cover,
                              )
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),

                      ],
                    )
                )
            ),
          ];
        },
        body: Stack(
          // padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ListView(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8,right: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(""),
                              SizedBox(
                                width: 50,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FlutterRatingBar(
                                initialRating: double.parse(dishDetails['dish']['rating']),
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 30.0,
                                borderColor: Color(0xFFf18a01),
                                fillColor: Color(0xFFf18a01),
                                itemPadding:
                                EdgeInsets.symmetric(horizontal: 4.0),
                                /*onRatingUpdate: (rating) {
                              // print(rating);
                             },*/
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                child: Text(
                                  dishDetails['dish']['reviews']
                                      .toString() +
                                      " Reviews",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "\$" +dishDetails['dish']['half_price'].toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFf18a01)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {save();},
                                icon: Icon(Icons.bookmark),
                                color: saveStatus ==1? Color(0xFFf18a01):Colors.grey,
                                iconSize: 30,
                              ),
                              Text(
                                "Save  ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        dishDetails['dish']['description'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Other Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      Center(
                        child: SingleChildScrollView(
                          child: Html(
                            data:dishDetails['dish']['ingredients'],
                            // padding: EdgeInsets.all(8.0),
                            onLinkTap: (url) {
                              print("Opening $url...");
                            },
                            customRender: (node, children) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "custom_tag": // using this, you can handle custom tags in your HTML
                                    return Column(children: children);
                                }
                              }
                            },
                          ),
                        ),
                      ),

                      /*Text(
                     dishDetails['dish']['ingredients'],
                     style: TextStyle(
                       fontSize: 15,
                       color: Colors.grey,
                       fontWeight: FontWeight.w600,
                     ),
                   ),*/
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            child: Text(
                              "Reviews",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              "View all",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: dishDetails['comments'].length,
                        itemBuilder: (BuildContext context, int index) {
                          Map dishDetailsList =
                          dishDetails['comments'][index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  child: Image.network(
                                    dishDetailsList['image'],
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 8, top: 4),
                                          child: Text(
                                            dishDetailsList['name'],
                                            //height: 90,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.normal,
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          dishDetailsList['review'],
                                          //height: 90,
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 16),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "12 Aug 2019",
                                                style: CustomTextStyle
                                                    .textFormFieldBlack
                                                    .copyWith(
                                                    color: Colors
                                                        .grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 100,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                IconButton(
                  icon: new Icon(
                    Icons.share,
                    size: 30,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {},
                ),
              ],
            ),
            Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:  Container(
                    padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        addToCart(dishDetails['dish']['full_price']);
                      },
                      color: Color(0xFFf18a01),
                      padding: EdgeInsets.only(
                          top: 12, left: 60, right: 60, bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "Add Order",
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )),
          ],
        )
      )
          : ColorLoader3()
    );
    return Scaffold(
      /*appBar: AppBar(
        actions: <Widget>[
          Center(
            child: IconBadge(
              icon: Feather.getIconData("shopping-cart"),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),*/
      body: isLoading
          ?Stack(
        // padding: EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
         Padding(
           padding: const EdgeInsets.only(bottom: 60),
           child: ListView(children: <Widget>[
             Stack(
               children: <Widget>[
                 Container(
                   width: double.infinity,
                   height: 600,
                   decoration: new BoxDecoration(
                       image: new DecorationImage(image: new NetworkImage( dishDetails['dish']['image']),
                           fit: BoxFit.fitHeight)
                   ),
                   child: BackdropFilter(
                     filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                     child: Container(
                       color: Colors.black.withOpacity(0.3),
                     ),
                   ),
                 ),
                 Positioned.fill(
                     child: Align(
                       alignment: Alignment.bottomCenter,
                       child: Padding(
                         padding: EdgeInsets.all(10),
                         child: Text(
                           dishDetails['dish']['name'],
                           maxLines: 2,
                           style: TextStyle(
                             fontSize: 26,
                             color: Colors.white,
                           ),
                         ),
                       ),
                     )),
               ],
             ),
             Padding(
               padding: EdgeInsets.all(8.0),
               child: Column(
                 children: <Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Row(
                         children: <Widget>[
                           Text(""),
                           SizedBox(
                             width: 50,
                           )
                         ],
                       ),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           SizedBox(height: 10),
                           FlutterRatingBar(
                             initialRating: double.parse(dishDetails['dish']['rating']),
                             allowHalfRating: false,
                             itemCount: 5,
                             itemSize: 30.0,
                             borderColor: Color(0xFFf18a01),
                             fillColor: Color(0xFFf18a01),
                             itemPadding:
                             EdgeInsets.symmetric(horizontal: 4.0),
                             /*onRatingUpdate: (rating) {
                              // print(rating);
                             },*/
                           ),
                           SizedBox(height: 10),
                           SizedBox(
                             child: Text(
                               dishDetails['dish']['reviews']
                                   .toString() +
                                   " Reviews",
                               style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w800,
                               ),
                             ),
                           ),
                           SizedBox(height: 10),
                           Text(
                             "\$" +dishDetails['dish']['half_price'].toString(),
                             style: TextStyle(
                                 fontSize: 22,
                                 fontWeight: FontWeight.w800,
                                 color: Color(0xFFf18a01)),
                           ),
                         ],
                       ),
                       Row(
                         children: <Widget>[
                           IconButton(
                             onPressed: () {save();},
                             icon: Icon(Icons.bookmark),
                             color: saveStatus ==1? Color(0xFFf18a01):Colors.grey,
                             iconSize: 30,
                           ),
                           Text(
                             "Save  ",
                             style: TextStyle(
                               fontSize: 16,
                               color: Colors.grey,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                   SizedBox(height: 10),
                   Text(
                     dishDetails['dish']['description'],
                     style: TextStyle(
                       fontSize: 15,
                       color: Colors.grey,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   SizedBox(height: 30),
                   SizedBox(
                     width: double.infinity,
                     child: Text(
                       "Other Details",
                       style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                   SizedBox(height: 10),

                   Center(
                     child: SingleChildScrollView(
                       child: Html(
                         data:dishDetails['dish']['ingredients'],
                        // padding: EdgeInsets.all(8.0),
                         onLinkTap: (url) {
                           print("Opening $url...");
                         },
                         customRender: (node, children) {
                           if (node is dom.Element) {
                             switch (node.localName) {
                               case "custom_tag": // using this, you can handle custom tags in your HTML
                                 return Column(children: children);
                             }
                           }
                         },
                       ),
                     ),
                   ),

                   /*Text(
                     dishDetails['dish']['ingredients'],
                     style: TextStyle(
                       fontSize: 15,
                       color: Colors.grey,
                       fontWeight: FontWeight.w600,
                     ),
                   ),*/
                   SizedBox(height: 20),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       SizedBox(
                         height: 40,
                         child: Text(
                           "Reviews",
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.w800,
                           ),
                         ),
                       ),
                       FlatButton(
                         child: Text(
                           "View all",
                           style: TextStyle(
                             color: Colors.grey,
                           ),
                         ),
                         onPressed: () {},
                       ),
                     ],
                   ),
                   SizedBox(height: 10),
                   ListView.builder(
                     scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                     itemCount: dishDetails['comments'].length,
                     itemBuilder: (BuildContext context, int index) {
                       Map dishDetailsList =
                       dishDetails['comments'][index];
                       return Padding(
                         padding: const EdgeInsets.only(bottom: 10),
                         child: Row(
                           children: <Widget>[
                             ClipRRect(
                               borderRadius:
                               BorderRadius.circular(5),
                               child: Image.network(
                                 dishDetailsList['image'],
                                 height: 80,
                                 width: 80,
                                 fit: BoxFit.fill,
                               ),
                             ),
                             Expanded(
                               child: Container(
                                 padding:
                                 const EdgeInsets.all(8.0),
                                 child: Column(
                                   mainAxisSize: MainAxisSize.max,
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,
                                   children: <Widget>[
                                     Container(
                                       padding: EdgeInsets.only(
                                           right: 8, top: 4),
                                       child: Text(
                                         dishDetailsList['name'],
                                         //height: 90,
                                         style: TextStyle(
                                             fontWeight:
                                             FontWeight.normal,
                                             fontSize: 18,
                                             color: Colors.black),
                                       ),
                                     ),
                                     Text(
                                       dishDetailsList['review'],
                                       //height: 90,
                                       style: TextStyle(
                                           fontWeight:
                                           FontWeight.bold,
                                           color: Colors.grey,
                                           fontSize: 16),
                                     ),
                                     Container(
                                       child: Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment
                                             .spaceBetween,
                                         children: <Widget>[
                                           Text(
                                             "12 Aug 2019",
                                             style: CustomTextStyle
                                                 .textFormFieldBlack
                                                 .copyWith(
                                                 color: Colors
                                                     .grey),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               flex: 100,
                             )
                           ],
                         ),
                       );
                     },
                   ),
                   SizedBox(height: 10),
                 ],
               ),
             ),
           ],),
         ),
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                IconButton(
                  icon: new Icon(
                    Icons.share,
                    size: 30,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned.fill(
    child: Align(
    alignment: Alignment.bottomCenter,
      child:  Container(
        padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () {
            addToCart(dishDetails['dish']['full_price']);
          },
          color: Color(0xFFf18a01),
          padding: EdgeInsets.only(
              top: 12, left: 60, right: 60, bottom: 12),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          child: Text(
            "Add Order",
            style: CustomTextStyle.textFormFieldSemiBold
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    )),
        ],
      )
          : Container(
              alignment: AlignmentDirectional.center,
              decoration: new BoxDecoration(
                color: Colors.white70,
              ),
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: new BorderRadius.circular(10.0)),
                width: 300.0,
                height: 200.0,
                alignment: AlignmentDirectional.center,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 7.0,
                        ),
                      ),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: new Center(
                        child: new Text(
                          "loading.. wait...",
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  List _buildList() {
    List<Widget> listItems = List();

    return listItems;
  }

}
