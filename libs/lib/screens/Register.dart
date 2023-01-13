import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/screens/Login.dart';
import 'package:restaurant_app/screens/audio_scanner.dart';
import 'package:restaurant_app/screens/step_indicator_demo.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:restaurant_app/util/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/image_picker_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:path/path.dart';
import 'package:path/path.dart' as Path;
import 'package:async/async.dart';
import 'dart:io';

class Register extends StatefulWidget {
  var sToken, userID;

  Register(this.sToken, this.userID);

  @override
  _RegisterState createState() => _RegisterState(sToken, userID);
}

class _RegisterState extends State<Register>
    with
        ImagePickerListener,
        SingleTickerProviderStateMixin,
        TickerProviderStateMixin {
  var _isMale = true;
  var gendar = 1;
  String email, userName, mobile, password,cPassword;
  var userID, userToken;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;
  ProgressDialog pr;
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  _RegisterState(this.userToken, this.userID);

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
      // save();
      _image == null
          ? print(
              "Please Upload Profile Picture!") //registerToast("Upload Profile Picture!")
          : upload(_image);
    }
  }

  SaveString(key,value) async {
    final prefs = await SharedPreferences.getInstance();
    // final key = 'my_int_key';
    //final value = 42;
    prefs.setString(key, value);
    print('saved $value');
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    return http.post(url, body: body).then((http.Response response) {
      print(response.body.toString());
      var objectRes = json.decode(response.body);
      var sStatus = objectRes['status'];
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

  uploadData(File imageFile) async {
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
    print(_isMale);
    if (_isMale) {
      gendar = 2;
    }
    print(gendar);

    var uri = Uri.parse(APIConstants.API_BASE_URL + 'personal-details');
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: 'abc' //basename(imageFile.path)
        );
    var request = http.MultipartRequest('POST', uri)
      ..fields['user_id'] = userID.toString()
      ..fields['name'] = userName
      ..fields['email'] = email
      ..fields['password'] = password
      ..fields['cpassword'] = cPassword
      ..fields['gender'] = gendar.toString()
      ..fields['token'] = userToken
      ..files.add(multipartFile);
    /*..files.add(await http.MultipartFile.fromPath(
          'package', 'build/package.tar.gz',
         // contentType: MediaType('application', 'x-tar')
      ));*/

    //    request.files.add(multipartFile);
    var response = await request.send();
    print(response);
    if (response.statusCode == 200) print('Uploaded!');
  }

  upload(File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse(APIConstants.API_BASE_URL + 'personal-details');
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    // multipart that takes file
    var multipartFile = new http.MultipartFile('profile_img', stream, length,
        filename: 'abc' //basename(imageFile.path)
        );

    request.fields['user_id'] = userID.toString();
    request.fields['name'] = userName;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['cpassword'] = cPassword;
    request.fields['gender'] = gendar.toString();
    request.fields['token'] = userToken;

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
        userID = dataResponse['user_id'];
        userToken = dataResponse['token'];
        setState(() {
          SaveString("user_id", userID.toString());
          SaveString("token", userToken);
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StepPageIndicatorDemo()),//StepPageIndicatorDemo//AudioScanner
        );
      } else {
        print("fail");
        print(message);
        Constants.showToast(message);
      }
    });
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


  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
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

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: GestureDetector(
                              onTap: () => imagePicker.showDialog(context),
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.0),
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
                                                        new Container(
                                                            width: 110.0,
                                                            height: 110.0,
                                                            decoration:
                                                                new BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image:
                                                                  new DecorationImage(
                                                                image: new ExactAssetImage('assets/images/profile_pic.jpg'),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 65.0,
                                                                left: 85.0),
                                                        child: new Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            new CircleAvatar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFf18a01),
                                                              radius: 20.0,
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
                                          height: 110.0,
                                          width: 110.0,
                                          decoration: new BoxDecoration(
                                            color: const Color(0xff7c94b6),
                                            image: new DecorationImage(
                                              image: new ExactAssetImage(
                                                  _image.path),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                                color: Colors.red, width: 5.0),
                                            borderRadius: new BorderRadius.all(
                                                const Radius.circular(80.0)),
                                          ),
                                        ),
                                ),
                              ),
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
                          /* Card(
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
                          ),*/
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
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please Enter Password";
                                }
                              },
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

                          Card(
                            elevation: 6.0,
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Please Enter Confirm Password";
                                }
                              },
                              obscureText: _secureText,
                              onSaved: (e) => cPassword = e,
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
                                  labelText: "Confirm Password"),
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
                                SizedBox(
                                  width: 20,
                                ),
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
                                  side: BorderSide(color: Color(0xFFf18a01))),
                              onPressed: () {
                                //  print("Upload Profile Picture!");
                                _image == null
                                    ? Constants.showToast(
                                        "Upload Profile Picture!") //print("Upload Profile Picture!")//registerToast("Upload Profile Picture!")
                                    : check();
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
      _buildGenderSelect(gender: "M", selected: _isMale),
      _buildGenderSelect(gender: "F", selected: !_isMale),
    ]);
  }

  upload1(File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(APIConstants.API_BASE_URL + 'personal-details');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: 'abc' //basename(imageFile.path)
        );

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  uploadFile(File imageFile) async {
    var postUri = Uri.parse("<APIUrl>");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
    /*request.files.add(new http.MultipartFile.fromBytes('file',
        await File.fromUri("<path/to/file").readAsBytes(),
        contentType: new MediaType('image', 'jpeg')))*/

    // multipart that takes file
    //  var multipartFile = new http.MultipartFile('file', stream, length,
    //    filename: basename(imageFile.path));

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var length = await imageFile.length();

    request.files
        .add(new http.MultipartFile('file', stream, length, filename: 'abc'));

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  ///pick crop image
  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
