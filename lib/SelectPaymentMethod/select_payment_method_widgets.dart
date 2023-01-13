import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/common_widgets.dart';
import 'package:restaurant_app/Common/containerButton.dart';
import 'package:restaurant_app/Common/inputFormField.dart';
import 'package:restaurant_app/SuccessScrenn/success_screen.dart';

bool _value = false;
Color _changeColor = Colors.white38;
Widget cardNumbers(model) {
  return AllInputDesign(
    controller: model.insertCardNoController,
    // validatorFieldValue: validateCardNumber,
    // hintText: '******',
    keyBoardType: TextInputType.number,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    maxLength: 19,
    counterText: '',
    // labelText: 'Card Number',
    onSaved: (String val) {},
    prefixIcon: Image.asset('assets/images/Icon_MasterCard.png'),
    textInputAction: TextInputAction.next,
  );
}

Widget choosePayment(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Payment',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: themeResColor,
          decoration: TextDecoration.none,
        ),
      ),
      InkWell(
        onTap: () {
          _tripEditModalBottomSheet(context);
        },
        child: Text(
          'Add New Card',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: themeColor,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      Text(
        'Change',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: themeColor,
          decoration: TextDecoration.none,
        ),
      )
    ],
  );
}

Widget paymentType() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Cash Payment',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: themeResColor,
          decoration: TextDecoration.none,
        ),
      ),
      InkWell(
        onTap: () {
          // setState(() {
          //   _value = !_value;
          // });
        },
        child: Container(
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[600]),
            shape: BoxShape.circle,
            color: _value ? themeColor : _changeColor,
          ),
          child: _value
              ? Icon(
                  Icons.check,
                  size: 20.0,
                  color: Colors.white,
                )
              : Icon(
                  Icons.check,
                  size: 20.0,
                  color: Colors.white,
                ),
        ),
      ),
    ],
  );
}

Widget submitBtn(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(),
        ),
      );
    },
    child: ContainerButton(
      height: 55.0,
      text: 'Continue',
      color: Color(0xffF98A04),
    ),
  );
}

void _tripEditModalBottomSheet(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40.0),
        topLeft: Radius.circular(40.0),
      ),
    ),
    context: context,
    builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height * .60,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
          child: Column(
            children: <Widget>[
              heightSizedBox(10.0),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Image.asset(
                  "assets/images/tnsRectangle 19.png",
                ),
              ),
              nameOnTheCard(),
              heightSizedBox(10.0),
              numberOfCard(),
              heightSizedBox(10.0),
              expiryDateOfCard(),
              heightSizedBox(10.0),
              cvvNumberOfCard(),
              heightSizedBox(10.0),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // setState(() {
                      //   _value = !_value;
                      // });
                    },
                    child: Container(
                      height: 18,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[600]),
                        // shape: BoxShape.circle,
                        color: _value ? themeColor : _changeColor,
                      ),
                      child: _value
                          ? Icon(
                              Icons.check,
                              size: 14.0,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.check,
                              size: 14.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  widthSizedBox(12.0),
                  Text(
                    'Set as default payment method',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              heightSizedBox(10.0),
              ContainerButton(
                height: 55.0,
                color: Color(0xffF98A04),
                text: 'ADD CARD',
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget nameOnTheCard() {
  return AllInputDesign(
    // controller: nameOnCardController,
    // validatorFieldValue: validateName,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    keyBoardType: TextInputType.text,
    labelText: 'Name on Card',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget numberOfCard() {
  return AllInputDesign(
    // controller: cardNumberController,
    // validatorFieldValue: validateCardNumber,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    keyBoardType: TextInputType.number,
    maxLength: 16,
    counterText: '',
    labelText: 'Card Number',
    onSaved: (String val) {},
    suffixIcon: Image.asset('assets/images/Icon_MasterCard.png'),
    textInputAction: TextInputAction.next,
  );
}

Widget expiryDateOfCard() {
  return AllInputDesign(
    // controller: expiryDateController,
    // validatorFieldValue: validateExpiryDate,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    keyBoardType: TextInputType.text,
    labelText: 'Expiry Date',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}

Widget cvvNumberOfCard() {
  return AllInputDesign(
    // controller: cvvNumberController,
    // validatorFieldValue: validateCvv,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    keyBoardType: TextInputType.number,
    maxLength: 3,
    counterText: '',
    labelText: 'CVV',
    onSaved: (String val) {},
    textInputAction: TextInputAction.next,
  );
}
