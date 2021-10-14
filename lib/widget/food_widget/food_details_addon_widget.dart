import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/addon_model.dart';
import 'package:fastfood_app/model/restaurant_model/food_model.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodDetailsAddonWidget extends StatefulWidget {
  FoodModel foodModel;
  List<AddonModel> selectedAddon;

  FoodDetailsAddonWidget(
      {required this.foodModel, required this.selectedAddon});

  @override
  State<FoodDetailsAddonWidget> createState() => _FoodDetailsAddonWidgetState();
}

class _FoodDetailsAddonWidgetState extends State<FoodDetailsAddonWidget> {
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
                  text: 'Addon',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
                textColor: ColorConst.primaryColor,
                iconColor: ColorConst.primaryColor,
                collapsedIconColor: ColorConst.primaryColor,
                collapsedTextColor: ColorConst.primaryColor,
                children: [
                  Wrap(
                    children: widget.foodModel.addon
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: ChoiceChip(
                              label: CustomText(
                                text: e.name,
                                colorText: ColorConst.colorText,
                              ),
                              selected: widget.selectedAddon.contains(e),
                              selectedColor: Colors.amber,
                              onSelected: (selected) {
                                selected
                                    ? widget.selectedAddon.add(e)
                                    : widget.selectedAddon.remove(e);
                                setState(() {});
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
