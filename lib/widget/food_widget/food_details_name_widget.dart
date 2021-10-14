import 'package:fastfood_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_text.dart';

class FoodDetailsNameWidget extends StatelessWidget {
  late String name;
  late double price;
  void Function(num)? onChanged;
  late int quantity;

  FoodDetailsNameWidget(
      {required this.name,
      required this.price,
      required this.onChanged,
      required this.quantity});

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
            CustomText(
              text: name,
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
              colorText: ColorConst.primaryColor,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: '\$$price',
                  fontSize: 16.sp,
                  colorText: ColorConst.colorText,
                  fontWeight: FontWeight.w900,
                ),
                ElegantNumberButton(
                    initialValue: quantity,
                    minValue: 1,
                    maxValue: 100,
                    textStyle: TextStyle(color: ColorConst.primaryColor),
                    color: ColorConst.colorText,
                    onChanged: (value) {
                      onChanged!(value);
                    },
                    decimalPlaces: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
