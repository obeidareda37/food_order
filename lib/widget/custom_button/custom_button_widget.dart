import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  late Function() onPressed;

  String? text;

  CustomButtonWidget({
    required this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15.r)),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      highlightElevation: 0,
      color: ColorConst.primaryColor,
      onPressed: () {
        onPressed();
      },
      child: CustomText(
        text: text!,
        colorText: ColorConst.colorText,
        fontWeight: FontWeight.w900,
        fontSize: 20.sp,
      ),
    );
  }
}
