import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/BookingSummary/booking_summary_widgets.dart';
import 'package:restaurant_app/Common/common_widgets.dart';
import 'package:restaurant_app/SelectPaymentMethod/select_payement_method_model.dart';
import 'package:restaurant_app/SelectPaymentMethod/select_payment_method_widgets.dart';

class SelectPaymentMethod extends StatefulWidget {
  @override
  _SelectPaymentMethodState createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectPaymentMethodModel>(
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
                    'Select Payment Method',
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
            backgroundColor: Colors.white70,
            elevation: 0,
            titleSpacing: 0,
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: appbarColor,
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Booking Details',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: themeResColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                'Table 20',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  color: themeResColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          heightSizedBox(10.0),
                          Row(
                            children: [
                              Text(
                                'Date : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: themeResColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                '12/1/2021',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          heightSizedBox(10.0),
                          Row(
                            children: [
                              Text(
                                'To time : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: themeResColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              widthSizedBox(5.0),
                              Text(
                                '10:20 am',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              widthSizedBox(30.0),
                              Text(
                                'From time : ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: themeResColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              widthSizedBox(5.0),
                              Text(
                                '11:20 am',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          heightSizedBox(10.0),
                          Text(
                            'Special Comments',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: themeResColor,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: Text(
                              'Dummy text is text this is published b developer team to test with all validations ',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightSizedBox(20.0),
                    choosePayment(context),
                    heightSizedBox(20.0),
                    Form(
                      key: formKey,
                      child: cardNumbers(model),
                    ),
                    heightSizedBox(20.0),
                    paymentType(),
                    heightSizedBox(20.0),
                    summaryText(),
                    heightSizedBox(50.0),
                    submitBtn(context),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
