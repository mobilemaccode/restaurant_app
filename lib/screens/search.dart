import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/filter_page.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/data.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
      body: ListView(
        padding: EdgeInsets.only(left: 20),
        children: <Widget>[
          /* Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              "What are you \nlooking for?",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),*/
          SizedBox(height: 50),
          /* Padding(
            padding: EdgeInsets.only(right: 20),
            child: Card(
              elevation: 6.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Search",
                    prefixIcon: Icon(
                      Feather.getIconData("search"),
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 1,
                  controller: _searchControl,
                ),
              ),
            ),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
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
                            builder: (context) => FilterPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 15,
          ),
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
          Container(
            height: 1.0,
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recent Search",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
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
                  padding: EdgeInsets.all(10),//only(right: 20),
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
                                     fontWeight: FontWeight.bold,
                                     fontSize: 16,
                                     color: Colors.grey),
                               ),
                             ],
                           ),
                         ),

                          SizedBox(width: 10),
                          Text(
                            "\$20.30",//furniture['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFFf18a01)),
                          ),


                          //  middleSection,
                        ],
                      ),
                    ),


                  ),
                );
              },
            ),
          ),
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
              /*new Center(
                child: new Image.asset(
                  'assets/images/login_bg.png',
                  width: 20,
                  height: 20,
                  //fit: BoxFit.fill,
                ),
              ),*/
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
              /*new Center(
          child: new Image.asset(
            'assets/images/login_bg.png',
            width: 20,
            height: 20,
            //fit: BoxFit.fill,
          ),
        ),*/

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
