import 'dart:convert';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/screens/Register.dart';
import 'package:restaurant_app/screens/audio_scanner.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/screens/home_first.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'package:restaurant_app/screens/main_screen.dart';
import 'package:restaurant_app/screens/otp.dart';
import 'package:restaurant_app/screens/scan.dart';
import 'package:restaurant_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  final _key = new GlobalKey<FormState>();
  static final CREATE_POST_URL = 'http://democarol.com/apartment_booking/Api/signin';
  bool _secureText = true;
  ProgressDialog pr;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      pr = new ProgressDialog(context);
      login();
    }
  }

  Future<String> makeRequest() async {
    var request = json.encode({
      "email": email,
      "password": password,
      "source_id": "fgdfgdfgdfgdf",
      "log_mode":"direct",
    });
    print(request);
    var response = await http
        .post(Uri.encodeFull(CREATE_POST_URL), body: request, headers: {"Accept": "application/json"});
    print(response);
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    return http.post(url, body: body).then((http.Response response) {
      print(response.body.toString());
      var objectRes = json.decode(response.body);
      var sStatus = objectRes['success'];
      print(sStatus);
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  login() async {
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
    pr.show();
    print(email);
    print(password);
    var request = json.encode({
      "email": email,
      "password": password,
      "source_id": "fgdfgdfgdfgdf",
      "log_mode":"direct",
    });
    var response = await createPost(CREATE_POST_URL, body: request);
    print(response);
    // makeRequest();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
    final dataResponse = jsonDecode(response.body);
    print(dataResponse);
    String message = dataResponse['data']['f_name'];
    String emailAPI = dataResponse['data']['email'];
    String nameAPI = dataResponse['data']['f_name'];
    String id = dataResponse['data']['id'];
    value = 1;
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, nameAPI, id);
      });
      print(message);
      loginToast(message);
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFFf18a01),
        textColor: Colors.white);
  }

  savePref(int value, String email, String name, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          body:
          Stack(
            children: <Widget>[
              Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15.0),
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
//            color: Colors.grey.withAlpha(20),
                        //color: Colors.brown,
                        child: Form(
                          key: _key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*Image.network(
                              "https://www.logogenie.net/download/preview/medium/3589659"),*/
                              Center(
                                child: new Image.asset(
                                  'assets/images/login_bg.png',
                                  width: double.infinity,
                                  //fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                child: Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  "Login to your account",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14.0, fontStyle: FontStyle.normal),
                                ),
                              ),

                              //card for Email TextFormField
                              Card(
                                elevation: 6.0,
                                child: TextFormField(
                                  validator: (e) {
                                    if (e.isEmpty) {
                                      return "Please Insert Email";
                                    }
                                  },
                                  onSaved: (e) => email = e,
                                  style: TextStyle(
                                    color: Color(0xFFf18a01),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                        child:
                                        Icon(Icons.person, color: Colors.black),
                                      ),
                                      contentPadding: EdgeInsets.all(18),
                                      labelText: "Email"),
                                ),
                              ),
                              // Card for password TextFormField
                              Card(
                                elevation: 6.0,
                                child: TextFormField(
                                  validator: (e) {
                                    if (e.isEmpty) {
                                      return "Password Can't be Empty";
                                    }
                                  },
                                  obscureText: _secureText,
                                  onSaved: (e) => password = e,
                                  style: TextStyle(
                                    color: const Color(0xFFf18a01),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 20, right: 15),
                                      child: Icon(Icons.phonelink_lock,
                                          color: Colors.black),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: showHide,
                                      icon: Icon(_secureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    contentPadding: EdgeInsets.all(18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(

                                width: double.infinity, // match_parent
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color(0xFFf18a01))),
                                  onPressed: () { Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AudioScanner()),
                                  );},
                                  color: Color(0xFFf18a01),
                                  textColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text("Login".toUpperCase(),
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(14.0),
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  /*SizedBox(
                                    height: 100.0,
                                    width: 100.0,
                                    child: FloatingActionButton(
                                      onPressed: (){
                                        check();
                                      },
                                      backgroundColor: const Color(0xFFef6c03),
                                      child: Icon(Icons.arrow_forward,
                                        size: 50.0,),
                                    ),
                                  ),*/
                                  FlatButton(
                                    onPressed: null,
                                    child: Text(
                                      "Forgot Your Password?",
                                      style: TextStyle(
                                        fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    //height: 100.0,
                                    child:/*const Text.rich(
                                  TextSpan(
                                    text: 'Hello', // default text style
                                    children: <TextSpan>[
                                      TextSpan(text: "Don't Have an Account?", style: TextStyle(fontStyle: FontStyle.italic)),
                                      TextSpan(text: 'Register', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )*/
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OTPPage()),
                                        );
                                      },
                                      child: Center(
                                        child:const Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(text: "Don't Have an Account?", style: TextStyle(fontStyle: FontStyle.normal,fontSize: 18.0)),
                                              TextSpan(text: 'Sign Up', style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFf18a01),fontSize: 18.0),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    /*child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Text(
                                      "GoTo Register",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    textColor: Colors.white,
                                    color: Color(0xFFf7d426),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()),
                                      );
                                    }),*/
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomeIndex();//MainScreen();//MainMenu(signOut);
//        return ProfilePage(signOut);
        break;
    }
  }
}
