import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/common_widgets.dart';
import 'package:restaurant_app/Common/containerButton.dart';
import 'package:restaurant_app/Common/inputFormField.dart';
import 'package:restaurant_app/SelectPaymentMethod/select_payment_method.dart';

Widget summaryText() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary :',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '127\$',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      heightSizedBox(6.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Amount :',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '127\$',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget fullNameInput() {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(
      'Full Name',
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget emailInput() {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(
      'Email',
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget mobNoInput() {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(
      'Mobile Number',
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget specialCommInput() {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(
      'Add Special Comments',
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Widget fullNameText(model) {
  return AllInputDesign(
    key: Key("FullName"),
    controller: model.fullNameControl,
    // validatorFieldValue: validateEmail,
    keyBoardType: TextInputType.text,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    labelText: 'Full Name',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget emailText(model) {
  return AllInputDesign(
    controller: model.emailControl,
    // validatorFieldValue: validateEmail,
    keyBoardType: TextInputType.emailAddress,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    labelText: 'Email',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget mobileNumberText(model) {
  return AllInputDesign(
    controller: model.mobileNumberControl,
    // validatorFieldValue: validateEmail,
    keyBoardType: TextInputType.emailAddress,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    labelText: 'Mobile Number',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget specialCommentText(model) {
  return AllInputDesign(
    controller: model.specialCommentControl,
    // validatorFieldValue: validateEmail,
    keyBoardType: TextInputType.multiline,
    maxLine: 4,
    // expand: true,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    // labelText: 'Add Special Comment',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget submitButton(context, formKey, model) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectPaymentMethod(),
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
  );
}
