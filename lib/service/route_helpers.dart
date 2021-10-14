import 'package:flutter/material.dart';

class RouteHelper {
  RouteHelper._();

  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  goToPage(String routeName, {Object? object}) {
    navKey.currentState!.pushNamed(routeName,arguments: object);
  }

  goToPageReplacement(String routeName, {Object? object}) {
    navKey.currentState!.pushReplacementNamed(routeName,arguments: object);
  }

  back({Object? object}){
    navKey.currentState!.pop(object);
  }
}