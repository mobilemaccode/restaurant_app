import 'package:flutter/material.dart';
import 'package:restaurant_app/SelectPaymentMethod/select_payment_method.dart';

class BookingSummaryModel extends ChangeNotifier {
  TextEditingController fullNameControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController mobileNumberControl = TextEditingController();
  TextEditingController specialCommentControl = TextEditingController();

  var name;
  bool autoValidate = false;
  submit(context, formKey, model) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectPaymentMethod(),
      ),
    );
  }
}
