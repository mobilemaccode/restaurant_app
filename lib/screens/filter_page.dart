import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<FilterPage> {
  Completer<GoogleMapController> _controller = Completer();
  String selectedChoice = "";
  List<String> categoryList = [
    "Deserts",
    "Drinks",
    "Snacks",
    "Breakfast",
    "Mains",
    "Starters"
  ];
  List<String> selectedCategoryList = List();

  List<String> dietList = [
    "Vegetarian",
    "Meatless",
    "Baked",
    "Sugar-free",
    "Alcohol-free",
    "pan-free"
  ];
  List<String> selectedDietList = List();


  List<String> cuisineList = [
    "Chinese",
    "Italian",
    "Asian",
    "European",
    "American",
    "Indian",
    "Spanish",
    "Portuguese"
  ];
  List<String> selectedCuisineList = List();

  // this function will build and return the choice list
  _categoryChoiceList() {
    List<Widget> choices = List();
    categoryList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.only(top: 2,bottom: 2,left: 5,right: 5),
        child: ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item),
          ),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  _dietChoiceList() {
    List<Widget> choices = List();
    dietList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.only(top: 2,bottom: 2,left: 5,right: 5),
        child: ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item),
          ),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }


  _cuisineChoiceList() {
    List<Widget> choices = List();
    cuisineList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.only(top: 2,bottom: 2,left: 5,right: 5),
        child: ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item),
          ),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        primaryColor: Colors.orange.shade600,
    ),
    home: Scaffold(
          body: ListView(
        padding: EdgeInsets.only(left: 15,right: 15,top: 10),
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: new Icon(Icons.arrow_back_ios,color: Colors.grey,),
                  highlightColor: Colors.orange,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                "Filter",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),

              Text(
                "Apply",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Text(
            "Category",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Wrap(
           // children: _categoryChoiceList(),

          ),

          MultiSelectChip(
            categoryList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedCategoryList = selectedList;
              });
            },
          ),
          Text(selectedCategoryList.join(" , ")),
          SizedBox(height: 20,),
          Text(
            "Diet",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Wrap(
            //children: _dietChoiceList(),
          ),
          MultiSelectChip(
            dietList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedDietList = selectedList;
              });
            },
          ),
          Text(selectedDietList.join(" , ")),

          SizedBox(height: 20,),
          Text(
            "Cuisine",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Wrap(
           // children: _cuisineChoiceList(),
          ),
          MultiSelectChip(
            cuisineList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedCuisineList = selectedList;
              });
            },
          ),
          Text(selectedCuisineList.join(" , ")),
        ],
      ),
    ));
  }




  }


class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}