import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookYourTableModel extends ChangeNotifier {
  var selectDate = DateFormat('yy-MM-dd').format(DateTime.now());

  var selectFromTime;
  var selectToTime;
  // = TimeOfDay(hour: 00, minute: 00).hour.toString() +
  //     ' : ' +
  //     TimeOfDay(hour: 00, minute: 00).minute.toString();
  // var selectTime = formatDate(
  //   DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
  //   [hh, ':', nn, " ", am],
  // ).toString();
}
