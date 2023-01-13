import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/data.dart';
import 'package:flutter/foundation.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  // var orderType = false;
  bool orderType = true;

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
                      Padding(
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
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24))),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24))),
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
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                        ),
                      ),
                      checkoutItem(),
                      priceSection(),
                      Visibility(
                          visible: orderType,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: RaisedButton(
                              onPressed: () {
                                /*Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => OrderPlacePage()));*/
                                ///showThankYouBottomSheet(context);
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
                    image: AssetImage("images/ic_thank_you.png"),
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
                            text:
                                "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: CustomTextStyle.textFormFieldMedium.copyWith(
                                fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Track Order",
                        style: CustomTextStyle.textFormFieldMedium
                            .copyWith(color: Colors.white),
                      ),
                      color: Color(0xFFf18a01),
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
            itemCount: furnitures.length,
            itemBuilder: (context, position) {
              return checkoutListItem(position);
            },
            //itemCount: 3,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem(int index) {
    Map furniture = furnitures[index];
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
                  furniture['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54),
                ),
                Text(
                  "3*344.5",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey),
                ),
              ],
            ),
            /*child: Image(
              image: AssetImage(
                "images/details_shoes_image.webp",
              ),
              width: 35,
              height: 45,
              fit: BoxFit.fitHeight,
            ),*/
            //decoration:BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.remove,
                  size: 24,
                  color: Colors.grey.shade700,
                ),
                Container(
                  // color: Color(0xFFf18a01),
                  padding:
                      const EdgeInsets.only(bottom: 2, right: 12, left: 12),
                  child: Text(
                    "3",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFf18a01),
                        fontSize: 18),
                    // style: CustomTextStyle.textFormFieldSemiBold,
                  ),
                ),
                Icon(
                  Icons.add,
                  size: 24,
                  color: Colors.grey.shade700,
                )
              ],
            ),
          ),
          Text(
            getFormattedCurrency(5197),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          /*RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Estimated Delivery : ",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(fontSize: 12)),
              TextSpan(
                  text: "21 Jul 2019 ",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600))
            ]),
          )*/
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
                  "Total", getFormattedCurrency(5197), Colors.black),
              createPriceItem(
                  "Tax", getFormattedCurrency(96), Colors.grey.shade700),
              createPriceItem("Service Charge", getFormattedCurrency(2013),
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
                    getFormattedCurrency(2013),
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
              Row(
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
              ),
              Row(
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
              ),
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
    fmf.symbol = "₹";
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
