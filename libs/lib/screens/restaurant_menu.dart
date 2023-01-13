import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/DishDetails.dart';
import 'package:restaurant_app/util/const.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantMenu extends StatefulWidget {
  var sToken, userID,restaurantsId;
  RestaurantMenu(this.sToken, this.userID,this.restaurantsId);

  @override
  _RestaurantMenuState createState() => _RestaurantMenuState(sToken, userID,restaurantsId);
}

class _RestaurantMenuState extends State<RestaurantMenu>
    with TickerProviderStateMixin {
  var sToken, userID,restaurantsId;
  _RestaurantMenuState(this.sToken, this.userID, this.restaurantsId);
  ProgressDialog pr;
  List catNameList;
  bool isLoading  = false;
  List<String> catNameList2 = ['Page 0', 'Page 1', 'Page 2', 'Page 2'];
  int initPosition = 0;
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
    getRestaurantsMenu();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<http.Response> createPost(String url, {Object body}) async {
    return http.post(url, headers: {"Content-Type": "application/json"}, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return (response);
    });
  }

  getRestaurantsMenu() async {
    final prefs = await SharedPreferences.getInstance();
   var userID = prefs.getString("user_id") ?? 0;
    var sToken = prefs.getString("token") ?? 0;
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "restaurant_id": restaurantsId,
    });
    print('REST request $request');
    var response = await createPost(APIConstants.API_BASE_URL+ 'get-menu-catagory',
        body: request);
    var objectRes = json.decode(response.body);
    print('REST response $objectRes');
    var sStatus = objectRes['status'];
    String message = objectRes['message'];//dataResponse['data']['f_name'];
    catNameList = objectRes['data'];
    catNameList2.clear();
    if (sStatus == true) {
      setState(() {
        isLoading  = true;
        for(int i = 0; catNameList.length>i;i++){
         catNameList2.add(catNameList[i]['cat_name']);
        }
        catNameList = objectRes['data'];
      });
    } else {
      setState(() {
        isLoading  = true;
    });
      Constants.showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, false);
            }),
        title: Text(
          "Menu",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: new Container(
          child: isLoading ? CustomTabView(
            initPosition: initPosition,
            itemCount: catNameList2.length,
            tabBuilder: (context, index1) => Tab(text: catNameList2[index1]),
            pageBuilder: (context, index1) =>  Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: catNameList[index1]['menu'].length,
                itemBuilder: (BuildContext context, int index) {
                  Map menuList = catNameList[index1]['menu'][index] ;
                  return Padding(
                    padding: EdgeInsets.all(6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context){
                              return DishDetails(sToken, userID,restaurantsId,menuList['category_id'],menuList['menu_id']);
                            },
                          ),
                        );
                        /*var rID = furniture['id'];
                        print('sToken: $sToken');
                        print('userID: $userID');
                        print('rID: $rID');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context){
                              return RestaurantMenu(sToken,userID , rID);
                            },
                          ),
                        );*/
                      },
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                        SizedBox(
                          height: 90,
                          width: 90,
                          child: Stack(
                            children: <Widget>[
                              Center(child: CircularProgressIndicator()),
                              Center(
                                child:ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: menuList['image'],height: 90,width: 90,fit: BoxFit.cover,
                                  ),
                                  /*CachedNetworkImage(
                                    imageUrl: menuList['image'],
                                    placeholder: (context, url) => new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ),*/
                                  /*FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: menuList['image'],
                                ),*/
                              ),
                              ),
                            ],
                          ),
                        ),
                            /*ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                imageUrl: menuList['image'],
                                placeholder: (context, url) => new CircularProgressIndicator(),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                              ),*/
                              /*Image.network(
                                menuList['image'],height: 90,
                                width: 90,fit: BoxFit.cover,),*/
                            //),
                            SizedBox(width: 10),
                            Flexible(
                              //width: 200,
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    menuList['menu_name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),

                                  Text(
                                    menuList['description'],
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          menuList['menu_type']==1?"Veg":"Non Veg",
                                          // if(furniture['menu_type']){""}else{""},
                                          //'You have pushed the button $_counter time${_counter != 1 ? 's' : ''}:',
                                          maxLines: 1,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: menuList['menu_type']==1?Colors.green:Colors.red.shade800,),
                                        ),
                                        Text(
                                          "\$"+menuList['half_price'].toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.orange.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
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
            onPositionChange: (index){
              print('current position: $index');
              initPosition = index;
            },
            onScroll: (position) => print('$position'),
          ) :
          Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.orange[200],
                  borderRadius: new BorderRadius.circular(10.0)
              ),
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
                        style: new TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
  }
////////////////////////////////////////


//////////////////////////////////////////////////////////////
/// Implementation

class CustomTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Widget stub;
  final ValueChanged<int> onPositionChange;
  final ValueChanged<double> onScroll;
  final int initPosition;

  CustomTabView({
    @required this.itemCount,
    @required this.tabBuilder,
    @required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView> with TickerProviderStateMixin {
  TabController controller;
  int _currentCount;
  int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? 0;
    controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 :
        _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            if(mounted) {
              widget.onPositionChange(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: controller,
            labelColor: Colors.orange,//Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.orange,//Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount,
                  (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              widget.itemCount,
                  (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange(_currentPosition);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll(controller.animation.value);
    }
  }
}