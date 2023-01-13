import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:restaurant_app/screens/Register.dart';
import 'package:restaurant_app/screens/create_password.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:restaurant_app/util/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPVerification extends StatefulWidget {
  var userID, fromClass, contact;
  OTPVerification(this.userID, this.fromClass, this.contact);
  @override
  _OTPVerificationState createState() =>
      _OTPVerificationState(userID, fromClass, contact);
}

class _OTPVerificationState extends State<OTPVerification> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final TextEditingController _controller = new TextEditingController();
  ProgressDialog pr;

  var sToken, userID, otpValue, fromClass, contact;

  // var orderType = false;
  bool orderType = true;
  final _key = new GlobalKey<FormState>();
  var value;

  _OTPVerificationState(this.userID, this.fromClass, this.contact);

  sendOtp() async {
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
      print(message);
      loginToast(message);
    } else {
      print("fail");
      print(message);
      loginToast(message);
    }
  }

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
            padding:
                const EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 5),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text("        OTP \n   Verification",
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
                      "We have send the OTP on your number\n will apply auto to the field",
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
                SizedBox(
                  child: PinEntryTextField(
                    onSubmit: (String pin) {
                      otpValue = pin;
                      /*showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Pin"),
                              content: Text('Pin entered is $pin'),
                            );
                          }
                      );*/ //end showDialog()
                      //onSaved: (e) => otpValue = pin;
                      check();
                    }, // end onSubmit
                  ), //Text("-    -    -    -",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black),),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {
                    sendOtp();
                  },
                  child: new Text("Resend OTP?",
                      maxLines: 2,
                      // softWrap: true,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFf18a01),
                          fontWeight: FontWeight.bold)),
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
                    onPressed: () {
                      check();
                    },
                    color: Color(0xFFf18a01),
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Submit".toUpperCase(),
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  check() {
    /*final form = _key.currentState;
    if (form.validate()) {
      form.save();
      pr = new ProgressDialog(context);
      login();
    }*/

    if (!["", null, false, 0].contains(otpValue)) {
      // form.save();
      pr = new ProgressDialog(context);
      login();
    }
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    print('url $url');
    print('body: $body');
    return http
        .post(url,
            headers: {
              "Content-Type": "application/json"
            }, //headers: {"Content-Type": "application/json"},
            body: body)
        .then((http.Response response) {
      print(response.body.toString());
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
    var request = json.encode({
      "otp": otpValue,
      "user_id": userID,
    });
    var response = await createPost(APIConstants.API_BASE_URL + 'otpVerify',
        body: request);
    pr.hide().then((isHidden) {});
    final dataResponse = jsonDecode(response.body);
    print(dataResponse);
    var objectRes = json.decode(response.body);
    var sStatus = objectRes['status'];
    String message = dataResponse['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      String emailAPI = "abc@gmail.com"; //dataResponse['data']['email'];
      String nameAPI = "abc"; //dataResponse['data']['f_name'];
      userID = dataResponse['user_id'];
      sToken = dataResponse['token'];
      value = 1;
      setState(() {
        // _loginStatus = LoginStatus.signIn;
        // savePref(value, emailAPI, nameAPI, id);
      });
      print(message);
      loginToast(message);
      //Navigator.push(context,MaterialPageRoute(
      //   builder: (context) => AudioScanner()),);
      if (fromClass == "FORGOT") {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CreatePassword(sToken, userID.toString())),
        );
      } else
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Register(sToken, userID)),
        );
    } else {
      loginToast(message);
    }
  }
}
