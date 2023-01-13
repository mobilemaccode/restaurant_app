import 'package:flutter/material.dart';
import 'package:restaurant_app/models/list_profile_section.dart';
import 'package:restaurant_app/screens/AboutUsPage.dart';
import 'package:restaurant_app/screens/account_setting.dart';
import 'package:restaurant_app/screens/favorites_dish.dart';
import 'package:restaurant_app/screens/my_comments.dart';
import 'package:restaurant_app/screens/my_order.dart';
import 'package:restaurant_app/screens/preferances.dart';
import 'package:restaurant_app/screens/profile_edit.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/CustomUtils.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccountScreenState createState() => new _AccountScreenState();
}

//class _AccountScreenState extends State<AccountScreen>
class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  List<ListProfileSection> listSection = new List();

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createListItem();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      margin: const EdgeInsets.all(15.0),
      color: Colors.white,
      child: new ListView(
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
                          //fontFamily: 'sans-serif-light',
                          color: Colors.black)),

                  Text(
                    "Logout",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(fontSize: 20, color: Color(0xFFf18a01)),
                  ),
                ],
              ),



              //buildListView()
              Stack(
                children: <Widget>[
                  Container(
                    //margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 110.0,
                                    height: 110.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/images/profile_pic.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 65.0, left: 85.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: Color(0xFFf18a01),
                                      radius: 20.0,
                                      child: new Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Nancy Doe",
                                          maxLines: 2,
                                          softWrap: true,
                                          style: CustomTextStyle.textFormFieldSemiBold
                                              .copyWith(fontSize: 18),
                                        ),

                                        Row(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: new GestureDetector(
                                                          onTap: () {
                                                            //Navigator.pushNamed(context, "myRoute");
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => ProfileEdit()),
                                                            );
                                                          },
                                                          child: new Text("Edit", style: TextStyle(fontSize: 16,color: Color(0xFFf18a01)),),
                                                        )/*Text(
                      "Edit  ",
                      style: CustomTextStyle.textFormFieldRegular.copyWith(
                          color: Color(0xFFf18a01), fontSize: 14),
                    ),*/
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    /*Container(
                                      padding: EdgeInsets.only(right: 8, top: 4),
                                      child:
                                    ),*/
                                    Utils.getSizedBox(height: 6),
                                    Text(
                                      "9876543210",
                                      style: CustomTextStyle.textFormFieldRegular
                                          .copyWith(
                                              color: Colors.grey, fontSize: 14),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "user@gmail.com",
                                            style: CustomTextStyle
                                                .textFormFieldRegular
                                                .copyWith(color: Colors.grey),
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

                ],
              ),
              SizedBox(
                height: 50,
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSetting()),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 8, top: 4),
                              child: Text(
                                "My Account",
                                maxLines: 2,
                                softWrap: true,
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                            Utils.getSizedBox(height: 6),
                            Text(
                              "Address, Payment, App Setting",
                              style: CustomTextStyle.textFormFieldRegular
                                  .copyWith(color: Colors.grey, fontSize: 16),
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
                    MaterialPageRoute(builder: (context) => MyOrder()),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 8, top: 4),
                              child: Text(
                                "My Order",
                                maxLines: 2,
                                softWrap: true,
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                            Utils.getSizedBox(height: 6),
                            Text(
                              "Address, Payment, App Setting",
                              style: CustomTextStyle.textFormFieldRegular
                                  .copyWith(color: Colors.grey, fontSize: 16),
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
                MaterialPageRoute(builder: (context) => FavoritesDish()),
              );
            },
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            "Fovorite Dish",
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        Utils.getSizedBox(height: 6),
                        Text(
                          "Address, Payment, App Setting",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.grey, fontSize: 16),
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
                MaterialPageRoute(builder: (context) => Preferences()),
              );
            },
            child:   Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            "Preferences",
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        Utils.getSizedBox(height: 6),
                        Text(
                          "Dite, Sugar, Salt",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.grey, fontSize: 16),
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

              SizedBox(
                height: 15,
              ),


          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyComments()),
              );
            },
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            "My Comments",
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        Utils.getSizedBox(height: 6),
                        Text(
                          "45 comment posted ",
                          style: CustomTextStyle.textFormFieldRegular
                              .copyWith(color: Colors.grey, fontSize: 16),
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
      ),
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
    listSection.add(createSection(
        "Logout", "images/ic_logout.png", Color(0xFFf18a01).withOpacity(0.7), null));
  }
}

/*class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin,ImagePickerListener{

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title,
          style: new TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: new GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: new Center(
          child: _image == null
              ? new Stack(
            children: <Widget>[

              new Center(
                child: new CircleAvatar(
                  radius: 80.0,
                  backgroundColor: const Color(0xFF778899),
                ),
              ),
              new Center(
                child: new Image.asset("assets/photo_camera.png"),
              ),

            ],
          )
              : new Container(
            height: 160.0,
            width: 160.0,
            decoration: new BoxDecoration(
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                image: new ExactAssetImage(_image.path),
                fit: BoxFit.cover,
              ),
              border:
              Border.all(color: Colors.red, width: 5.0),
              borderRadius:
              new BorderRadius.all(const Radius.circular(80.0)),
            ),
          ),
        ),
      ),

    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }

}*/

/*class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.build(0xFFEE6969,0xFFFFFFFF,false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title,
          style: new TextStyle(color: Colors.white),
        ),
      ),
      body: new GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: new Center(
          child: _image == null
              ? new Stack(
            children: <Widget>[
              new Center(
                child: new CircleAvatar(
                  radius: 80.0,
                  backgroundColor: const Color(0xFF778899),
                ),
              ),
              new Center(
                child: new Image.asset("assets/photo_camera.png"),
              ),
            ],
          )
              : new Container(
            height: 160.0,
            width: 160.0,
            decoration: new BoxDecoration(
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                image: new ExactAssetImage(_image.path),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.red, width: 5.0),
              borderRadius:
              new BorderRadius.all(const Radius.circular(80.0)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}*/

/*
class _AccountScreenState extends State<AccountScreen> {
  //final ImagePicker _imagePicker = ImagePickerChannel();

  File _imageFile;

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return Image.file(_imageFile);
    } else {
      return Text('Take an image to start', style: TextStyle(fontSize: 18.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      */
/*appBar: AppBar(
        title: Text(widget.title),
      ),*/ /*

      body: Column(
        children: [
          Expanded(child: Center(child: _buildImage())),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(
                key: Key('retake'),
                text: 'Photos',
                onPressed: () => captureImage(ImageSource.gallery),
              ),
              _buildActionButton(
                key: Key('upload'),
                text: 'Camera',
                onPressed: () => captureImage(ImageSource.camera),
              ),
            ]));
  }

  Widget _buildActionButton({Key key, String text, Function onPressed}) {
    return Expanded(
      child: FlatButton(
          key: key,
          child: Text(text, style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }
}*/
