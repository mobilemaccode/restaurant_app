import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/screens/Login.dart';
import 'package:restaurant_app/util/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _isMale = true;
  String email, userName, mobile, password;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;
  ProgressDialog pr;
  static final CREATE_POST_URL =
      'http://democarol.com/apartment_booking/Api/signup';
  int value;

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
      save();
    }
  }

  Future<String> makeRequest() async {
    var request = json.encode({
      "user_name": userName,
      "email": email,
      "mobile": mobile,
      "password": password,
      "fcm_token": "test_fcm_token"
    });
    print(request);
    var response = await http.post(Uri.encodeFull(CREATE_POST_URL),
        body: request, headers: {"Accept": "application/json"});
    print(response);
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    return http.post(url, body: body).then((http.Response response) {
      print(response.body.toString());
      var objectRes = json.decode(response.body);
      var sStatus = objectRes['success'];
      print(sStatus);
      if (sStatus == "false") {
        //Scaffold.of(context).showSnackBar(SnackBar( content: Text("Sending Message"),));
        Fluttertoast.showToast(
            msg: objectRes['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Color(0xFFf18a01),
            textColor: Colors.white,
            fontSize: 16.0);
      }
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  save() async {
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
    print(userName);
    print(email);
    print(password);
    var request = json.encode({
      "user_name": userName,
      "email": email,
      "password": password,
      "user_name": userName,
      "source_id": "fgdfgdfgdfgdf",
      "log_mode": "direct",
    });
    print(request);
    var response = await createPost(CREATE_POST_URL, body: request);
    print(response);
    // makeRequest();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
    final dataResponse = jsonDecode(response.body);
    print(dataResponse);
    String message = dataResponse['message'];
    // String emailAPI = dataResponse['data']['email'];
    // String nameAPI = dataResponse['data']['f_name'];
    //  String id = dataResponse['data']['id'];
    value = 1;
    /*if (value == 1) {
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
    }*/
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      print(message);
      registerToast(message);
    } else if (value == 2) {
      print(message);
      registerToast(message);
    } else {
      print(message);
      registerToast(message);
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.white,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Center(
              /*child: new Image.asset(
                  'assets/images/login_bg.png',
                  fit: BoxFit.fill,
                ),*/
              ),
          Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    //color: Colors.white,
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
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              "Signup to your account",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),

                          //card for Fullname TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please insert Username";
                                }
                              },
                              onSaved: (e) => userName = e,
                              style: TextStyle(
                                color: Colors.black,
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
                                  labelText: "Username"),
                            ),
                          ),
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please insert Phone Number";
                                }
                              },
                              onSaved: (e) => mobile = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.phone, color: Colors.black),
                                ),
                                contentPadding: EdgeInsets.all(18),
                                labelText: "Phone Number",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          //card for Email TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please insert Email Id";
                                }
                              },
                              onSaved: (e) => email = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child:
                                        Icon(Icons.email, color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Email Id"),
                            ),
                          ),
                          //card for Mobile TextFormField
                          //card for Password TextFormField
                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              obscureText: _secureText,
                              onSaved: (e) => password = e,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phonelink_lock,
                                        color: Colors.black),
                                  ),
                                  contentPadding: EdgeInsets.all(18),
                                  labelText: "Password"),
                            ),
                          ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Select your Gendar",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 100,
                    child: content(),
                  ),
                ],
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
                                  side: BorderSide(
                                      color: Color(0xFFf18a01))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              color: Color(0xFFf18a01),
                              textColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Register".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(12.0),
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
                                      backgroundColor: Colors.deepOrangeAccent,
                                      child: Icon(Icons.arrow_forward,
                                        size: 50.0,),
                                    ),
                                  ),*/
                              SizedBox(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  },
                                  child: Center(
                                    child: const Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "Alredy Have an Account?",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18.0)),
                                          TextSpan(
                                            text: 'Login',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFf18a01),
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
        ]));
  }


  ///////////////////////////////////////////////
  Container _buildSelect({String text, Color background, Color textColor}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75.0), color: background),
      child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 25.0),
          )),
    );
  }

  Widget _buildGenderSelect({String gender, bool selected}) {
    var button = selected
        ? _buildSelect(
        text: gender, textColor: Color(0xFFf18a01), background: Colors.white)
        : _buildSelect(
        text: gender, textColor: Colors.white, background: Color(0xFFf18a01));

    return GestureDetector(
      child: button,
      onTap: () {
        setState(() {
          _isMale = !_isMale;
        });
      },
    );
  }

  Widget content() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _buildGenderSelect(gender: "M", selected: _isMale),
      _buildGenderSelect(gender: "F", selected: !_isMale),
    ]);
  }

}
