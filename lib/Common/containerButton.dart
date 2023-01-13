import 'package:flutter/material.dart';
import 'package:restaurant_app/Common/common_widgets.dart';

convertKey(text) {
  var removedSteps = text.toString().toLowerCase().replaceAll(' ', '_');
  return removedSteps;
}

class ContainerButton extends StatefulWidget {
  final height;
  final width;
  final text;
  final color;
  final textColor;

  const ContainerButton({
    Key key,
    this.height,
    this.width,
    this.text,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  _ContainerButtonState createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: widget.color ?? themeColor,
      ),
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 14,
            color: widget.textColor ?? Colors.white,
            decoration: TextDecoration.none,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
