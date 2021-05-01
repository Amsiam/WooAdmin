import 'package:flutter/material.dart';

class FormHelper {
  static Widget inputFieldWidget(
    BuildContext context,
    Icon icon,
    String keyName,
    String hintText,
    Function onValidate,
    Function onSaved, {
    String? initialValue = "",
    obscureText: false,
    double fontSize = 18,
    double hintFontSize = 15,
    double paddingLeft = 20,
    double paddingRight = 20,
    double paddingTop = 0,
    double paddingBottom = 0,
    Widget? suffixIcon,
    double borderRadius = 30,
    Color borderColor = Colors.redAccent,
    Color borderFocusColor = Colors.redAccent,
    bool showPrefixIcon = true,
    Color prefixIconColor = Colors.redAccent,
    double prefixIconPaddingLeft = 30,
    double prefixIconPaddingRight = 10,
    double prefixIconPaddingTop = 0,
    double prefixIconPaddingBottom = 0,
    double containerHeight = 60,
    double containerWidth = 0,
    bool isMultiline = false,
    Function? onChange,
  }) {
    return Container(
      height: containerHeight,
      width: containerWidth == 0
          ? MediaQuery.of(context).size.width
          : containerWidth,
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: isMultiline ? null : 1,
        key: new Key(initialValue.toString()),
        obscureText: obscureText,
        validator: (val) {
          return onValidate(val);
        },
        onSaved: (val) {
          return onSaved(val);
        },
        onChanged: (val) {
          return onChange != null ? onChange(val) : null;
        },
        style: TextStyle(
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: hintFontSize,
          ),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderFocusColor, width: 2.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: showPrefixIcon
              ? Padding(
                  child: IconTheme(
                    data: IconThemeData(color: prefixIconColor),
                    child: icon,
                  ),
                  padding: EdgeInsets.only(
                    left: prefixIconPaddingLeft,
                    right: prefixIconPaddingRight,
                    top: prefixIconPaddingTop,
                    bottom: prefixIconPaddingBottom,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  static Widget inputFieldWidgetWithLabel(
    BuildContext context,
    Icon icon,
    String keyName,
    String labelName,
    String hintText,
    Function onValidate,
    Function onSaved, {
    String? initialValue = "",
    obscureText: false,
    double labelFontSize: 20,
    bool labelBold = true,
    double fontSize = 18,
    double hintFontSize = 15,
    double paddingLeft = 20,
    double paddingRight = 20,
    double paddingTop = 0,
    double paddingBottom = 0,
    Widget? suffixIcon,
    double borderRadius = 30,
    Color borderColor = Colors.redAccent,
    Color borderFocusColor = Colors.redAccent,
    bool showPrefixIcon = true,
    Color prefixIconColor = Colors.redAccent,
    double prefixIconPaddingLeft = 30,
    double prefixIconPaddingRight = 10,
    double prefixIconPaddingTop = 0,
    double prefixIconPaddingBottom = 0,
    bool isMultiline = false,
    double containerHeight = 60,
    double containerWidth = 0,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(
              left: 0,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labelName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: labelFontSize,
                  fontWeight: labelBold ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
          inputFieldWidget(
              context, icon, keyName, hintText, onValidate, onSaved,
              initialValue: initialValue!,
              obscureText: obscureText,
              fontSize: fontSize,
              hintFontSize: hintFontSize,
              paddingLeft: paddingLeft,
              paddingRight: paddingRight,
              paddingTop: paddingTop,
              paddingBottom: paddingBottom,
              suffixIcon: suffixIcon,
              borderRadius: borderRadius,
              borderColor: borderColor,
              borderFocusColor: borderFocusColor,
              showPrefixIcon: showPrefixIcon,
              prefixIconColor: prefixIconColor,
              prefixIconPaddingLeft: prefixIconPaddingLeft,
              prefixIconPaddingRight: prefixIconPaddingRight,
              prefixIconPaddingTop: prefixIconPaddingTop,
              prefixIconPaddingBottom: prefixIconPaddingBottom,
              isMultiline: isMultiline,
              containerHeight: containerHeight,
              containerWidth: containerWidth),
        ],
      ),
    );
  }

  static Widget submitButton(
    String buttonText,
    Function onTap, {
    double height = 50,
    double width = 150,
    Color btnColor = Colors.redAccent,
    double borderRadius = 30,
    Color borderColor = Colors.redAccent,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color txtColor = Colors.white,
  }) {
    return Container(
      height: height,
      width: width,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: btnColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: txtColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showSimpleAlertDialog(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: [
            // submitButton(
            //   buttonText,
            //   onPressed(),
            // ),
            new TextButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            )
          ],
        );
      },
    );
  }
}
