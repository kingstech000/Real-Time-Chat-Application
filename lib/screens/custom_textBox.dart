// ignore_for_file: prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  String? hinttext;
  ValueChanged<String>? onchanged;
  bool hideText;
  CustomTextBox({
    super.key,
    this.hinttext,
    required this.onchanged,
    required this.hideText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hideText,
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
