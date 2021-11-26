import 'dart:convert';
import 'package:fastfood_app/const/const_text.dart';
import 'package:fastfood_app/const/reference_database.dart';
import 'package:fastfood_app/model/restaurant_model/category_model.dart';
import 'package:fastfood_app/model/restaurant_model/order_model.dart';
import 'package:fastfood_app/model/restaurant_model/popular_item_model.dart';
import 'package:fastfood_app/model/restaurant_model/restaurant_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealTimeHelpers {
  FirebaseRealTimeHelpers._();

  static FirebaseRealTimeHelpers realTimeHelpers = FirebaseRealTimeHelpers._();

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  getRestaurantList() async {
    var list = List<RestaurantModel>.empty(growable: true);
    var reference =
        await firebaseDatabase.reference().child(RESTAURANT_REF).once();

    RestaurantModel? restaurantModel;
    Map<dynamic, dynamic> values = reference.value;
    values.forEach((key, value) {
      restaurantModel = RestaurantModel.fromJson(jsonDecode(jsonEncode(value)));
      restaurantModel!.restaurantId = key;
      list.add(restaurantModel!);
    });

    print('${list.length} list in helpers');

    return list;
  }

  getMostPopularRestaurant(String restaurantId) async {
    var list = List<PopularItemModel>.empty(growable: true);
    var reference = await firebaseDatabase
        .reference()
        .child(RESTAURANT_REF)
        .child(restaurantId)
        .child(MOST_POPULAR_REF)
        .once();

    Map<dynamic, dynamic> values = reference.value;
    values.forEach((key, value) {
      list.add(PopularItemModel.fromJson(jsonDecode(jsonEncode(value))));
    });

    print('${list.length} list mostPopular');

    return list;
  }

  getBestDealsRestaurant(String restaurantId) async {
    var list = List<PopularItemModel>.empty(growable: true);
    var reference = await firebaseDatabase
        .reference()
        .child(RESTAURANT_REF)
        .child(restaurantId)
        .child(BEST_DEALS_REF)
        .once();

    Map<dynamic, dynamic> values = reference.value;
    values.forEach((key, value) {
      list.add(PopularItemModel.fromJson(jsonDecode(jsonEncode(value))));
    });

    print('${list.length} list bestDeals');

    return list;
  }

  Future<List<CategoryModel>> getCategoryByRestaurantId(
      String restaurantId) async {
    var list = List<CategoryModel>.empty(growable: true);
    var reference = await firebaseDatabase
        .reference()
        .child(RESTAURANT_REF)
        .child(restaurantId)
        .child(CATEGORY_REF)
        .once();

    Map<dynamic, dynamic> values = reference.value;
    values.forEach((key, value) {
      list.add(CategoryModel.fromJson(jsonDecode(jsonEncode(value))));
    });

    return list;
  }

  writeOrderToFirebase(OrderModel orderModel) async {
    try {
      await firebaseDatabase
          .reference()
          .child(RESTAURANT_REF)
          .child(orderModel.restaurantId!)
          .child(ORDER_REF)
          .child(orderModel.orderNumber!)
          .set(orderModel.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<OrderModel>> getUserOrdersByRestaurant(
      String restaurantId, String userId, String statusMode) async {
    var orderStatusMode = statusMode == ORDER_CANCELLED ? -1 : 2;
    var list = List<OrderModel>.empty(growable: true);
    var reference = await firebaseDatabase
        .reference()
        .child(RESTAURANT_REF)
        .child(restaurantId)
        .child(ORDER_REF)
        .orderByChild('userId')
        .equalTo(userId)
        .once();

    Map<dynamic, dynamic> values = reference.value;
    values.forEach((key, value) {
      list.add(OrderModel.fromJson(jsonDecode(jsonEncode(value))));
    });
    return list
        .where((element) => statusMode == ORDER_PROCESSING
            ? (element.orderStatus == 0 || element.orderStatus == 1)
            : element.orderStatus == orderStatusMode)
        .toList();
  }
}
