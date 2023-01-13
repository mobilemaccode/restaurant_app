import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants{

  static String appName = "Restaurant App";

  static String mailUrl = "Restaurant App";


  //Colors for theme
  static Color lightPrimary = Color(0xFFf7a539);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xFFf18a01);
  static Color darkAccent = Colors.orange.shade700;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );


  /*static SaveInt(key,value) async {
    final prefs = await SharedPreferences.getInstance();
    // final key = 'my_int_key';
    //final value = 42;
    prefs.setInt(key, value);
    print('saved $value');
  }*/
  static SaveString(key,value) async {
    final prefs = await SharedPreferences.getInstance();
    // final key = 'my_int_key';
    //final value = 42;
    prefs.setString(key, value);
    print('saved $value');
  }



  /*static ReadInt(key,value) async {
    final prefs = await SharedPreferences.getInstance();
    //final key = 'my_int_key';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
    return value;
  }*/
  static ReadString(key,value) async {
    final prefs = await SharedPreferences.getInstance();
    //final key = 'my_int_key';
    final value = prefs.getString(key) ?? 0;
    print('read: $value');
    return value;
  }

  static showToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFFf18a01),
        textColor: Colors.white);
  }

}