
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RoundedShapedButton extends StatelessWidget {
  String text;
  VoidCallback? onpressed;
  Color buttonColor;
  RoundedShapedButton({
    super.key,
    required this.text,
    this.onpressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
