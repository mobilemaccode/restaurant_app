import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'dart:async';
import 'package:restaurant_app/util/const.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StepPageIndicatorDemo extends StatefulWidget {
  @override
  _StepPageIndicatorDemoState createState() {
    return _StepPageIndicatorDemoState();
  }
}

class _StepPageIndicatorDemoState extends State<StepPageIndicatorDemo> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  bool isLoading  = false;
  ProgressDialog pr;
  var sToken, userID,restaurantsId, context, listPreferences, msg;
 String titleName = "Preferences";
  FocusNode myFocusNode = new FocusNode();
  final sAllergiesType = TextEditingController();
  final sBreakfastMeal = TextEditingController();
  final sDinnerMeal = TextEditingController();
  final sLunchMeal = TextEditingController();
  List<bool> valueDiet = new List<bool>();
  List<bool> valueBarbecue = new List<bool>();
  List<bool> valueSugar = new List<bool>();
  List<bool> valueSalt = new List<bool>();
  List<bool> valueFavouriteKitchen = new List<bool>();
  List<bool> valueFavouriteFood = new List<bool>();
  List<bool> valuePepper = new List<bool>();
  List<bool> valueDish = new List<bool>();
  List<bool> valueBread = new List<bool>();
  List<bool> valueDrink = new List<bool>();

  final Set<WordPair> _saved = Set<WordPair>();

  double padValue = 0;

  List<String> dietList = List();
  List<String> barbecueList = List();
  List<String> sugarList = List();
  List<String> saltList = List();
  List<String> favoriteKitchenList = List();
  List<String> favouriteFoodList = List();
  List<String> peeperList = List();
  List<String> dishList = List();
  List<String> breadList = List();
  List<String> drinkList = List();


  void initState() {
    super.initState();
    this.context = context;
    pr = new ProgressDialog(context);
    pr.style(
        message: ProgressDialogTitles.USER_LOG_IN,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)
    );
    getPreferences();
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    print('url $url');
    print('body $body');
    return http.post(url, headers: {"Content-Type": "application/json"}, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
    });
    var response = await createPost(APIConstants.API_BASE_URL+ 'get-preferences-list',
        body: request);
    listPreferences = json.decode(response.body);
    var sStatus = listPreferences['status'];
    String message = listPreferences['message'];//dataResponse['data']['f_name'];
    if (sStatus == true) {
      sAllergiesType.text = listPreferences['data']['allergies'];
      sBreakfastMeal.text = listPreferences['data']['Breakfast_meal'];
      sDinnerMeal.text = listPreferences['data']['Dinner_Meal'];
      sLunchMeal.text = listPreferences['data']['Lunch_Meal'];

      setState(() {
        for(int i=0;i<listPreferences['data']['Diet'].length;i++){
          if(listPreferences['data']['Diet'][i]['status'] == 1){
            dietList.add(listPreferences['data']['Diet'][i]['name']);
            valueDiet.add(true);
          }else{
            valueDiet.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Barbecue'].length;i++){
          if(listPreferences['data']['Barbecue'][i]['status'] == 1){
            barbecueList.add(listPreferences['data']['Barbecue'][i]['name']);

            valueBarbecue.add(true);
          }else{
            valueBarbecue.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Sugar'].length;i++){
          if(listPreferences['data']['Sugar'][i]['status'] == 1){
            sugarList.add(listPreferences['data']['Sugar'][i]['name']);
            valueSugar.add(true);
          }else{
            valueSugar.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Salt'].length;i++){
          if(listPreferences['data']['Salt'][i]['status'] == 1){
            saltList.add(listPreferences['data']['Salt'][i]['name']);
            valueSalt.add(true);
          }else{
            valueSalt.add(false);
          }
        }

        /////////////
        for(int i=0;i<listPreferences['data']['Favourite_kitchen'].length;i++){
          if(listPreferences['data']['Favourite_kitchen'][i]['status'] == 1){
            favoriteKitchenList.add(listPreferences['data']['Favourite_kitchen'][i]['name']);
            valueFavouriteKitchen.add(true);
          }else{
            valueFavouriteKitchen.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Favourite_food'].length;i++){
          if(listPreferences['data']['Favourite_food'][i]['status'] == 1){
            favouriteFoodList.add(listPreferences['data']['Favourite_food'][i]['name']);
            valueFavouriteFood.add(true);
          }else{
            valueFavouriteFood.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Pepper'].length;i++){
          if(listPreferences['data']['Pepper'][i]['status'] == 1){
            peeperList.add(listPreferences['data']['Pepper'][i]['name']);
            valuePepper.add(true);
          }else{
            valuePepper.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Dish'].length;i++){
          if(listPreferences['data']['Dish'][i]['status'] == 1){
            dishList.add(listPreferences['data']['Dish'][i]['name']);
            valueDish.add(true);
          }else{
            valueDish.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Bread'].length;i++){
          if(listPreferences['data']['Bread'][i]['status'] == 1){
            breadList.add(listPreferences['data']['Bread'][i]['name']);
            valueBread.add(true);
          }else{
            valueBread.add(false);
          }
        }

        for(int i=0;i<listPreferences['data']['Drink'].length;i++){
          if(listPreferences['data']['Drink'][i]['status'] == 1){
            drinkList.add(listPreferences['data']['Drink'][i]['name']);
            valueDrink.add(true);
          }else{
            valueDrink.add(false);
          }
        }

      });

      setState(() {
        isLoading  = true;
      });
    } else {
      setState(() {
        isLoading  = true;
      });
      Constants.showToast(message);
    }
  }

  setPreferences() async {
    pr.show();
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    restaurantsId = prefs.getString("restaurant") ?? 0;
    print('restaurantsId $restaurantsId');
      var request = json.encode({
        "user_id": userID,
        "token": sToken,
        "diet_type": dietList,
        "allergies": sAllergiesType.text,
        "barbecue": barbecueList,
        "sugar": sugarList,
        "salt": saltList,
        "favorite_kitchen": favoriteKitchenList,
        "favourite_food": favouriteFoodList,
        "peeper": peeperList,
        "dish": dishList,
        "bread": breadList,
        "drink": drinkList,
        "breakfast_meal": sBreakfastMeal.text,
        "dinner_meal": sDinnerMeal.text,
        "lunch_meal": sLunchMeal.text,
      });
      var response = await createPost(APIConstants.API_BASE_URL+ 'edit-preferences-list',
          body: request);
     var responseObject = json.decode(response.body);
      setState(() {
        isLoading  = true;
      });
      print('response $responseObject');
      var sStatus = responseObject['status'];
      String message = responseObject['message'];//dataResponse['data']['f_name'];
      if (sStatus == true) {
        Navigator.pop(context);
        Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeIndex()));
      } else {
        Constants.showToast(message);
      }

  }

  @override
  Widget build(BuildContext context) {
    setState(() => this.context = context);
    return Scaffold(
      //backgroundColor: Colors.blueGrey.shade200,
      /*resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,*/
      appBar: AppBar(
        title: Text(titleName),
      ),
      body:isLoading? _buildBody()
          : ColorLoader3()
    );
  }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildPageView(),
        _buildStepIndicator(),
      ],
    );
  }

  _buildPageView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: PageView.builder(
          itemCount: 14,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return getCustomContainer(index, context);
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          },
        ),
      ),
    );
  }

  _buildStepIndicator() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: StepPageIndicator(
        itemCount: 14,
        currentPageNotifier: _currentPageNotifier,
        stepColor: Colors.orange.shade600,
        size: 16,
        onPageSelected: (int index) {
          if (_currentPageNotifier.value > index)
            _pageController.jumpToPage(index);
        },
      ),
    );
  }

  Widget getCustomContainer(index,mContext) {
    switch (index) {
      case 0:
        return Stack(children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.only(top: 50),
              itemCount: valueDiet.length,
              itemBuilder: (BuildContext context, int index){
                Map menuList = listPreferences['data']['Diet'][index] ;
                final bool alreadySaved = valueDiet[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuList['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        dietList.remove(menuList['name']);
                        valueDiet[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        dietList.add(menuList['name']);
                        valueDiet[index] = true;// _saved.add(menuList['name']);
                      }
                      print(dietList);
                    });
                  },
                );
              }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Diet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 1:
        return Stack(children: <Widget>[
        Center(
        child: TextFormField(
          controller: sAllergiesType,
          focusNode: myFocusNode,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Colors.black : Colors.black
            ),
            fillColor: Colors.orange,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFf18a01), width: 2.0),
              //borderRadius: BorderRadius.circular(25.0),
            ),
            border: OutlineInputBorder(),
            labelText: "Enter Allergies Type",
            hintText: "Enter",
          ),
        )
    ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Allergies",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 2:
        return Stack(children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueBarbecue.length,
              itemBuilder: (BuildContext context, int index){
                Map menuListBarbecue = listPreferences['data']['Barbecue'][index] ;
                final bool alreadySaved = valueBarbecue[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuListBarbecue['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        barbecueList.remove(menuListBarbecue['name']);
                        valueBarbecue[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        barbecueList.add(menuListBarbecue['name']);
                        valueBarbecue[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Barbecue",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 3:
        return Stack(children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueSugar.length,
              itemBuilder: (BuildContext context, int index){
                Map menuListSugar = listPreferences['data']['Sugar'][index] ;
                final bool alreadySaved = valueSugar[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuListSugar['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        sugarList.add(menuListSugar['name']);

                        valueSugar[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        sugarList.add(menuListSugar['name']);

                        valueSugar[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Sugar",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 4:
        return Stack(children: <Widget>[

          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueSalt.length,
              itemBuilder: (BuildContext context, int index){
                Map menuListSalt = listPreferences['data']['Salt'][index] ;
                final bool alreadySaved = valueSalt[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuListSalt['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        saltList.add(menuListSalt['name']);
                        valueSalt[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        saltList.add(menuListSalt['name']);
                        valueSalt[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Salt",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 5:
        return Stack(children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueFavouriteKitchen.length,
              itemBuilder: (BuildContext context, int index){
                Map menuList = listPreferences['data']['Favourite_kitchen'][index] ;
                final bool alreadySaved = valueFavouriteKitchen[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuList['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        favoriteKitchenList.add(menuList['name']);
                      valueFavouriteKitchen[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        favoriteKitchenList.add(menuList['name']);
                        valueFavouriteKitchen[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Favourite kitchen",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 6:
        return Stack(children: <Widget>[

          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueFavouriteFood.length,
              itemBuilder: (BuildContext context, int index){
                Map menuList = listPreferences['data']['Favourite_food'][index] ;
                final bool alreadySaved = valueFavouriteFood[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuList['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        favouriteFoodList.add(menuList['name']);
                        valueFavouriteFood[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        favouriteFoodList.add(menuList['name']);
                        valueFavouriteFood[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),


          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Favourite Food",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 7:
        return  Stack(children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valuePepper.length,
              itemBuilder: (BuildContext context, int index){
                Map menuList = listPreferences['data']['Pepper'][index] ;
                final bool alreadySaved = valuePepper[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuList['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        peeperList.add(menuList['name']);
                        valuePepper[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        peeperList.add(menuList['name']);
                        valuePepper[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Pepper",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 8:
        return Stack(children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueDish.length,
              itemBuilder: (BuildContext context, int index){
                Map menuList = listPreferences['data']['Dish'][index] ;
                final bool alreadySaved = valueDish[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuList['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        dishList.add(menuList['name']);
                        valueDish[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        dishList.add(menuList['name']);
                        valueDish[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Dish",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 9:
        return Stack(children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueBread.length,
              itemBuilder: (BuildContext context, int index){
                Map menuList = listPreferences['data']['Bread'][index] ;
                final bool alreadySaved = valueBread[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuList['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        breadList.add(menuList['name']);
                        valueBread[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        breadList.add(menuList['name']);
                        valueBread[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Bread",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 10:
        return Stack(children: <Widget>[
          ListView.builder(
              padding: EdgeInsets.only(top: 50),
              itemCount: valueDrink.length,
              itemBuilder: (BuildContext context, int index){
                Map menuList = listPreferences['data']['Drink'][index] ;
                final bool alreadySaved = valueDrink[index];//_saved.contains(menuList['name']);
                return ListTile(
                  title:  Text(menuList['name'],style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),),
                  trailing: Icon(
                    alreadySaved ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: alreadySaved ? Color(0xFFf18a01) : null,
                  ),
                  onTap: () {
                    setState(() {
                      print('alreadySaved: $alreadySaved');
                      if (alreadySaved) {
                        drinkList.add(menuList['name']);
                        valueDrink[index] = false;//_saved.remove(menuList['name']);
                      } else {
                        drinkList.add(menuList['name']);
                        valueDrink[index] = true;// _saved.add(menuList['name']);
                      }
                    });
                  },
                );
              }
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Drink",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);
      case 11:
        return Stack(children: <Widget>[
        Center(
        child: TextFormField(
          controller: sBreakfastMeal,
          focusNode: myFocusNode,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Colors.black : Colors.black
            ),
            fillColor: Colors.orange,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFf18a01), width: 2.0),
              //borderRadius: BorderRadius.circular(25.0),
            ),
            border: OutlineInputBorder(),
            labelText: "Enter Breakfast Meal",
            hintText: "Enter",
          ),
        )
    ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Breakfast Meal",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);

      case 12:
        return Stack(children: <Widget>[
        Center(
        child: TextFormField(
          controller: sDinnerMeal,
          focusNode: myFocusNode,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Colors.black : Colors.black
            ),
            fillColor: Colors.orange,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFf18a01), width: 2.0),
              //borderRadius: BorderRadius.circular(25.0),
            ),
            border: OutlineInputBorder(),
            labelText: "Enter Dinner Meal",
            hintText: "Enter",
          ),
        )
    ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Dinner Meal",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],);

      case 13:
        return Stack(children: <Widget>[
        Center(
        child: TextFormField(
          controller: sLunchMeal,
          focusNode: myFocusNode,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Colors.black : Colors.black
            ),
            fillColor: Colors.orange,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFf18a01), width: 2.0),
              //borderRadius: BorderRadius.circular(25.0),
            ),
            border: OutlineInputBorder(),
            labelText: "Enter Lunch Meal",
            hintText: "Enter",
          ),
        )
    ),
    Padding(
    padding: const EdgeInsets.only(left: 25),
    child: Text(
    "Lunch Meal",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    ),
    ),
    ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
            onPressed: () {
              print("Save And Next");
              setPreferences();
             // Navigator.pop(context);
             // Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeIndex()));

            },
            color: Color(0xFFf18a01),
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Save And Next",
              style: TextStyle(color: Colors.white),
            ),
          ),)
        ],);
    }
   // return Container();
  }

  var condts = {
    0: Container(
  child: Center(
  child: Text(
  'Step ',
  ),
  )
  ),
    1: Container(),
    2: Row(),
    3: Column(),
    4: Stack(),
    5: Stack(),
    6: Stack(),
    7: Stack(),
  };

  void ItemChange(bool val,int index){
    setState(() {
      valueDiet[index] = val;
    });
  }




}
