import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/data.dart';

class FavoritesDish extends StatefulWidget {
  @override
  _FavoritesDishState createState() => _FavoritesDishState();
}

class _FavoritesDishState extends State<FavoritesDish> {
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
      body: ListView(
        padding: EdgeInsets.only(left: 20),
        children: <Widget>[

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
            height: 10,
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
                                 "Vag",//+furniture['name'],
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 16,
                                     color: Colors.green),
                               ),
                             ],
                           ),
                         ),

                          SizedBox(width: 10),
                          Text(
                            "* 4.5",//furniture['name'],
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

}
