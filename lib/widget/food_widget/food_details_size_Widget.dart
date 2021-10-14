import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/size_model.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodDetailsSizeWidget extends StatefulWidget {
  List<SizeModel>? children;
  SizeModel? selectedSize;

  FoodDetailsSizeWidget({this.children, this.selectedSize});

  @override
  _FoodDetailsSizeWidgetState createState() => _FoodDetailsSizeWidgetState();
}

class _FoodDetailsSizeWidgetState extends State<FoodDetailsSizeWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: CustomText(
                text: 'Size',
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                colorText: ColorConst.primaryColor,
              ),
              textColor: ColorConst.primaryColor,
              iconColor: ColorConst.primaryColor,
              collapsedIconColor: ColorConst.primaryColor,
              collapsedTextColor: ColorConst.primaryColor,
              children: widget.children!
                  .map((e) => RadioListTile<SizeModel>(
                      title: CustomText(
                        text: e.name,
                        colorText: ColorConst.colorText,
                        fontWeight: FontWeight.bold,
                      ),
                      value: e,
                      activeColor: ColorConst.colorText,
                      groupValue: widget.selectedSize,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedSize = value!;
                        });
                      }))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
