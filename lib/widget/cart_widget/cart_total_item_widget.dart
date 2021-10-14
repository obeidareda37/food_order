import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalItemWidget extends StatelessWidget {
  String text;
  String value;
  bool isSubTotal;

  TotalItemWidget({
    required this.text,
    required this.value,
    required this.isSubTotal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          fontWeight: FontWeight.bold,
          fontSize: isSubTotal ? 20.sp : 16.sp,
          colorText:
              isSubTotal ? ColorConst.colorText : ColorConst.primaryColor,
        ),
        CustomText(
          text: value,
          fontWeight: FontWeight.bold,
          fontSize: isSubTotal ? 20.sp : 16.sp,
          colorText:
              isSubTotal ? ColorConst.colorText : ColorConst.primaryColor,
        ),
      ],
    );
  }
}
