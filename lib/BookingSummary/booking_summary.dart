import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/BookingSummary/booking_summary_model.dart';
import 'package:restaurant_app/BookingSummary/booking_summary_widgets.dart';
import 'package:restaurant_app/Common/common_widgets.dart';

class BookingSummary extends StatefulWidget {
  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingSummaryModel>(
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
                    'Booking Summary',
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
              Form(
                key: formKey,
                // autovalidate: model.autoValidate,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  child: ListView(
                    children: <Widget>[
                      heightSizedBox(10.0),
                      summaryText(),
                      heightSizedBox(40.0),
                      fullNameInput(),
                      heightSizedBox(10.0),
                      fullNameText(model),
                      heightSizedBox(20.0),
                      emailInput(),
                      heightSizedBox(10.0),
                      emailText(model),
                      heightSizedBox(20.0),
                      mobNoInput(),
                      heightSizedBox(10.0),
                      mobileNumberText(model),
                      heightSizedBox(20.0),
                      specialCommInput(),
                      heightSizedBox(10.0),
                      specialCommentText(model),
                      heightSizedBox(45.0),
                      submitButton(context, formKey, model),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
