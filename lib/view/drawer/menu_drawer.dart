import 'package:fastfood_app/const/const_text.dart';
import 'package:fastfood_app/provider/auth_provider.dart';
import 'package:fastfood_app/service/custom_dialog.dart';
import 'package:fastfood_app/service/route_helpers.dart';
import 'package:fastfood_app/view/home_screens/category_screen.dart';
import 'package:fastfood_app/view/home_screens/home_screen.dart';
import 'package:fastfood_app/widget/custom_text.dart';
import 'package:fastfood_app/widget/drawer_widget/drawer_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  final ZoomDrawerController? zoomDrawerController;

  DrawerMenu({this.zoomDrawerController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB71C1C),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 40.h),
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: Color(0xFF7F0000),
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            DrawerItemWidget(
              text: 'Home',
              onTap: () => zoomDrawerController!.toggle!(),
              icon: Icons.home,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 1,
            ),
            DrawerItemWidget(
              text: 'Categories',
              onTap: () =>
                  RouteHelper.routeHelper.goToPage(CategoryScreen.routeName),
              icon: Icons.list,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              thickness: 1,
            ),
            DrawerItemWidget(
              text: 'Restaurant',
              onTap: () => RouteHelper.routeHelper
                  .goToPageReplacement(HomeScreen.routeName),
              icon: Icons.restaurant_rounded,
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
          ],
        ),
      ),
    );
  }
}
