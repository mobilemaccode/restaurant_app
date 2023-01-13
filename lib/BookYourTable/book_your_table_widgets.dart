import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/Common/common_widgets.dart';

class SelectDate extends StatefulWidget {
  final model;
  SelectDate({
    @required this.model,
  });

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  var currDt = DateTime.now();
  var bookingDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 10)),
    );
    bookingDate = picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 8.0, right: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.model.selectDate == null
                ? '${DateFormat('yyyy-MM-dd').format(DateTime.now())}'
                : widget.model.selectDate,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          InkWell(
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: themeResColor,
            ),
            onTap: () {
              _selectDate(context).then(
                (result) => setState(
                  () {
                    widget.model.selectDate =
                        bookingDate.toString().substring(0, 10);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  final model;
  final type;
  SelectTime({
    @required this.model,
    @required this.type,
  });

  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  String _setTime;
  var bookingTime;
  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();
  TextEditingController _timeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        bookingTime = _time;
        _timeController.text = formatDate(
          DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
          [hh, ':', nn, " ", am],
        ).toString();
        bookingTime = formatDate(
          DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
          [hh, ':', nn, " ", am],
        ).toString();
      });
  }

  void initState() {
    super.initState();
    _timeController.text = formatDate(
      DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
      [hh, ':', nn, " ", am],
    ).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 8.0, right: 18.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: TextStyle(fontSize: 14),
              onSaved: (String val) {
                // _selectTime(context).then(
                //   (result) => setState(
                //     () {
                //       widget.model.selectTime = val;
                //     },
                //   ),
                // );
                // setState(
                //   () {
                //     widget.model.selectTime = val;
                //   },
                // );
                _setTime = val;
              },
              enabled: false,
              keyboardType: TextInputType.text,
              controller: _timeController,
              decoration: InputDecoration(
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(5),
              ),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: themeResColor,
            ),
            // onTap: () {
            //   _selectTime(context);
            // },
            onTap: () {
              _selectTime(context).then(
                (result) => setState(
                  () {
                    widget.type == 'from'
                        ? widget.model.selectFromTime = bookingTime
                        : widget.model.selectToTime = bookingTime;
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
