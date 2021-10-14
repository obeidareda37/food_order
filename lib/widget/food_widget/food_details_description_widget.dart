import 'package:fastfood_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodDetailsDescriptionWidget extends StatelessWidget {
  late String description;

  FoodDetailsDescriptionWidget({required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingBar.builder(
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  color: ColorConst.colorText,
                );
              },
              onRatingUpdate: (value) {},
              allowHalfRating: false,
              direction: Axis.horizontal,
              minRating: 1,
              initialRating: 5,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              text: description,
              fontSize: 14.sp,
              colorText: ColorConst.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
