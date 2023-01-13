import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class RestaurantMenu3 extends StatefulWidget {
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu3>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: Constants.lightTheme,
        darkTheme: Constants.darkTheme,
        home: Scaffold(
            // key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
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
                "Menu",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            body: Builder(builder: (context) {
              return new DefaultTabController(
                length: 3,
                child: new Scaffold(
                  appBar: new AppBar(
                    //  title: const Text('Tabbed AppBar'),
                    bottom: new TabBar(isScrollable: false, tabs: [
                      new Tab(
                        text: 'Antipasti',
                      ), //icon: new Icon(Icons.directions_car)),
                      new Tab(
                        text: 'Pizza',
                      ), // icon: new Icon(Icons.directions_walk)),
                      new Tab(
                        text: 'Pasta',
                      ), //icon: new Icon(Icons.directions_bike)),
                    ]),
                  ),
                  body: new TabBarView(
                    children: [
                      new ListView(
                        children: list,
                      ),
                      new ListView(
                        children: list,
                      ),
                      new ListView(
                        children: list,
                      ),
                    ],
                  ),
                ),
              );
            })));
  }
}

List<Widget> list = <Widget>[
  new ListTile(
    title: new Text('CineArts at the Empire',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('85 W Portal Ave'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('The Castro Theater',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('429 Castro St'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('Alamo Drafthouse Cinema',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('2550 Mission St'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('Roxie Theater',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('3117 16th St'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('United Artists Stonestown Twin',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('501 Buckingham Way'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('AMC Metreon 16',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('135 4th St #3000'),
    leading: new Icon(
      Icons.theaters,
      color: Colors.orange[500],
    ),
  ),
  new Divider(),
  new ListTile(
    title: new Text('K\'s Kitchen',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('757 Monterey Blvd'),
    leading: new Icon(
      Icons.restaurant,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('Emmy\'s Restaurant',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('1923 Ocean Ave'),
    leading: new Icon(
      Icons.restaurant,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('Chaiya Thai Restaurant',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('272 Claremont Blvd'),
    leading: new Icon(
      Icons.restaurant,
      color: Colors.orange[500],
    ),
  ),
  new ListTile(
    title: new Text('La Ciccia',
        style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: new Text('291 30th St'),
    leading: new Icon(
      Icons.restaurant,
      color: Colors.orange[500],
    ),
  ),
];
