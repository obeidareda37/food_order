import 'package:fastfood_app/const/colors.dart';
import 'package:fastfood_app/const/const_text.dart';
import 'package:fastfood_app/provider/auth_provider.dart';
import 'package:fastfood_app/service/custom_dialog.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/cart_screen/cart_screen.dart';
import 'package:fastfood_app/view/home_screens/category_screen.dart';
import 'package:fastfood_app/view/home_screens/home_restaurant_page.dart';
import 'package:fastfood_app/view/home_screens/home_screen.dart';
import 'package:fastfood_app/view/order_screens/order_history_screen.dart';
import 'package:fastfood_app/widget/drawer_widget/drawer_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  static const routeName = 'DrawerMenu';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: ColorConst.primaryColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white),
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250.h,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: ColorConst.primaryColor),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150.h,
                        margin: EdgeInsetsDirectional.only(top: 30.h),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              DrawerItemWidget(
                text: 'Home',
                onTap: () => RouteHelper.routeHelper
                    .goToPageReplacement(HomeRestaurantPage.routeName),
                icon: Icons.home,
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1.h,
              ),
              DrawerItemWidget(
                text: 'Categories',
                onTap: () =>
                    RouteHelper.routeHelper.goToPage(CategoryScreen.routeName),
                icon: Icons.list,
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1.h,
              ),
              DrawerItemWidget(
                text: 'Restaurant',
                onTap: () => RouteHelper.routeHelper
                    .goToPageReplacement(HomeScreen.routeName),
                icon: Icons.restaurant_rounded,
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1.h,
              ),
              DrawerItemWidget(
                text: 'Cart',
                onTap: () => RouteHelper.routeHelper
                    .goToPage(CartScreen.routeName),
                icon: Icons.shopping_cart,
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1.h,
              ),
              DrawerItemWidget(
                text: 'Order History',
                onTap: () => RouteHelper.routeHelper
                    .goToPageReplacement(OrderHistoryScreen.routeName),
                icon: Icons.list,
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1.h,
              ),
              Spacer(),
              DrawerItemWidget(
                text: 'Logout',
                onTap: () {
                  CustomDialog.customDialog.showCustomDialog(
                      message: LOGOUT_CONTENT,
                      title: LOGOUT_TITLE,
                      function: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logOut();
                      });
                },
                icon: Icons.restaurant_rounded,
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
