import 'package:flutter/material.dart';
import 'package:restaurant_app/models/list_profile_section.dart';
import 'package:restaurant_app/screens/AboutUsPage.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfileEditState createState() => new _ProfileEditState();
}

//class _AccountScreenState extends State<AccountScreen>
class _ProfileEditState extends State<ProfileEdit>
    with SingleTickerProviderStateMixin {
  List<ListProfileSection> listSection = new List();
  var _isMale = true;
  String password;

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "Nancy Doe",
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  SizedBox(height: 40,),
                  Text(
                      "user@gmail.com",
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  SizedBox(height: 40,),
                  Text(
                      "9876543210",
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      )
                  ),

                  SizedBox(height: 20,),
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

                  RaisedButton(
                    onPressed: () {
                      //Navigator.push(context,new MaterialPageRoute(builder: (context) => CheckOutPage()));
                    },
                    color: Color(0xFFf18a01),
                    padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Text(
                      "Save",
                      style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 60,),

                  /*Card(
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
                          labelText: "Change Password"),
                    ),
                  ),*/

                   Text(
                      "Change Password",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      )
                  ),
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your register email address'
          ),
        ),
/*TextFormField(
          decoration: InputDecoration(
              labelText: 'Enter your username'
          ),
        ),*/
                  Padding(padding: EdgeInsets.all(15),
                    child: Text(
                        "user@gmail.com",
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),

                  RaisedButton(
                    onPressed: () {
                      //Navigator.push(context,new MaterialPageRoute(builder: (context) => CheckOutPage()));
                    },
                    color: Color(0xFFf18a01),
                    padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Text(
                      "Submit",
                      style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.white),
                    ),
                  ),

                ],
              ),
            ),
          ],
        )
    );
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
        text: gender, textColor: Color(0xFFf18a01), background: Colors.white)
        : _buildSelect(
        text: gender,textColor: Colors.white, background: Color(0xFFf18a01));

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
/////////////////
