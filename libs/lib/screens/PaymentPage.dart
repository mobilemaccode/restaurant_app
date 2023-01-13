import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  var cartDetails;
  PaymentPage(this.cartDetails);

  @override
  _PaymentPageState createState() => _PaymentPageState(cartDetails);
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  var cartDetails;
  _PaymentPageState(this.cartDetails);
  ProgressDialog pr;
  bool isLoading = true;
  var sToken, userID, msg;

  void initState() {
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
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    print('url $url');
    print('body $body');
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

  paymentBy(BuildContext context) async {
    /*pr = new ProgressDialog(context);
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
    pr.show();*/
    setState(() {
      isLoading = false;
    });

    print("dasd");
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    print('userID $userID');
    print('sToken $sToken');

    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "payment_type": "1",
    });

    print('request $request');

    var response = await createPost(APIConstants.API_BASE_URL + 'payment-type',
        body: request);
    cartDetails = json.decode(response.body);

    print('cartDetails $cartDetails');

    setState(() {
      isLoading = true;
    });

    /* pr.hide().then((isHidden) {
      // print(isHidden);
    });*/
    cartDetails = json.decode(response.body);
    print('cartDetails $cartDetails');
    var sStatus = cartDetails['status'];
    String message = cartDetails['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      showThankYouBottomSheet(context);
    } else {
      Constants.showToast(message);
    }
  }

  SaveString(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: isLoading
          ? ListView(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 50),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: new Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                        ),
                        highlightColor: Colors.orange,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      "Select Type",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "\$" + cartDetails['sub_total'].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.orange.shade600,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Preferred Payment",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: RaisedButton(
                    onPressed: () {
                      paymentBy(context);
                    },
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Text(
                      "Cash",
                      style: CustomTextStyle.textFormFieldSemiBold
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  margin: EdgeInsets.only(left: 12, top: 4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Credit/Debit Card",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.orange.shade600,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Save and Pay via cards.",
                  style: TextStyle(
                    fontSize: 12,
                    // color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : Container(
              alignment: AlignmentDirectional.center,
              decoration: new BoxDecoration(
                color: Colors.white70,
              ),
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: new BorderRadius.circular(10.0)),
                width: 300.0,
                height: 200.0,
                alignment: AlignmentDirectional.center,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 7.0,
                        ),
                      ),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: new Center(
                        child: new Text(
                          "loading.. wait...",
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/images/ic_thank_you.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "\n\nOrder Successfuly Submit.",
                            style: CustomTextStyle.textFormFieldMedium.copyWith(
                                fontSize: 25,
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      onPressed: () {
                        SaveString("order_id", "");
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeIndex()),
                            ModalRoute.withName("/HomeIndex"));
                        /* Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => HomeIndex()));*/
                      },
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Done",
                        style: CustomTextStyle.textFormFieldMedium
                            .copyWith(color: Colors.white),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }
}
