import 'package:flutter/material.dart';
import 'package:restaurant_app/models/list_profile_section.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/screens/AboutUsPage.dart';
import 'package:restaurant_app/screens/account_setting.dart';
import 'package:restaurant_app/screens/favorites_dish.dart';
import 'package:restaurant_app/screens/my_comments.dart';
import 'package:restaurant_app/screens/my_order.dart';
import 'package:restaurant_app/screens/profile_edit.dart';
import 'package:restaurant_app/screens/splash.dart';
import 'package:restaurant_app/screens/step_indicator_demo.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/CustomUtils.dart';
import 'dart:io';
import 'package:restaurant_app/util/image_picker_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccountScreenState createState() => new _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with
        SingleTickerProviderStateMixin,
        TickerProviderStateMixin,
        ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  bool isLoading = false;
  var sToken, userID;
  var objectRes;
  List<ListProfileSection> listSection = new List();
  ProgressDialog pr;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    createListItem();
    _controller = new AnimationController(
      // value: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
    getProfile();
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    print('url $url');
    print('body $body');
    return http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
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

  getProfile() async {
    setState(() {
      isLoading = false;
    });

    // pr.show();
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
    });
    var response =
        await createPost(APIConstants.API_BASE_URL + 'profile', body: request);
    setState(() {
      isLoading = true;
    });
    objectRes = json.decode(response.body);
    print('REST response $objectRes');
    var sStatus = objectRes['status'];
    String message = objectRes['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
    } else {
      print(message);
      Constants.showToast(message);
    }
  }

  SaveString(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    // final key = 'my_int_key';
    //final value = 42;
    prefs.setString(key, value);
    print('saved $value');
  }

  logout() async {
    pr.show();
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
    });
    var response =
        await createPost(APIConstants.API_BASE_URL + 'logout', body: request);

    pr.hide().then((isHidden) {});
    var objectRes = json.decode(response.body);
    print('objectRes $objectRes');
    var sStatus1 = objectRes['status'];
    String message = objectRes['message']; //dataResponse['data']['f_name'];
    if (sStatus1 == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      setState(() {
        SaveString("user_id", 0);
      });
      Constants.showToast(message);
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
          ModalRoute.withName("/SplashScreen"));

      // Navigator.of(context).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
      return true;
    } else {
      Constants.showToast(message);
      return false;
    }
  }

  Future<void> logoutAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: const Text('Are you sure, You want to logout!'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('LOGOUT'),
              onPressed: () {
                logout();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: isLoading
              ? ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Profile',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.black)),
                            FlatButton(
                              onPressed: () {
                                logoutAlert(context);
                              },
                              child: new Text(
                                "Logout",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(
                                        fontSize: 20, color: Color(0xFFf18a01)),
                              ),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => imagePicker.showDialog(context),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: new Center(
                                    child: _image == null
                                        ? new Stack(
                                            children: <Widget>[
                                              new Center(
                                                child: Stack(
                                                    fit: StackFit.loose,
                                                    children: <Widget>[
                                                      new Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          CircleAvatar(
                                                            radius: 50.0,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    objectRes[
                                                                            'data']
                                                                        [
                                                                        'image']),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 50.0,
                                                                  left: 78.0),
                                                          child: new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              new CircleAvatar(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFf18a01),
                                                                radius: 18.0,
                                                                child: new Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ]),
                                              ),
                                            ],
                                          )
                                        : new Container(
                                            height: 90.0,
                                            width: 90.0,
                                            decoration: new BoxDecoration(
                                              color: const Color(0xff7c94b6),
                                              image: new DecorationImage(
                                                image: new ExactAssetImage(
                                                    _image.path),
                                                fit: BoxFit.cover,
                                              ),
                                              border: Border.all(
                                                  color: Colors.red,
                                                  width: 0.1),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  const Radius.circular(70.0)),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                objectRes['data']['name'],
                                                maxLines: 2,
                                                softWrap: true,
                                                style: CustomTextStyle
                                                    .textFormFieldSemiBold
                                                    .copyWith(fontSize: 18),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child:
                                                                  new GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  //Navigator.pushNamed(context, "myRoute");
                                                                  /* Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => ProfileEdit(objectRes)),
                                                            );*/

                                                                  final result =
                                                                      await Navigator
                                                                          .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ProfileEdit(objectRes)),
                                                                  );
                                                                  if (result) {
                                                                    getProfile();
                                                                  }
                                                                },
                                                                child: new Text(
                                                                  "Edit",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Color(
                                                                          0xFFf18a01)),
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Utils.getSizedBox(height: 6),
                                          Text(
                                            objectRes['data']['contact'],
                                            style: CustomTextStyle
                                                .textFormFieldRegular
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  objectRes['data']['email'],
                                                  style: CustomTextStyle
                                                      .textFormFieldRegular
                                                      .copyWith(
                                                          color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                flex: 100,
                              )
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountSetting()),
                            );
                            /*setState(() {
                // Not Called
              });*/
                          },
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: 8, top: 4),
                                        child: Text(
                                          "My Account",
                                          maxLines: 2,
                                          softWrap: true,
                                          style: CustomTextStyle
                                              .textFormFieldSemiBold
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Utils.getSizedBox(height: 6),
                                      Text(
                                        "Address, Payment, App Setting",
                                        style: CustomTextStyle
                                            .textFormFieldRegular
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrder()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: 8, top: 4),
                                        child: Text(
                                          "My Order",
                                          maxLines: 2,
                                          softWrap: true,
                                          style: CustomTextStyle
                                              .textFormFieldSemiBold
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Utils.getSizedBox(height: 6),
                                      Text(
                                        "All Order List",
                                        style: CustomTextStyle
                                            .textFormFieldRegular
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritesDish()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: 8, top: 4),
                                        child: Text(
                                          "Fovorite Dish",
                                          maxLines: 2,
                                          softWrap: true,
                                          style: CustomTextStyle
                                              .textFormFieldSemiBold
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Utils.getSizedBox(height: 6),
                                      Text(
                                        "Address, Payment, App Setting",
                                        style: CustomTextStyle
                                            .textFormFieldRegular
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StepPageIndicatorDemo()), //StepPageIndicatorDemo//Preferences
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: 8, top: 4),
                                        child: Text(
                                          "Preferences",
                                          maxLines: 2,
                                          softWrap: true,
                                          style: CustomTextStyle
                                              .textFormFieldSemiBold
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Utils.getSizedBox(height: 6),
                                      Text(
                                        "Dite, Sugar, Salt",
                                        style: CustomTextStyle
                                            .textFormFieldRegular
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
/*late salary ke chalte huye koi solution nhi milne pr aapke kehne se mene resignation kar diya hai par resignation our salary ko lakar aapka koi replay nhi aaya hai abhi tak. please reply me */
/*suffering late salary with no solution. our discussion after your says i send resignation but i am not received email over resignation and padding salary */
                        SizedBox(
                          height: 15,
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyComments()),
                            );
                          },
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: 8, top: 4),
                                        child: Text(
                                          "My Comments",
                                          maxLines: 2,
                                          softWrap: true,
                                          style: CustomTextStyle
                                              .textFormFieldSemiBold
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Utils.getSizedBox(height: 6),
                                      Text(
                                        "Comment posted ",
                                        style: CustomTextStyle
                                            .textFormFieldRegular
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                )
              : ColorLoader3()),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();

    ///pick crop image
    _controller.dispose();

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

  ///pick crop image
  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
    updatePicValidation();
  }

  updatePicValidation() {
    _image == null
        ? print(
            "Upload Profile Picture!") //registerToast("Upload Profile Picture!")
        : updatePic(_image);

    /* final form = _key.currentState;
    if (form.validate()) {
      form.save();
      pr = new ProgressDialog(context);
      // save();

    }*/
  }

  updatePic(File imageFile) async {
    pr = new ProgressDialog(context);
    pr.show();
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse(APIConstants.API_BASE_URL + 'edit-picture');
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    // multipart that takes file
    var multipartFile = new http.MultipartFile('profile_img', stream, length,
        filename: 'abc' //basename(imageFile.path)
        );

    request.fields['user_id'] = userID.toString();

    // add file to multipart
    request.files.add(multipartFile);

    print(request.fields);

    // send
    var responseMain = await request.send();
    print(responseMain.statusCode);

    // listen for response
    responseMain.stream.transform(utf8.decoder).listen((response) {
      print(response);
      print(response);
      // makeRequest();
      pr.hide().then((isHidden) {
        print(isHidden);
      });

      final dataResponse = jsonDecode(response);
      print(dataResponse);

      var objectRes = json.decode(response);
      var sStatus = objectRes['status'];
      print(sStatus);
      String message =
          dataResponse['message']; //dataResponse['data']['f_name'];
      if (sStatus) {
        print(message);
        Constants.showToast(message);
      } else {
        print("fail");
        print(message);
        Constants.showToast(message);
      }
    });
  }
}
