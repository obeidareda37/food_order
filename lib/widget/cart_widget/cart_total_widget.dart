import 'package:fastfood_app/const/cart_consts.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/widget/cart_widget/cart_total_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TotalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CartProvider, RestaurantProvider>(
      builder: (context, provider, resProvider, x) {
        return Card(
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                TotalItemWidget(
                  text: TOTAL_TEXT,
                  value: currencyFormat.format(provider
                      .sumCart(resProvider.selectedRestaurant!.restaurantId!)),
                  isSubTotal: false,
                ),
                Divider(
                  thickness: 2,
                ),
                TotalItemWidget(
                  text: SHOPPING_FEE_TEXT,
                  value: currencyFormat.format(provider.getShippingFee(
                      resProvider.selectedRestaurant!.restaurantId!)),
                  isSubTotal: false,
                ),
                Divider(
                  thickness: 2,
                ),
                TotalItemWidget(
                  text: SUB_TOTAL_TEXT,
                  value: currencyFormat.format(provider.getSubTotal(
                      resProvider.selectedRestaurant!.restaurantId!)),
                  isSubTotal: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
