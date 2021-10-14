import 'package:fastfood_app/view/drawer/menu_drawer.dart';
import 'package:fastfood_app/view/home_screens/home_restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerZoom extends StatelessWidget {
  static final routeName = 'drawerHome';

  final drawerZoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    print(drawerZoomController);
    return Scaffold(
      body: SafeArea(
        child: ZoomDrawer(
          controller: drawerZoomController,
          menuScreen: DrawerMenu(
            zoomDrawerController: drawerZoomController,
          ),
          mainScreen: HomeRestaurantPage(
            zoomDrawerController: drawerZoomController,
          ),
          borderRadius: 24.0,
          showShadow: true,
          angle: 0.0,
          backgroundColor: Colors.grey[300]!,
          slideWidth: MediaQuery.of(context).size.width * 0.65,
          openCurve: Curves.bounceInOut,
          closeCurve: Curves.ease,
        ),
      ),
    );
  }
}
