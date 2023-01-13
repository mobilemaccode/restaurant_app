import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:restaurant_app/widgets/badge.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
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

      body: Stack(
        children: <Widget>[
          ListView(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              //  SizedBox(height: 10),
             // SizedBox(height: 20),
              Stack(
                children: <Widget>[
                  ClipRRect(
                    //borderRadius: BorderRadius.circular(15),
                    child: new Image.asset(
                      'assets/dish1.jpg',
                      width: double.infinity,
                      //fit: BoxFit.fill,
                    ),/*Image.asset(
                      "${furnitures[0]["img"]}",
                      height: 540,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),*/
                  ),
                  Positioned.fill(
                    //right: -10.0,
                    //
                    child: Align(
                        alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "${furnitures[0]["name"]}" +
                              " causing big \n design  collapse in low",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            //fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
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
                        //Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 20),

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
                            // Icon(Icons.star, size: 50),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10),
                            FlutterRatingBar(
                              initialRating: 3,
                              //minRating: 1,
                              //direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30.0,
                              borderColor: Color(0xFFf18a01),
                              fillColor: Color(0xFFf18a01),
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              //itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              child: Text(
                                "240 Reviews",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "\$18.05",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFf18a01)),
                            ),
                          ],
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.bookmark,
                              size: 30,
                              color: Colors.grey,
                            ),
                            Text(
                              "Save  ",
                              style: TextStyle(
                                fontSize: 16,
                                //fontWeight: FontWeight.w800,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Sed porttitor lectus nibh. Cras ultricies ligula "
                          "sed magna dictum porta. Praesent sapien massa, "
                          "convallis a pellentesque nec, egestas non nisi. "
                          "Lorem ipsum dolor sit amet, consectetur adipiscing "
                          "elit. Nulla porttitor accumsan tincidunt. "
                          "Curabitur arcu erat, accumsan id imperdiet et, "
                          "porttitor at sem.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                    child:  Text(
                      "Other Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),

                    SizedBox(height: 10),
                    Container(
                      // height: 310,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: furnitures.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map furniture = furnitures[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              child: Container(
                                height: 40,
                                //width: 280,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Text(
                                        "50.77 gm",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      furniture['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                      ),
                                    ),
                                    // middleSection,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      ),
                    ),
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
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: furnitures.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map furniture = furnitures.reversed.toList()[index];

                          return Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return Details();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "${furniture["img"]}",
                                    height: 100,
                                    width: 100,
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
                      //margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/1.jpeg',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(right: 8, top: 4),
                                    child: Text(
                                      "Jhon Doe",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Text(
                                    "Sed porttitor lectus nibh",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 16),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "12 Aug 2019",
                                          style: CustomTextStyle.textFormFieldBlack
                                              .copyWith(color: Colors.grey),
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
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      //margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: RaisedButton(
                        onPressed: () {
                          /*Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => OrderPlacePage()));*/
                          //showThankYouBottomSheet(context);
                        },
                        color: Color(0xFFf18a01),
                        padding: EdgeInsets.only(
                            top: 12, left: 60, right: 60, bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Add Order",
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),



            ],
          ),
          /* Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange[200],
                      offset: Offset(0.0, 10.0),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Feather.getIconData("plus"),
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
