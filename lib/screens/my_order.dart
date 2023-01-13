import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/details.dart';
import 'package:restaurant_app/screens/search_list.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/data.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
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
      body: ListView(
        padding: EdgeInsets.only(left: 20),
        children: <Widget>[

          SizedBox(
            height: 15,
          ),

          Container(
            // height: 310,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: furnitures.length,
              itemBuilder: (BuildContext context, int index) {
                Map furniture = furnitures[index];
                return Padding(
                  padding: EdgeInsets.only(right: 20,left: 20,top: 30,bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            //return Details();
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
                                 furniture['name'],
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18,
                                     color: Colors.black),
                               ),
                               Text(
                                 furniture['name']+" This example",
                                 maxLines: 2,
                                 style: TextStyle(
                                   // fontWeight: FontWeight.bold,
                                     fontSize: 14,
                                     color: Colors.grey),
                               ),
                               Text(
                                 "\$299.00",
                                 style: CustomTextStyle.textFormFieldBlack
                                     .copyWith(color: Color(0xFFf18a01)),
                               ),

                               SizedBox(height: 10,),

                               Text(
                                 "Vage Pan Fried Momos(10 pic)",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 16,
                                     color: Colors.grey.shade600),
                               ),
                               Text(
                                 furniture['name']+" This example",
                                 maxLines: 2,
                                 style: TextStyle(
                                   // fontWeight: FontWeight.bold,
                                     fontSize: 14,
                                     color: Colors.grey),
                               ),

                               RaisedButton(
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
                               ),
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
      ),
    );
  }
}
