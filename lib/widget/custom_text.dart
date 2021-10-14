import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  late String text;
  Color? colorText;
  double? fontSize;
  FontWeight? fontWeight;
  TextDirection? textDirection;
  int? maxLines;
  TextAlign? textAlign;
  String? fontFamily;
  FontStyle? fontStyle;
  TextOverflow? overflow;

  CustomText({
    required this.text,
    this.colorText,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.fontStyle,
    this.fontFamily,
    this.overflow
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colorText,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily:fontFamily,
        fontStyle:fontStyle,
      ),
      textDirection: textDirection,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}