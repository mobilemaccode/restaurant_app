import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FilterPage extends StatefulWidget {
  var restaurantFilter;
  var selectedCuisineList,selectedDietList;
  FilterPage(this.restaurantFilter, this.selectedCuisineList,this.selectedDietList);

  @override
  _FilterState createState() => _FilterState(this.restaurantFilter,selectedCuisineList,selectedDietList);
}

class _FilterState extends State<FilterPage> {
  var restaurantFilter;
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
    "Vegetarian","Non Vegetarian"
    /*"Vegetarian",
    "Meatless",
    "Baked",
    "Sugar-free",
    "Alcohol-free",
    "pan-free"*/
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


  List<String> selectedCuisineList1 = List();
  List<String> selectedDietList1 = List();

  _FilterState(this.restaurantFilter, this.selectedCuisineList1,this.selectedDietList1);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print("selectedCuisineList $selectedCuisineList");
      print("selectedDietList $selectedDietList");
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orange.shade600,
        ),
        home: Scaffold(
          body: ListView(
            padding: EdgeInsets.only(left: 15, right: 15, top: 50),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: new Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                    ),
                    highlightColor: Colors.orange,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('send selectedCuisineList  $selectedCuisineList');
                      print('send  selectedDietList  $selectedDietList');
                      // Navigator.pop(context, true);
                      Navigator.of(context)
                          .pop({'selectedCuisineList': selectedCuisineList,"selectedDietList":selectedDietList});
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              /*Text(
                "Category",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
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
              SizedBox(
                height: 20,
              ),*/
              Text(
                "Diet",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Wrap(
                  //children: _dietChoiceList(),
                  ),
              MultiSelectChip(
                selectedDietList1,
                dietList,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedDietList = selectedList;
                  });
                },
              ),
              Text(selectedDietList.join(" , ")),

              SizedBox(
                height: 20,
              ),
              Text(
                "Cuisine",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Wrap(
                  // children: _cuisineChoiceList(),
                  ),
              MultiSelectChip(
                selectedCuisineList1,
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
  List<String> selectedChoices = List();

  MultiSelectChip(this.selectedChoices,this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState(selectedChoices);
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = List();

  _MultiSelectChipState(this.selectedChoices);
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
