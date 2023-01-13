import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/screens/DishDetails.dart';
import 'package:restaurant_app/screens/OrderDetails.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/data.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/DishDetails.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  ProgressDialog pr;
  bool isLoading  = false;
  var orderList,msg;
  var sStatus = false;

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
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)
    );
    getOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    print('url $url');
    print('body $body');
    return http.post(url, headers: {"Content-Type": "application/json"}, body: body).then((http.Response response) {
      print(response.body.toString());
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getString("user_id") ?? 0;
    var sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      // "restaurant_id": restaurantsId,
    });
    var response = await createPost(APIConstants.API_BASE_URL+ 'get-my-order',
        body: request);
    var objectRes = json.decode(response.body);
    print('favourite response $objectRes');
    sStatus = objectRes['status'];
     msg = objectRes['message'];//dataResponse['data']['f_name'];
    if (sStatus == true) {
      orderList = objectRes['data'];
      setState(() {
        isLoading  = true;
      });
    } else {
      setState(() {
        isLoading  = true;
      });
      Constants.showToast(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "My Order",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: isLoading?

      sStatus ? Column(
       // padding: EdgeInsets.only(left: 20),
        children: <Widget>[
          Expanded(
            // height: 310,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: orderList.length,
              itemBuilder: (BuildContext context, int index) {
                Map orderListMap = orderList[index];
                return Padding(
                  padding: EdgeInsets.only(right: 20,left: 20,top: 30,bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      print(orderListMap["order_number"]);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return OrderDetails(orderListMap["order_number"]);
                          },
                        ),
                      );
                    },
                    child: Container(
                      // height: 50,
                      width: double.infinity,
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // SizedBox(width: 10),
                          SizedBox(
                            // width: 200,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  orderListMap['order_number'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                Text(
                                  orderListMap['restaurant_name'],
                                  maxLines: 2,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "\$"+orderListMap['final_price'].toString(),
                                  style: CustomTextStyle.textFormFieldBlack
                                      .copyWith(color: Color(0xFFf18a01)),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  orderListMap['time'],
                                  maxLines: 1,
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                /*RaisedButton(
                                  onPressed: () {
                                    //Navigator.push(context,new MaterialPageRoute(builder: (context) => CheckOutPage()));
                                  },
                                  color: Color(0xFFf18a01),
                                  //padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(24))),
                                  child: Text(
                                    "Reorder",
                                    style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.white),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.grey.shade700,
                          ),
                          //  middleSection,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ): Center(child: Text(msg,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))

      : ColorLoader3()
    );
  }
}
