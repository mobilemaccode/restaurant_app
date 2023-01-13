import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

convertKey(text) {
  var removedSteps = text.toString().toLowerCase().replaceAll(' ', '_');
  return removedSteps;
}

class AllInputDesign extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final controller;
  final prefixText;
  final maxLine;
  final enabled;
  final onTap;
  final hintText;
  final labelText;
  final inputHeaderName;
  final textInputAction;
  final counterText;
  final maxLength;
  final obscureText;
  final prefixStyle;
  final validator;
  final errorText;
  final inputborder;
  final contentPadding;
  final initialValue;
  final keyBoardType;
  final validatorFieldValue;
  final alignLabelWithHint;
  final enabledBorder;
  final expand;
  final disabledBorder;
  final prefixIcon;
  final focusedBorder;
  final List<TextInputFormatter> inputFormatterData;
  final FormFieldSetter<String> onSaved;
  final obsecureText;
  final suffixIcon;

  const AllInputDesign({
    Key key,
    this.controller,
    this.maxLine = 1,
    this.enabled,
    this.prefixText,
    this.textInputAction,
    this.onTap,
    this.inputborder,
    this.alignLabelWithHint,
    this.focusedBorder,
    this.enabledBorder,
    this.expand,
    this.disabledBorder,
    this.prefixIcon,
    this.counterText,
    this.maxLength,
    this.obscureText,
    this.prefixStyle,
    this.keyBoardType,
    this.obsecureText,
    this.contentPadding,
    this.initialValue,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.inputHeaderName,
    this.validatorFieldValue,
    this.inputFormatterData,
    this.validator,
    this.onSaved,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  _AllInputDesignState createState() => _AllInputDesignState();
}

class _AllInputDesignState extends State<AllInputDesign> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          cursorColor: Colors.black,
          maxLines: widget.maxLine,
          initialValue: widget.initialValue,
          maxLength: widget.maxLength,
          key: Key(convertKey(widget.inputHeaderName)),
          onSaved: widget.onSaved,
          keyboardType: widget.keyBoardType,
          validator: widget.validatorFieldValue,
          onTap: widget.onTap,
          controller: widget.controller,
          enabled: widget.enabled,
          expands: widget.expand ?? false,
          inputFormatters: widget.inputFormatterData,
          obscureText: widget.obscureText ?? false,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            focusedBorder: widget.focusedBorder,
            enabledBorder: widget.enabledBorder,
            disabledBorder: widget.disabledBorder,
            prefixIcon: widget.prefixIcon,
            border: widget.inputborder,
            filled: true,
            fillColor: Colors.white,
            counterText: widget.counterText,
            hintText: (widget.hintText != null) ? widget.hintText : '',
            labelText: (widget.labelText != null) ? widget.labelText : '',
            alignLabelWithHint: widget.alignLabelWithHint ?? false,
            hintStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'Montserrat',
            ),
            labelStyle: TextStyle(
              color: Colors.black54,
              fontFamily: 'Montserrat',
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: widget.suffixIcon != null ? widget.suffixIcon : Text(''),
            ),
            prefixText: (widget.prefixText != null) ? widget.prefixText : '',
            prefixStyle: widget.prefixStyle,
            errorText: widget.errorText,
            contentPadding: EdgeInsets.all(widget.contentPadding ?? 15.0),
            /*focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.teal[600], width: 1.2),
              ),*/
            /*  enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.teal[600], width: 1.2),
              ),*/
            // border: OutlineInputBorder(),
            /*   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      BorderSide(color: Color(0XFFF3F3F3), width: 1.0))*/
          ),
        ),
      ],
    );
  }
}
