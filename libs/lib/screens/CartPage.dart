import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:restaurant_app/progress/ColorLoader3.dart';
import 'package:restaurant_app/screens/home_index.dart';
import 'package:restaurant_app/util/CustomTextStyle.dart';
import 'package:restaurant_app/util/CustomUtils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'CheckOutPage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:restaurant_app/util/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'dart:async';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  SlidableController slidableController;
  // final List<_HomeItem> items;

  ProgressDialog pr;
  bool isLoading = false;
  var sToken,
      userID,
      restaurantsId,
      msg,
      cartDetails,
      eatType,
      sRemark,
      orderDetails,
      orderId;
  TextEditingController remarkController = new TextEditingController();
  var sStatus = false;
  int number = 0;
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );

    super.initState();
    orderId = "";
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
    getCart(false);
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
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

  getCart(var status) async {
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("user_id") ?? 0;
    sToken = prefs.getString("token") ?? 0;
    restaurantsId = prefs.getString("restaurant") ?? 0;
    orderId = prefs.getString("order_id") ?? "";
    //if(restaurantsId != null && restaurantsId != 0){
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "restaurant_id": restaurantsId,
    });
    var response =
        await createPost(APIConstants.API_BASE_URL + 'get-cart', body: request);
    cartDetails = json.decode(response.body);
    print('response $cartDetails');

    sStatus = cartDetails['status'];
    msg = cartDetails['message']; //dataResponse['data']['f_name'];
    if (sStatus == true) {
      setState(() {
        isLoading = true;
        if (status) {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckOutPage(cartDetails, eatType)),
          );
        } else {
          // items =
        }
      });
      return cartDetails;
    } else {
      setState(() {
        isLoading = true;
      });
      //Constants.showToast(msg);
    }
    /*}else{
      setState(() {
        isLoading  = true;
        Constants.showToast("Cart is Empty!");
      });
    }*/
  }

  getOrder() async {
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
        "order_type": eatType,
        "remarks": remarkController.text,
        "actual_price": cartDetails['total'].toString(),
        "final_price": cartDetails['sub_total'].toString(),
        "tax": cartDetails['tax'].toString(),
        "order_id": orderId.toString(),
      });
      var response =
          await createPost(APIConstants.API_BASE_URL + 'order', body: request);
      orderDetails = json.decode(response.body);
      pr.hide().then((isHidden) {});

      print('REST response $orderDetails');
      var sStatus = orderDetails['status'];
      String message =
          orderDetails['message']; //dataResponse['data']['f_name'];
      if (sStatus == true) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("order_id", orderDetails['order_id'].toString());
        // Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeIndex()),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckOutPage(orderDetails, eatType)),
        );
      } else {
        Constants.showToast(message);
      }
    } else {
      Constants.showToast("Cart is Empty!");
    }
  }

  addToCart(var price, var menuId, var quantity, var index) async {
    pr.show();
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "restaurant_id": restaurantsId,
      "menu_id": menuId,
      "price": price,
      "quantity": quantity,
      "type": "3",
    });
    var response = await createPost(APIConstants.API_BASE_URL + 'add-to-cart',
        body: request);
    pr.hide().then((isHidden) {});
    var objectRes = json.decode(response.body);
    print('objectRes $objectRes');
    var sStatus1 = objectRes['status'];
    String message = objectRes['message']; //dataResponse['data']['f_name'];
    if (sStatus1 == true) {
      setState(() {
        cartDetails['menu'][index]['quantity'] = quantity;
      });
    } else {
      setState(() {
        Constants.showToast(message);
      });
    }
  }

  deleteCartItem(var menuId, var index) async {
    //pr.show();
    var request = json.encode({
      "user_id": userID,
      "token": sToken,
      "menu_id": menuId,
    });
    var response = await createPost(APIConstants.API_BASE_URL + 'delete-cart',
        body: request);
    // pr.hide().then((isHidden) {});
    var objectRes = json.decode(response.body);
    var sStatus1 = objectRes['status'];
    String message = objectRes['message']; //dataResponse['data']['f_name'];
    Constants.showToast(message);

    if (sStatus1 == true) {
      if (cartDetails['menu'].length < 2) {
        msg = "Your card is Empty!!";
        sStatus = false;
        setState(() {
          cartDetails['menu'].removeAt(index);
        });
      } else {
        setState(() {
          cartDetails['menu'].removeAt(index);
        });
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: isLoading
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    child: createHeader(),
                  ),
                  // createSubTitle(),
                  Expanded(
                    child: createCartList(),
                    flex: 1,
                  ),
                  footer(context)
                ],
              )
            : ColorLoader3() /*Container(
              alignment: AlignmentDirectional.center,
              decoration: new BoxDecoration(
                color: Colors.white,
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
            )*/
        );
  }

  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Utils.getSizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                onPressed: () {
                  print(orderId.toString());
                  sStatus ? _asyncInputDialog(context) : getOrder();
                },
                color: Color(0xFFf18a01),
                padding:
                    EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Text(
                  sStatus ? "Confirm Order" : "My Order",
                  style: CustomTextStyle.textFormFieldSemiBold
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Utils.getSizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      //alignment: Alignment.topLeft,
      child: Center(
        child: Text(
          "My Cart",
          style: CustomTextStyle.textFormFieldBold
              .copyWith(fontSize: 20, color: Colors.black),
        ),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      /*child: Text(
        "Total(3) Items",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),*/
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList() {
    //return sStatus ? Center(child: Text('Data')): Center(child: Text('Empty')) ;
    return sStatus
        ? OrientationBuilder(
            builder: (context, orientation) => _buildList(
                context,
                orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal),
          )
        : Center(
            child: Text(
            msg,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ));
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      padding: EdgeInsets.zero,
      //itemCount: cartDetails['menu'].length,
      //    Map cartList = cartDetails['menu'][index];
      itemCount: cartDetails['menu'].length,
      itemBuilder: (BuildContext context, int index) {
//itemBuilder: (context, index) {
        final Axis slidableDirection =
            direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        if (index < cartDetails['menu'].length) {
          return _getSlidableWithLists(context, index, slidableDirection);
        } else {
          return _getSlidableWithDelegates(context, index, slidableDirection);
        }
      },
    );

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      itemCount: cartDetails['menu'].length,
      itemBuilder: (context, position) {
        return createCartListItem(position);
      },
    );
  }

  methodInParent(String searchValue) => getOrder();

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    var item = cartDetails['menu'][index];
    //final int t = index;
    return Slidable(
      key: Key(item['name']),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Delete Dish');
          /*setState(() {
            cartDetails['menu'].removeAt(index);
          });*/
          deleteCartItem(item['menu_id'], index);
        },
      ),
      actionPane: _getActionPane(index),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(cartDetails['menu'][index], index, userID, sToken,
              restaurantsId, context, this)
          : HorizontalListItem(cartDetails['menu'][index]),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              showAlertDialog(context, item['menu_id'], index);
              // _showSnackBar(context, 'Delete');
            }),
      ],
    );
  }

  showAlertDialog(BuildContext context, var menuId, var index) {
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () => Navigator.of(context).pop(false),
    );
    Widget continueButton = FlatButton(
        child: Text("Yes"),
        onPressed: () {
          Navigator.of(context).pop(true);
          deleteCartItem(menuId, index);
        });
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are You Sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Widget _getSlidableWithDelegates(
      BuildContext context, int index, Axis direction) {
    var item = cartDetails['menu'][index];

    return Slidable.builder(
      key: Key(item.name),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        closeOnCanceled: true,
        /*onWillDismiss: (item.index != 10)
            ? null
            : (actionType) {
          return showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete'),
                content: Text('Item will be deleted'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          );
        },*/
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Delete Dish');
          /*setState(() {
            cartDetails['menu'].removeAt(index);
          });*/
          //deleteCartItem(item['menu_id'], index);
          showAlertDialog(context, item['menu_id'], index);
        },
      ),
      actionPane: _getActionPane(item.index),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(cartDetails['menu'][index], index, userID, sToken,
              restaurantsId, context, this)
          : HorizontalListItem(cartDetails['menu'][index]),
      secondaryActionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            return IconSlideAction(
              caption: 'Delete',
              color: renderingMode == SlidableRenderingMode.slide
                  ? Colors.red.withOpacity(animation.value)
                  : Colors.red,
              icon: Icons.delete,
              onTap: () => _showSnackBar(context, 'Delete'),
            );
          }),
    );
  }

  createCartListItem(int index) {
    Map cartList = cartDetails['menu'][index];
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          /*decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),*/
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: cartList['image'],
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          cartList['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
                      Utils.getSizedBox(height: 6),
                      Container(
                        child: new Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 20,
                            ),
                            new Text(
                              cartList['time'].toString() + "Min",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "\$" + cartList['price'].toString(),
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Color(0xFFf18a01)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      if (cartList['quantity'] > 1) {
                                        addToCart(
                                            cartList['price'],
                                            cartList['menu_id'],
                                            cartList['quantity'] - 1,
                                            index);
                                      } else {
                                        Constants.showToast(
                                            "This is minimum quantity!");
                                      }
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.grey,
                                    ),
                                    iconSize: 24,
                                  ),
                                  Container(
                                    // color: Color(0xFFf18a01),
                                    padding: const EdgeInsets.only(
                                      bottom: 12,
                                    ),
                                    child: Text(
                                      cartList['quantity'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFf18a01),
                                          fontSize: 16),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      addToCart(
                                          cartList['price'],
                                          cartList['menu_id'],
                                          cartList['quantity'] + 1,
                                          index);
                                    },
                                    icon: Icon(Icons.add, color: Colors.grey),
                                    iconSize: 24,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 25, top: 25),
            child: IconButton(
              onPressed: () {
                deleteCartItem(cartList['menu_id'], index);
              },
              icon: Icon(
                Icons.delete_forever,
                size: 30,
                color: Colors.red.shade600,
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> confirmOrderAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Type'),
          content: const Text('Select your order type!'),
          actions: <Widget>[
            FlatButton(
              child: const Text('EAT IN'),
              onPressed: () {
                //Navigator.of(context).pop(ConfirmAction.CANCEL);
                Navigator.of(context).pop();
                eatType = "1";
                getOrder();
              },
            ),
            FlatButton(
              child: const Text('TAKEAWAY'),
              onPressed: () {
                // Navigator.of(context).pop(ConfirmAction.ACCEPT);
                Navigator.of(context).pop();
                eatType = "2";
                getOrder();
              },
            )
          ],
        );
      },
    );
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    String teamName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select your order type!'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: new InputDecoration(
                    labelText: 'Remark', hintText: 'Add Remark'),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('EAT IN'),
              onPressed: () {
                //Navigator.of(context).pop(ConfirmAction.CANCEL);
                // Navigator.of(context).pop();
                Navigator.pop(context);
                eatType = "1";
                getOrder();
              },
            ),
            FlatButton(
              child: const Text('TAKEAWAY'),
              onPressed: () {
                // Navigator.of(context).pop(ConfirmAction.ACCEPT);
                // Navigator.of(context).pop();
                Navigator.pop(context);
                eatType = "2";
                getOrder();
              },
            )
          ],
        );
      },
    );
  }

