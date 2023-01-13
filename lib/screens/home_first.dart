import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'package:restaurant_app/screens/main_screen.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/CustomUtils.dart';
import 'package:restaurant_app/util/data.dart';

class HomeFirst extends StatefulWidget {
  @override
  _HomeFirstState createState() => _HomeFirstState();
}

class _HomeFirstState extends State<HomeFirst> {
  final TextEditingController _searchControl = new TextEditingController();

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
          SizedBox(height: 50),
          Row /*or Column*/(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.business_center, size: 50,color: Colors.grey,),
              Icon(Icons.notification_important, size: 50,color: Colors.grey,),
            ],
          ),
          SizedBox(height: 20),
          createCartListItem(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              "What do you like \nto eat today?",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 10),

          Padding(
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
          ),
          SizedBox(height: 30),

          Container(
            height: 275,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: furnitures.length,
              itemBuilder: (BuildContext context, int index) {
                Map furniture = furnitures[index];

                return Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: (){
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return Details();
                          },
                        ),
                      );*/
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => HomeIndex()),
                      );
                    },
                    child: Container(
                      height: 275,
                      width: 280,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            furniture['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "${furniture["img"]}",
                              height: 240,
                              width: 280,
                              fit: BoxFit.cover,
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

          SizedBox(height: 20),
        ],
      ),
    );
  }
  createCartListItem() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    //borderRadius: BorderRadius.all(Radius.circular(14)),
                    shape: BoxShape.circle,
                    //color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: AssetImage("assets/images/login_bg.png"))),
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
                          "Hello",
                          maxLines: 2,
                          softWrap: true,
                          style: CustomTextStyle.textFormFieldBlack
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                      Utils.getSizedBox(height: 6),
                      /*Text(
                        "Hello",
                        maxLines: 2,
                        style: CustomTextStyle.textFormFieldRegular
                            .copyWith(color: Colors.grey, fontSize: 16),
                      ),*/
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Patrizia Devan",
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.black),
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
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: (){
              /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return Details();
                          },
                        ),
                      );*/
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeIndex()),//MainScreen
              );
            },
            //onTap: () => print("Container pressed"),
            child: Container(
              width: 24,
              height: 100,//double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),//EdgeInsets.only(right: 10, top: 8),
              child: Icon(
                Icons.business,
                color: Colors.black,
                size: 35,
              ),
              /*decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.green),*/
            ),// handle your onTap here
          ),
        )
      ],
    );
  }

}
