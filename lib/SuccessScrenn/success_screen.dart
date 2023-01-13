import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/common_widgets.dart';
import 'package:restaurant_app/Common/containerButton.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/tnsbags.png'),
                  heightSizedBox(20.0),
                  Text(
                    'Success!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: themeResColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  heightSizedBox(20.0),
                  Text(
                    'Your order will be delivered soon. Thank you for choosing our app!',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: themeResColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  heightSizedBox(40.0),
                  ContainerButton(
                    text: 'CONTINUE SHOPPING',
                    height: 55.0,
                    color: Color(0xffF98A04),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
