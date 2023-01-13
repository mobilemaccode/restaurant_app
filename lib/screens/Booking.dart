import 'package:flutter/material.dart';
import 'package:restaurant_app/BookingSummary/booking_summary.dart';
import 'package:restaurant_app/Common/common_widgets.dart';
import 'package:restaurant_app/Common/containerButton.dart';
import 'package:restaurant_app/SelectPaymentMethod/select_payment_method.dart';

class Booking extends StatefulWidget {
  @override
  BookingState createState() => new BookingState();
}

class BookingState extends State<Booking> {
  var tableList = ["1", "2", "3", "4", "6", "7", "8", "9", "10", "11", "12"];
  void initState() {
    super.initState();
    // Enable hybrid composition.
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: themeResColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                'Book Your Table',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: themeResColor,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(''),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(12.0),
            child: new GridView.builder(
                // childAspectRatio: (itemWidth / itemHeight),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: tableList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // print(vendorList[index]["id"]);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => productDetail(),
                      //   ),
                      // );
                    },
                    child: Container(
                      width: 146,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffE0E0E0),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(9))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/tnsRectangle 19.png",
                              alignment: Alignment.center,
                            ),

                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'name',
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xff21335A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'circular'),
                              ),
                            ),
                            // Flexible(fit: FlexFit.tight, child: SizedBox()),
                            // Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     productList[index]["discounted_price"],
                            //     style: TextStyle(
                            //         color: Color(0xff333333),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.normal,
                            //         fontFamily: 'assets/fonts/circular'),
                            //   ),
                            // ),
                          ]),
                      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    ),
                  );
                }),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingSummary(),
                ),
              );
            },
            // Provider.of<BookingSummaryModel>(context)
            // .submit(context, formKey, model),
            child: Container(
              width: double.infinity,
              child: ContainerButton(
                height: 55.0,
                text: 'Continue',
                color: Color(0xffF98A04),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
