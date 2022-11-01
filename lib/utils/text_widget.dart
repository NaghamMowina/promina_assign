import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? align;
  final String? fontFamily;
  final TextDecoration? decoration;
  const TextUtils({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.align,
    this.fontFamily,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          decoration: decoration,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }
}
