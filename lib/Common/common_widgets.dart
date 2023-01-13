import 'package:flutter/material.dart';

SizedBox heightSizedBox(height) {
  return SizedBox(
    height: height,
  );
}

SizedBox widthSizedBox(width) {
  return SizedBox(
    width: width,
  );
}

Color appbarColor = Colors.white;
Color themeColor = Color(0xffE01C23);
Color themeResColor = Colors.black;

Divider divider(height, thickness, indent, endIndent) {
  return Divider(
    height: height,
    thickness: thickness,
    indent: indent,
    endIndent: endIndent,
  );
}
