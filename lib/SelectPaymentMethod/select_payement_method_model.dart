import 'package:flutter/material.dart';

class SelectPaymentMethodModel extends ChangeNotifier {
  var selectTime;
  bool autoValidate = false;

  TextEditingController insertCardNoController = TextEditingController();
}
