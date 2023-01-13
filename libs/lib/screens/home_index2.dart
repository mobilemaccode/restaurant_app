import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:restaurant_app/screens/CartPage.dart';
import 'package:restaurant_app/screens/account.dart';
import 'package:restaurant_app/screens/search.dart';
import 'package:restaurant_app/screens/restaurant_menu2.dart';

class HomeIndex2 extends StatefulWidget {
  var sToken, userID,restaurantsId;
  HomeIndex2(this.sToken, this.userID,this.restaurantsId);

  @override
  _HomeIndex2State createState() => _HomeIndex2State(sToken, userID,restaurantsId);
}

class _HomeIndex2State extends State<HomeIndex2> {
  var sToken, userID,restaurantsId;
  _HomeIndex2State(this.sToken, this.userID, this.restaurantsId);

  int selectedPosition = 0;
  List<Widget> listBottomWidget = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(
            Feather.getIconData("home"),
          ), title: Container(height: 0.0),),
          BottomNavigationBarItem(
              icon: Icon(
                Feather.getIconData("search"),
              ), title: Container(height: 0.0),),
          BottomNavigationBarItem(
              icon: Icon(
                Feather.getIconData("shopping-bag"),
              ), title: Container(height: 0.0),),
          BottomNavigationBarItem(
              icon: Icon(
                Feather.getIconData("user"),
              ), title: Container(height: 0.0),),
        ],
        currentIndex: selectedPosition,
        type: BottomNavigationBarType.fixed,
       // backgroundColor: Colors.grey.shade100,
        selectedItemColor: Color(0xFFf18a01),
       // unselectedItemColor: Colors.black,
        onTap: (position) {
          setState(() {
            selectedPosition = position;
          });
        },
      ),
      body: Builder(builder: (context) {
        return listBottomWidget[selectedPosition];
      }),
    );
  }

  void addHomePage() {
    listBottomWidget.add(RestaurantMenu2(sToken, userID, restaurantsId));
    listBottomWidget.add(Search());
    listBottomWidget.add(CartPage());
    listBottomWidget.add(AccountScreen());
    //listBottomWidget.add(AccountScreen());

    /*
  image_picker: ^0.4.5
  image_cropper: ^0.0.4*/
  }
}
