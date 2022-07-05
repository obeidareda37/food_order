import 'package:fastfood_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildPageIndicator extends StatelessWidget {
  final bool isCurrentPage;

  BuildPageIndicator(this.isCurrentPage);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 35),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 15.h,
      width: 15.w,
      decoration: BoxDecoration(
        color: isCurrentPage ? ColorConst.primaryColor : Colors.white54,
        border: isCurrentPage
            ? Border.all(
          color: ColorConst.primaryColor,
        )
            : Border.all(
          color: Color(0xff272727),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}