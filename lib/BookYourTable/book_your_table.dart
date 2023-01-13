import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/BookYourTable/book_your_table_model.dart';
import 'package:restaurant_app/BookYourTable/book_your_table_widgets.dart';
import 'package:restaurant_app/BookingSummary/booking_summary.dart';
import 'package:restaurant_app/Common/common_widgets.dart';
import 'package:restaurant_app/Common/containerButton.dart';
import 'package:restaurant_app/screens/Booking.dart';

class BookYourTable extends StatefulWidget {
  @override
  _BookYourTableState createState() => _BookYourTableState();
}

class _BookYourTableState extends State<BookYourTable> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookYourTableModel>(
      builder: (context, model, _) {
        return Scaffold(
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
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(27.0, 20.0, 20.0, 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To Date & Time',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: themeResColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    heightSizedBox(2.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: themeResColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios_outlined),
                              onPressed: null,
                            ),
                            Text(
                              model.selectDate,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: themeResColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                              onPressed: null,
                            ),
                          ],
                        )
                      ],
                    ),
                    // heightSizedBox(5.0),
                    // selectDate(model, context),
                    SelectDate(model: model),
                    heightSizedBox(8.0),
                    Text(
                      'From',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: themeResColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    heightSizedBox(5.0),
                    // fromTime(model, context),
                    SelectTime(model: model, type: 'from'),
                    heightSizedBox(5.0),
                    Text(
                      'To',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: themeResColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    heightSizedBox(5.0),
                    SelectTime(model: model, type: 'to'),
                    heightSizedBox(40.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Booking(),
                          ),
                        );
                      },
                      child: ContainerButton(
                        height: 55.0,
                        text: 'Continue',
                        color: Color(0xffF98A04),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
