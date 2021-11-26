import 'package:fastfood_app/helpers/firebase_realtime_helpers.dart';
import 'package:fastfood_app/model/restaurant_model/category_model.dart';
import 'package:fastfood_app/model/restaurant_model/popular_item_model.dart';
import 'package:fastfood_app/model/restaurant_model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantProvider with ChangeNotifier {
  List<RestaurantModel> restaurantList = [];
  List<PopularItemModel> mostPopularList = [];
  List<PopularItemModel> bestDealsList = [];
  List<CategoryModel> categoryList = [];
  RestaurantModel? selectedRestaurant;


  getRestaurantList() async {
    restaurantList =
        await FirebaseRealTimeHelpers.realTimeHelpers.getRestaurantList();
    print(restaurantList[0].name);
    notifyListeners();
  }

  getMostPopularItemRestaurant() async {
    mostPopularList = await FirebaseRealTimeHelpers.realTimeHelpers
        .getMostPopularRestaurant(selectedRestaurant!.restaurantId!);
    getCategoryByRestaurant();
    notifyListeners();
  }

  getBestDealsItemRestaurant() async {
    bestDealsList = await FirebaseRealTimeHelpers.realTimeHelpers
        .getBestDealsRestaurant(selectedRestaurant!.restaurantId!);
    getCategoryByRestaurant();
    notifyListeners();
  }

  getCategoryByRestaurant() async {
    categoryList = await FirebaseRealTimeHelpers.realTimeHelpers
        .getCategoryByRestaurantId(selectedRestaurant!.restaurantId!);

    print(categoryList[0].name);
    notifyListeners();
  }

}
