import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DrawerItemWidget extends StatelessWidget {
  String text;
  IconData icon;
  Function onTap;

  DrawerItemWidget(
      {required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorConst.primaryColor,
            ),
            SizedBox(
              width: 30.w,
            ),
            CustomText(
              text: text,
              fontSize: 18.sp,
              colorText: ColorConst.primaryColor,
              fontWeight: FontWeight.w900,
            ),
          ],
        ),
      ),
    );
  }
}
