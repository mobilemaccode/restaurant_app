import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/PaymentPage.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutPage extends StatefulWidget {
  var orderDetails, eatType;
  CheckOutPage(this.orderDetails, this.eatType);

  @override
  _CheckOutPageState createState() => _CheckOutPageState(orderDetails, eatType);
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  // var orderType = false;
  bool orderType = true;
  var orderDetails;
  ProgressDialog pr;
  bool isLoading = false;
  var sToken, userID, restaurantsId, msg, eatType;
  TextEditingController remarkController = new TextEditingController();

  _CheckOutPageState(this.orderDetails, this.eatType);

  void initState() {
    super.initState();
    print('orderDetails $orderDetails');
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

  processToPay() async {
    pr.show();
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    restaurantsId = prefs.getString("restaurant") ?? 0;
    print('restaurantsId $restaurantsId');
    if (restaurantsId != null && restaurantsId != 0) {
      var request = json.encode({
        "user_id": userID,
        "token": sToken,
        "restaurant_id": restaurantsId,
        "order_type": orderType ? "2" : "1",
        "remarks": remarkController.text,
        "actual_price": orderDetails['total'].toString(),
        "final_price": orderDetails['sub_total'].toString(),
        "tax": orderDetails['tax'].toString(),
        "order_id": "",
      });
      var response =
          await createPost(APIConstants.API_BASE_URL + 'order', body: request);
      var order = json.decode(response.body);
      print('REST response $order');
      var sStatus = order['status'];
      String message = order['message']; //dataResponse['data']['f_name'];
      if (sStatus == true) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => PaymentPage(orderDetails)));
      } else {
        Constants.showToast(message);
      }
    } else {
      setState(() {
        Constants.showToast("Cart is Empty!");
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
            "Your Order",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  // margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 10,bottom: 10),
                  child: ListView(
                    children: <Widget>[
                      // SizedBox(height: 10,),
                      /* Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            // width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: RaisedButton(
                              onPressed: () {

                                setState(() {
                                  orderType = false;
                                  print(orderType);
                                });
                                // showThankYouBottomSheet(context);
                              },
                              color: Colors.grey,
                              // padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                              child: Text(
                                "Eat-in",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            // width: double.infinity,
                            // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  orderType = true;
                                  print(orderType);
                                });
                                //showThankYouBottomSheet(context);
                              },
                              color: Color(0xFFf18a01),
                              // padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                              child: Text(
                                "Takeaway",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Add remarks",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12,right: 12),
                        child: TextField(
                          controller: remarkController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                        ),
                      ),*/
                      checkoutItem(),
                      priceSection(),
                      Visibility(
                          visible: orderType,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentPage(orderDetails)));
                              },
                              color: Color(0xFFf18a01),
                              padding: EdgeInsets.only(
                                  top: 12, left: 60, right: 60, bottom: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24))),
                              child: Text(
                                "Proceed To Pay",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                flex: 90,
              ),
              /*Visibility(
                visible: orderType,
                child: Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child:
                  ),
                  //flex: 10,
                ),
              ),*/
            ],
          );
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

  checkoutItem() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
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
      ),
    );
  }

  checkoutListItem(int index) {
    Map cartList = orderDetails['menu'][index];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
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
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  priceSection() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
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
                  "\$" +
                      orderDetails['total']
                          .toString(), //getFormattedCurrency(5197),
                  Colors.black),
              createPriceItem(
                  "Tax",
                  orderDetails['tax'].toString(), //getFormattedCurrency(96),
                  Colors.grey.shade700),
              createPriceItem(
                  "Service Charge",
                  orderDetails['service_charge']
                      .toString(), //getFormattedCurrency(2013),
                  Colors.grey.shade700),
              /*Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),*/
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Sub Total",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "\$" + orderDetails['sub_total'].toString(),
                    //getFormattedCurrency(2013),
                    style: CustomTextStyle.textFormFieldMedium
                        .copyWith(color: Colors.black, fontSize: 16),
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
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Promo Code",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Select",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),*/
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Address",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Change",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(color: Color(0xFFf18a01), fontSize: 16),
                  ),
                ],
              ),*/
              SizedBox(
                height: 6,
              ),
              Text(
                "closed this bug since this appears to dfsd dsdfsd already be possible, but please",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*String getFormattedCurrency(double amount) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(amount: amount);
    fmf.symbol = "\$";
    fmf.thousandSeparator = ",";
    fmf.decimalSeparator = ".";
    fmf.spaceBetweenSymbolAndNumber = true;
    return fmf.formattedLeftSymbol;
  }*/

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
