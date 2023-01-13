import 'package:flutter/material.dart';
import 'package:restaurant_app/models/list_profile_section.dart';
import 'package:restaurant_app/screens/AboutUsPage.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:restaurant_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProfileEdit extends StatefulWidget {
  var objectRes;

  ProfileEdit(this.objectRes, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfileEditState createState() => new _ProfileEditState(objectRes);
}

//class _AccountScreenState extends State<AccountScreen>
class _ProfileEditState extends State<ProfileEdit>
    with SingleTickerProviderStateMixin {
  List<ListProfileSection> listSection = new List();
  var _isMale = true;
  String password;
  bool isLoading = false;
  ProgressDialog pr;
  String sName, sEmail, sGendar, userID, sToken, sPassword;

  bool _secureText = true;
  var objectRes;
  final _key = new GlobalKey<FormState>();
  final _key2 = new GlobalKey<FormState>();

  _ProfileEditState(this.objectRes);

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    print('Account $objectRes');
    // TODO: implement initState
    super.initState();
    createListItem();
    if (objectRes['data']['gender'] == 1) {
      setState(() {
        sGendar = "1";
        _isMale = true;
      });
    } else {
      setState(() {
        sGendar = "2";
        _isMale = false;
      });
    }
  }

  updateProfileValidation() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      pr = new ProgressDialog(context);
      updateProfile();
    }
  }

  updateProfile() async {
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

    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;


    if (_isMale) {
        sGendar = "1";
    } else {
        sGendar = "2";
    }


    var request = json.encode({
      "user_id": userID,
      "name": sName,
      "email": sEmail,
      "gender": sGendar,
      "token": sToken,
    });

    print('Login request $request');

    Future<http.Response> createPost(String url, {Object body}) async {
      return http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        return (response);
      });
    }

    var response = await createPost(APIConstants.API_BASE_URL + 'edit-profile',
        body: request);
    // makeRequest();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
    final dataResponse = jsonDecode(response.body);
    print('Login dataResponse $request');

    var objectRes = json.decode(response.body);
    var sStatus = objectRes['status'];
    String message = dataResponse['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      print("Succsess");
      print(message);
      Constants.showToast(message);
      Navigator.pop(context, true);
    } else {
      print("fail");
      print(message);
      Constants.showToast(message);
    }
  }

  updatePasswordValidation() {
    final form = _key2.currentState;
    if (form.validate()) {
      form.save();
      pr = new ProgressDialog(context);
      updatePassword();
    }
  }

  updatePassword() async {
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

    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;

    var request = json.encode({
      "user_id": userID,
      "password": sPassword,
      "token": sToken,
    });

    print('Login request $request');

    Future<http.Response> createPost(String url, {Object body}) async {
      return http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        return (response);
      });
    }

    var response = await createPost(APIConstants.API_BASE_URL + 'change-password',
        body: request);
    // makeRequest();
    pr.hide().then((isHidden) {
      print(isHidden);
    });
    final dataResponse = jsonDecode(response.body);
    print('Responce $dataResponse');

    var objectRes = json.decode(response.body);
    var sStatus = objectRes['status'];
    String message = dataResponse['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      print(message);
      Constants.showToast(message);
      Navigator.pop(context, false);

    } else {
      print("fail");
      print(message);
      Constants.showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              onPressed: () {
               /// Navigator.pop(context);
                Navigator.pop(context, false);
              }),
          title: Text(
            "Profile Edit",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(50.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Form(
                key: _key,
                 child: Column(children: <Widget>[
                  /* TextFormField(
                     validator: (e) {
                       if (e.isEmpty) {
                         return "Please Enter Name";
                       }
                     },
                     onSaved: (e) => sName = e,
                     keyboardType: TextInputType.text,
                     maxLength: 20,
                     textAlign: TextAlign.center,
                     //autofocus: true,
                     initialValue: objectRes['data']['name'],
                     style:
                     TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                     decoration: InputDecoration(
                       hintText: 'Enter Name',
                       counterText: "",
                       contentPadding:
                       EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5.0)),
                     ),
                   ),*/

                   Theme(
                     data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                     child: TextFormField(
                       validator: (e) {
                         if (e.isEmpty) {
                           return "Please Enter Name";
                         }
                       },
                       onSaved: (e) => sName = e,
                       initialValue: objectRes['data']['name'],
                       keyboardType: TextInputType.emailAddress,
                       autofocus: false,
                       style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
                       decoration: InputDecoration(
                         filled: true,
                         fillColor: Color(0xFFf1f1f3),
                         hintText: 'Please Enter Email',
                         contentPadding:
                         const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.white),
                           borderRadius: BorderRadius.circular(25.7),
                         ),
                         enabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.white),
                           borderRadius: BorderRadius.circular(25.7),
                         ),
                       ),
                     ),
                   ),

                   SizedBox(
                     height: 40,
                   ),
        Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: TextFormField(
            validator: (e) {
              if (e.isEmpty) {
                return "Please Enter Email";
              }
            },
            onSaved: (e) => sEmail = e,
            initialValue: objectRes['data']['email'],
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFf1f1f3),
              hintText: 'Please Enter Email',
              contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
          ),
        ),
                   /*TextFormField(
                     color: Color(0xFFf18a01),
                     validator: (e) {
                       if (e.isEmpty) {
                         return "Please Enter Email";
                       }
                     },
                     onSaved: (e) => sEmail = e,
                     keyboardType: TextInputType.emailAddress,
                     maxLength: 20,
                     textAlign: TextAlign.center,
                     //autofocus: true,
                     initialValue: objectRes['data']['email'],
                     style:
                     TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                     decoration: InputDecoration(
                       hintText: 'Enter Email',
                       counterText: "",
                       contentPadding:
                       EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5.0)),
                     ),
                   ),*/
                 ],),
                ),

                    SizedBox( height: 40,),

                    Container(
                      color: Colors.transparent,
                      child: new Container(
                        width: double.infinity,
                          decoration: new BoxDecoration(
                              color: Color(0xFFf1f1f3),
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(25.7),
                                topRight: const Radius.circular(25.7),
                                bottomLeft: const Radius.circular(25.7),
                                bottomRight: const Radius.circular(25.7),
                              )
                          ),
                          child: new  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: new Text(
                              objectRes['data']['contact'],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),

                            ),
                          ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Select your Gendar",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          //SizedBox(width: 20,),
                          Container(
                            child: content(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    RaisedButton( onPressed: () {
                        updateProfileValidation();
                        //Navigator.push(context,new MaterialPageRoute(builder: (context) => CheckOutPage()));
                      },
                      color: Color(0xFFf18a01),
                      padding: EdgeInsets.only(
                          top: 12, left: 60, right: 60, bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Text(
                        "Save",
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text("Change Password",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _key2,
                      child:  Theme(
                        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please Enter Password";
                            }
                          },
                          onSaved: (e) => sPassword = e,
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          autofocus: false,
                          style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFf1f1f3),
                            hintText: 'Enter New Password',
                            contentPadding:
                            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                      /*TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please Enter Password";
                        }
                      },
                      onSaved: (e) => sPassword = e,
                      keyboardType: TextInputType.number,
                      maxLength: 20,
                      textAlign: TextAlign.center,
                      //autofocus: true,
                      //  initialValue: objectRes['data']['contact'],
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Enter New Password',
                        counterText: "",
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                              color: Colors.orange, width: 0.0),
                        ),
                      ),
                    ),*/
                    ),
                    /*TextFormField(
          decoration: InputDecoration(
              labelText: 'Enter your username'
          ),
        ),*/

                    /*Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(objectRes['data']['email'],
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          )),
                    ),*/
                    RaisedButton(
                      onPressed: () {
                        updatePasswordValidation();
                        //Navigator.push(context,new MaterialPageRoute(builder: (context) => CheckOutPage()));
                      },
                      color: Color(0xFFf18a01),
                      padding: EdgeInsets.only(
                          top: 12, left: 60, right: 60, bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Text(
                        "Submit",
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),

            ),
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  updateProfileValidation();
                  /*setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });*/
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Color(0xFFf18a01),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Color(0xFFf18a01),
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return createListViewItem(listSection[index]);
      },
      itemCount: listSection.length,
    );
  }

  createListViewItem(ListProfileSection listSection) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colors.teal.shade200,
        onTap: () {
          if (listSection.widget != null) {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => listSection.widget));
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 12),
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            children: <Widget>[
              /*Image(
                image: AssetImage(listSection.icon),
                width: 20,
                height: 20,
                color: Colors.grey.shade500,
              ),*/

              Column(
                children: <Widget>[
                  Text(
                    listSection.title,
                    style: CustomTextStyle.textFormFieldBold
                        .copyWith(color: Colors.black),
                  ),
                  Text("Address, Payment App",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.grey.shade500,
              )
            ],
          ),
        ),
      );
    });
  }

  createSection(String title, String icon, Color color, Widget widget) {
    return ListProfileSection(title, icon, color, widget);
  }

  void createListItem() {
    listSection.add(createSection("Notifications", "images/ic_notification.png",
        Colors.blue.shade800, null));
    listSection.add(createSection(
        "Payment Method", "images/ic_payment.png", Colors.teal.shade800, null));
    listSection.add(createSection("Invite Friends",
        "images/ic_invite_friends.png", Colors.indigo.shade800, null));
    listSection.add(createSection("About Us", "images/ic_about_us.png",
        Colors.black.withOpacity(0.8), AboutPage()));
    listSection.add(createSection("Logout", "images/ic_logout.png",
        Color(0xFFf18a01).withOpacity(0.7), null));
  }

  ///////////////////////////////////////////////
  Container _buildSelect({String text, Color background, Color textColor}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75.0), color: background),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20.0),
      )),
    );
  }

  Widget _buildGenderSelect({String gender, bool selected}) {
    var button = selected
        ? _buildSelect(
            text: gender,
            textColor: Color(0xFFf18a01),
            background: Colors.white)
        : _buildSelect(
            text: gender,
            textColor: Colors.white,
            background: Color(0xFFf18a01));

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
      _buildGenderSelect(gender: "M", selected: !_isMale),
      _buildGenderSelect(gender: "F", selected: _isMale),
    ]);
  }
}
/////////////////
