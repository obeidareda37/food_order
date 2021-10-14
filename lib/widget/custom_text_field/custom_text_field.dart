import 'package:fastfood_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  late String labelText;
  String? Function(String? value)? validate;
  String? Function(String? value)? onChange;
  Function? requestFocus;
  FocusNode? myFocusNode;
  TextInputType? keyboard;
  TextEditingController? controller;
  double? borderRadius;

  CustomTextFormField(
      {required this.labelText,
      this.validate,
      this.onChange,
      this.requestFocus,
      this.myFocusNode,
      this.keyboard,
      this.controller,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      onTap: () {
        requestFocus!();
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: validate,
      focusNode: myFocusNode,
      decoration: InputDecoration(
        focusColor: ColorConst.primaryColor,
        labelText: labelText,
        labelStyle: TextStyle(
            color:
                myFocusNode!.hasFocus ? ColorConst.primaryColor : Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: Colors.grey, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: Colors.grey, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: ColorConst.primaryColor, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: Colors.red, width: 1.w),
        ),
        errorStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
