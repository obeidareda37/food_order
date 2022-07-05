import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class OnBoardingWidget extends StatelessWidget {
  String? title;
  String? description;
  String? image;

  OnBoardingWidget({this.title, this.description, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 70.h),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image!,
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomText(
            text: easy.tr(title!),
            fontSize: 25.sp,
            colorText: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.only(right: 50.w, left: 50.w),
            child: CustomText(
              text: easy.tr(description!),
              fontSize: 17.sp,
              maxLines: 2,
              textAlign: TextAlign.center,
              colorText: Color(0xff4D4D4D),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