/*  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new _SystemPadding(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text('Select your order type!'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: new InputDecoration(
                      labelText: 'Remark', hintText: 'Add Remark'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('EAT IN'),
              onPressed: () {
                //Navigator.of(context).pop(ConfirmAction.CANCEL);
                // Navigator.of(context).pop();
                Navigator.pop(context);
                eatType = "1";
                getOrder();
              },
            ),
            FlatButton(
              child: const Text('TAKEAWAY'),
              onPressed: () {
                // Navigator.of(context).pop(ConfirmAction.ACCEPT);
                // Navigator.of(context).pop();
                Navigator.pop(context);
                eatType = "2";
                getOrder();
              },
            )
          ],
        ),
      ),
    );
  }*/

  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  updateCart() {
    setState(() {});
  }
  // methodInParent(String actionType,String menuId,String index) => if(actionType == "Delete"){deleteCartItem(menuId, index)};

}

class _SystemPadding extends StatelessWidget {
  final Widget child;
  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}

class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);
  var item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: item.color,
              child: Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item['name'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  var sToken, userID, restaurantsId, context;
  _CartPageState parent;
  var item, index;
  VerticalListItem(this.item, this.index, this.userID, this.sToken,
      this.restaurantsId, this.context, this.parent);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
                ? Slidable.of(context)?.open()
                : Slidable.of(context)?.close(),
        child: Stack(
          children: <Widget>[
            Container(
              // height: 80,
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              /*decoration: BoxDecoration(
               // color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),*/
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: Stack(
                      children: <Widget>[
                        Center(child: CircularProgressIndicator()),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: item['image'],
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: 80,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // padding: EdgeInsets.only(right: 8,),
                            child: Text(
                              item['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          Utils.getSizedBox(height: 3),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 20,
                              ),
                              new Text(
                                item['time'].toString() + "Min",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "\$" + item['price'].toString(),
                                style: CustomTextStyle.textFormFieldBlack
                                    .copyWith(color: Color(0xFFf18a01)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        if (item['quantity'] > 1) {
                                          this.parent.setState(() {
                                            this.parent.addToCart(
                                                item['price'],
                                                item['menu_id'],
                                                item['quantity'] - 1,
                                                index);
                                          });
                                        } else {
                                          Constants.showToast(
                                              "This is minimum quantity!");
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.grey,
                                      ),
                                      iconSize: 24,
                                    ),
                                    Container(
                                      // color: Color(0xFFf18a01),
                                      // padding: const EdgeInsets.only(bottom: 12,),
                                      child: Text(
                                        item['quantity'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFf18a01),
                                            fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        this.parent.setState(() {
                                          this.parent.addToCart(
                                              item['price'],
                                              item['menu_id'],
                                              item['quantity'] + 1,
                                              index);
                                        });
                                      },
                                      icon: Icon(Icons.add, color: Colors.grey),
                                      iconSize: 24,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //  flex: 80,
                  )
                ],
              ),
            ),
            /* Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 25, top: 25),
              child: IconButton(
                onPressed: () {
                  deleteCartItem(item['menu_id'], 1);
                },
                icon: Icon(
                  Icons.delete_forever,
                  size: 30,
                  color: Colors.red.shade600,
                ),
              ),
            ),
          )*/
          ],
        )
        /*Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
           // backgroundColor: item.color,
            child: Text('${item['name']}'),
            foregroundColor: Colors.white,
          ),
          title: Text(item['name']),
          subtitle: Text(item['name']),
        ),
      ),*/
        );
  }
}

/*class _HomeItem {
  const _HomeItem(
      this.index,
      this.name,
      this.image,
      this.subtitle,
      this.color,
      );
  final int index;
  final String name;
  final String image;

  final String subtitle;
  final Color color;
}*/
