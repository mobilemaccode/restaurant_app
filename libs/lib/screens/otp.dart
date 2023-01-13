import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/screens/otp_verification.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:restaurant_app/util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OTPPage extends StatefulWidget {
  var fromClass;
  OTPPage(this.fromClass);

  @override
  _OTPPageState createState() => _OTPPageState(fromClass);
}

class _OTPPageState extends State<OTPPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final TextEditingController _controller = new TextEditingController();
  final _key = new GlobalKey<FormState>();
  var value;
  var userID;
  var fromClass;

  // var orderType = false;
  bool orderType = true;
  ProgressDialog pr;
  String contact;

  _OTPPageState(this.fromClass);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFf18a01),
      ),
      home: Scaffold(
        key: _scaffoldKey,
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
          /* title: Text(
            "OTP",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),*/
        ),
        body: Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 50, right: 50, bottom: 5),
              child: Form(
                key: _key,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                          fromClass == 'FORGOT'
                              ? "Create New \n   Account"
                              : "Forgot Your \n   Password",
                          maxLines: 2,
                          // softWrap: true,
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                          fromClass == 'FORGOT'
                              ? "Please enter a valid phone number\n to create your new Account"
                              : "We have send you an SMS with a code to your number?",
                          maxLines: 2,
                          // softWrap: true,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    /*Text(
                    "Or Sign up with Social network",
                    maxLines: 2,
                    // softWrap: true,
                    style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.normal)
                ),*/
                    Stack(
                        alignment: const Alignment(1.0, 1.0),
                        children: <Widget>[
                          new TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please Insert Contact Number";
                              }
                            },
                            onSaved: (e) => contact = e,
                            controller: _controller,
                            decoration: new InputDecoration(
                                labelText: "Enter your Mobile number"),
                            //decoration: new InputDecoration.collapsed(hintText: 'Mobile number'),
                            keyboardType: TextInputType.phone,
                          ),
                          new FlatButton(
                              onPressed: () {
                                _controller.clear();
                              },
                              child: new Icon(Icons.clear))
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity, // match_parent
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xFFf18a01))),
                        onPressed: () {
                          check();
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => OTPVerification()),);
                        },
                        color: Color(0xFFf18a01),
                        textColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Next".toUpperCase(),
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }),
      ),
    );
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      pr = new ProgressDialog(context);
      fromClass == 'FORGOT' ? loginForgot() : login();
    }
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    return http
        .post(url,
            headers: {
              "Content-Type": "application/json"
            }, //headers: {"Content-Type": "application/json"},
            body: body)
        .then((http.Response response) {
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

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xFFf18a01),
        textColor: Colors.white);
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
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600));
    pr.show();
    print(contact);
    //  print(password);
    var request = json.encode({
      "contact": contact,
      // "password": password,
      // "source_id": "fgdfgdfgdfgdf",
      //  "log_mode":"direct",
    });
    var response =
        await createPost(APIConstants.API_BASE_URL + 'signup', body: request);
    print(response);
    // makeRequest();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
    final dataResponse = jsonDecode(response.body);
    print(dataResponse);

    var objectRes = json.decode(response.body);
    var sStatus = objectRes['status'];
    print(sStatus);

    String message = dataResponse['message']; //dataResponse['data']['f_name'];

    if (sStatus == true) {
      userID = dataResponse['user_id'];
      Constants.SaveString("user_id", userID.toString());
      value = 1;
      setState(() {});
      print(message);
      loginToast(message);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPVerification(userID, fromClass, contact)),
      );
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }

  loginForgot() async {
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
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600));
    pr.show();
    print(contact);
    //  print(password);
    var request = json.encode({
      "contact": contact,
      // "password": password,
      // "source_id": "fgdfgdfgdfgdf",
      //  "log_mode":"direct",
    });
    var response = await createPost(
        APIConstants.API_BASE_URL + 'forget-password',
        body: request);
    print(response);
    // makeRequest();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
    final dataResponse = jsonDecode(response.body);
    print(dataResponse);

    var objectRes = json.decode(response.body);
    var sStatus = objectRes['status'];
    print(sStatus);

    String message = dataResponse['message']; //dataResponse['data']['f_name'];

    if (sStatus == true) {
      String emailAPI = "abc@gmail.com"; //dataResponse['data']['email'];
      String nameAPI = "abc"; //dataResponse['data']['f_name'];
      //String id = dataResponse['user_id'];
      userID = dataResponse['user_id'];
      Constants.SaveString("user_id", userID);
      value = 1;
      setState(() {
        // _loginStatus = LoginStatus.signIn;
        // savePref(value, emailAPI, nameAPI, id);
      });
      print(message);
      loginToast(message);
      //Navigator.push(context,MaterialPageRoute(
      //   builder: (context) => AudioScanner()),);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPVerification(userID, fromClass, contact)),
      );
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }
}
