import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyComments extends StatefulWidget {
  @override
  _MyCommentsState createState() => _MyCommentsState();
}
class _MyCommentsState extends State<MyComments> {
  ProgressDialog pr;
  var myComments;
  bool isLoading  = false;
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
    getMyComments();
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
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  getMyComments() async {
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getString("user_id") ?? 0;
    var sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
    });
    var response = await createPost(APIConstants.API_BASE_URL+ 'my-comment',
        body: request);
    myComments = json.decode(response.body);
    print('response $myComments');
    var sStatus = myComments['status'];
    String message = myComments['message'];//dataResponse['data']['f_name'];
    if (sStatus == true) {
      setState(() {
        isLoading  = true;
      });
    } else {
     // setState(() {
        Navigator.pop(context);
        //isLoading  = true;
     // });
      Constants.showToast(message);
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
          "My Comments",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: isLoading ? Column(
        children: <Widget>[
          Expanded(
            // height: 310,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: myComments['data'].length,
              itemBuilder: (BuildContext context, int index) {
                Map myCommentsList = myComments['data'][index];
                return Padding(
                  padding: EdgeInsets.all(10),//only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return DishDetails(sToken, userID,restaurantsId,menuList['category_id'],menuList['id']);
                          },
                        ),
                      );*/
                    },
                    child: Container(
                     // height: 50,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              myCommentsList['image'],height: 90,
                              width: 90,fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 10),
                         SizedBox(
                          // width: 200,
                           child:  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                           //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Text(
                                 myCommentsList['title'],
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18,
                                     color: Colors.black),
                               ),
                               Text(
                                 myCommentsList['comment'],
                                 maxLines: 2,
                                 style: TextStyle(
                                   // fontWeight: FontWeight.bold,
                                     fontSize: 14,
                                     color: Colors.grey),
                               ),
                              SizedBox(
                                width: 220,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.adjust,
                                          color: myCommentsList['menu_type']==1?Colors.green:Colors.red.shade800,
                                          size: 20,),
                                        Text(
                                          myCommentsList['menu_type']==1?"Vag":"Non Vag",
                                          // if(furniture['menu_type']){""}else{""},
                                          //'You have pushed the button $_counter time${_counter != 1 ? 's' : ''}:',
                                          maxLines: 1,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: myCommentsList['menu_type']==1?Colors.green:Colors.red.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //SizedBox(width: 20),
                                    FlutterRatingBar(
                                      initialRating: 3,
                                      //minRating: 1,
                                      //direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      borderColor: Color(0xFFf18a01),
                                      fillColor: Color(0xFFf18a01),
                                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                      //itemBuilder: (context, _) => Icon(Icons.star,color: Colors.amber,),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              )
                             ],
                           ),
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
      ):
      ColorLoader3()
    );
  }
}
