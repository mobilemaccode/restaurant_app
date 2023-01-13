import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/DishDetails.dart';
import 'package:restaurant_app/screens/filter_page.dart';
import 'package:restaurant_app/util/data.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<String> selectedCuisineList = List();
  List<String> selectedDietList = List();

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
                            builder: (context) => FilterPage("",selectedCuisineList,selectedDietList)),
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
              Text(
                "Search",
                style: TextStyle(color: Colors.grey, fontSize: 18),
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
                  padding: EdgeInsets.only(right: 20),
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
                      height: 50,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /*ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "${furniture["img"]}",
                              height: 240,
                              width: 280,
                              fit: BoxFit.cover,
                            ),
                          ),*/
                          SizedBox(height: 10),
                          Text(
                            furniture['name'],
                            style: TextStyle(
                                //fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          SizedBox(height: 10),
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
