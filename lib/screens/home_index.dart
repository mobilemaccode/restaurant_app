import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:restaurant_app/screens/CartPage.dart';
import 'package:restaurant_app/screens/account.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/screens/restaurant_home.dart';
import 'package:restaurant_app/screens/search.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
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
        /*items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Search")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Cart")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Account")),
        ],*/
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
    listBottomWidget.add(RestaurantHome());
    listBottomWidget.add(Search());
    listBottomWidget.add(CartPage());
    listBottomWidget.add(AccountScreen());
    //listBottomWidget.add(AccountScreen());

    /*
  image_picker: ^0.4.5
  image_cropper: ^0.0.4*/
  }
}
