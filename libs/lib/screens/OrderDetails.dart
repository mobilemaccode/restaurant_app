import 'package:flutter/material.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  var orderId;

  OrderDetails(this.orderId);

  @override
  _OrderDetailsState createState() => _OrderDetailsState(orderId);
}

class _OrderDetailsState extends State<OrderDetails> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  // var orderType = false;
  bool orderType = true;
  var orderDetails;
  ProgressDialog pr;
  bool isLoading = false;
  var sToken, userID, restaurantsId, msg, orderId;
  TextEditingController remarkController = new TextEditingController();

  _OrderDetailsState(this.orderId);

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
    getOrderDetails();
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

  getOrderDetails() async {
    // pr.show();
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    restaurantsId = prefs.getString("restaurant") ?? 0;

    print('userID $userID');
    print('sToken $sToken');
    print('restaurantsId $restaurantsId');

    if (restaurantsId != null && restaurantsId != 0) {
      var request = json.encode({
        "user_id": userID,
        "token": sToken,
        "order_id": orderId.toString(),
      });
      var response = await createPost(
          APIConstants.API_BASE_URL + 'get-order-details',
          body: request);
      orderDetails = json.decode(response.body);

      print('response $orderDetails');
      var sStatus = orderDetails['status'];
      print('sStatus $sStatus');
      String message =
          orderDetails['message']; //dataResponse['data']['f_name'];
      if (sStatus == true) {
        setState(() {
          isLoading = true;
        });
        // Navigator.push(context, new MaterialPageRoute(builder: (context) => PaymentPage(orderDetails)));
      } else {
        Constants.showToast(message);
        Navigator.pop(context);
      }
    } else {
      setState(() {
        //isLoading  = true;
        Constants.showToast("Cart is Empty!");
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
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
          title: Text(
            "Order Details",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Builder(builder: (context) {
          return isLoading
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10, bottom: 10),
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Order Id: ' +
                                  orderDetails['order_id'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            Text(
                              'Restaurant Name: ' +
                                  orderDetails['restaurant_name'],
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: ListView.builder(
                                itemCount: orderDetails['menu'].length,
                                itemBuilder: (context, position) {
                                  return checkoutListItem(position);
                                },
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 1.5,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                createPriceItem(
                                    "Total",
                                    "\$" + orderDetails['total'].toString(),
                                    Colors.black),
                                createPriceItem(
                                    "Tax",
                                    orderDetails['tax'].toString(),
                                    Colors.grey.shade700),
                                createPriceItem(
                                    "Service Charge",
                                    orderDetails['service_charge'].toString(),
                                    Colors.grey.shade700),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 1.5,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Sub Total",
                                      style: CustomTextStyle
                                          .textFormFieldSemiBold
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 16),
                                    ),
                                    Text(
                                      "\$" +
                                          orderDetails['sub_total'].toString(),
                                      //getFormattedCurrency(2013),
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                              color: Color(0xFFf18a01),
                                              fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 1.5,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      flex: 90,
                    ),
                  ],
                )
              : ColorLoader3();
        }),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium
            .copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  checkoutListItem(int index) {
    Map cartList = orderDetails['menu'][index];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cartList['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      cartList['quantity'].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                    Text(
                      cartList['price'].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "\$" + cartList['total_price'].toString(),
            //getFormattedCurrency(5197),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
