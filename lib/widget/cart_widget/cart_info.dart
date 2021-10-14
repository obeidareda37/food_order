import 'package:fastfood_app/const/cart_consts.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/model/restaurant_model/cart_model.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartInfo extends StatelessWidget {
  CartModel cartModel;

  CartInfo({
    required this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CustomText(
              text: cartModel.name,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              colorText: ColorConst.primaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.monetization_on,
                  color: ColorConst.colorText,
                  size: 16,
                ),
                SizedBox(
                  width: 4.w,
                ),
                CustomText(
                  text: '${currencyFormat.format(cartModel.price)}',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  colorText: ColorConst.colorText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
