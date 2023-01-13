import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/util/data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
                  Text(""),
                  SizedBox(width: 50,)
                 // Icon(Icons.star, size: 50),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Text(
                      "Crown Palace",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Center(
                      child:const Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Table Number", style: TextStyle(fontStyle: FontStyle.normal,fontSize: 16.0)),
                            TextSpan(text: ' 10', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16.0,color: Colors.deepOrange),),
                          ],
                        ),
                      ),
                    ),                    /*child: Text(
                      "Table Number 10",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),*/
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.fastfood, size: 30, color: Colors.grey,),
                  Icon(Icons.notification_important,size: 35,color: Colors.grey,),
                ],
              ),
            ],
          ),
          SizedBox(height: 50,),
          SizedBox(height: 40,
            child: Text(
              "Vagetarian",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),



          Container(
            height: 310,
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return Details();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 275,
                      width: 280,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "${furniture["img"]}",
                              height: 240,
                              width: 280,
                              fit: BoxFit.cover,
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
                          SizedBox(height: 10),
                         middleSection,
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

              SizedBox(height: 40,
                child: Text(
                  "Non vag",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              /*FlatButton(
                child: Text(
                  "View More",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: (){},
              ),*/
            ],
          ),

          Container(
            height: 140,
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
                    },
                    child: Container(
                      height: 140,
                      width: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "${furniture["img"]}",
                          height: 140,
                          width: 140,
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
              Icon(Icons.access_time, color: Colors.grey, size: 20,),
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

        Icon(Icons.casino, color: Colors.grey, size: 20,),
        new Text("205",),
      ],
    ),
  ),

      ],
    ),
  );

}
