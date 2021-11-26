import 'dart:async';

import 'package:badges/badges.dart';
import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/provider/cart_provider.dart';
import 'package:fastfood_app/provider/restaurnt_provider.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/cart_screen/cart_screen.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppBarWithCartButton extends StatefulWidget
    implements PreferredSizeWidget {
  String? title;
  SystemUiOverlayStyle? systemUiOverlayStyle;

  AppBarWithCartButton({this.title,this.systemUiOverlayStyle});

  @override
  State<AppBarWithCartButton> createState() => _AppBarWithCartButtonState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0.h);
}

class _AppBarWithCartButtonState extends State<AppBarWithCartButton> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: widget.systemUiOverlayStyle,
      title: CustomText(
        text: widget.title!,
        colorText: ColorConst.colorText,
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        onPressed: () {
          RouteHelper.routeHelper.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: ColorConst.primaryColor,
        ),
      ),
      leadingWidth: 40.w,
      actions: [
        Badge(
          position: BadgePosition(top: 0, end: 1),
          animationDuration: Duration(milliseconds: 200),
          animationType: BadgeAnimationType.scale,
          showBadge: true,
          badgeColor: Colors.red,
          badgeContent: CustomText(
            text:
                '${Provider.of<CartProvider>(context, listen: true).getQuantity(Provider.of<RestaurantProvider>(context, listen: true).selectedRestaurant!.restaurantId!)}',
            colorText: Colors.white,
          ),
          child: IconButton(
            onPressed: () =>
                RouteHelper.routeHelper.goToPage(CartScreen.routeName),
            icon: Icon(
              Icons.shopping_bag,
              color: ColorConst.primaryColor,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
    );
  }
}
