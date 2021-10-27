import 'dart:convert';
import 'dart:math';

import 'package:fastfood_app/const/cart_consts.dart';
import 'package:fastfood_app/helpers/auth_helpers.dart';
import 'package:fastfood_app/helpers/firebase_realtime_helpers.dart';
import 'package:fastfood_app/model/restaurant_model/cart_model.dart';
import 'package:fastfood_app/model/restaurant_model/food_model.dart';
import 'package:fastfood_app/model/restaurant_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CartProvider with ChangeNotifier {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  bool isSuccess = false;

  List<CartModel> cart = List<CartModel>.empty(growable: true);
  final box = GetStorage();

  getCart(String restaurantId) => cart.where((element) =>
      element.restaurantId == restaurantId &&
      element.userUid == AuthHelpers.authHelpers.getUserId()).toList();

  addToCart(
    FoodModel foodModel,
    String restaurantId, {
    int quantity: 1,
  }) async {
    try {
      var cartItem = CartModel(
          userUid: AuthHelpers.authHelpers.getUserId(),
          id: foodModel.id,
          name: foodModel.name,
          description: foodModel.description,
          image: foodModel.image,
          price: foodModel.price,
          addon: foodModel.addon,
          size: foodModel.size,
          quantity: quantity,
          restaurantId: restaurantId);
      if (isExists(cartItem, restaurantId)) {
        print('exist');
        var foodNeedToUpdate = getCartNeedUpdate(cartItem, restaurantId);
        if (foodNeedToUpdate != null) {
          foodNeedToUpdate.quantity += quantity;
          print('foodNeedToUpdate');
        }
      } else {
        print('notexist');
        cart.add(cartItem);
        notifyListeners();
      }
      var jsonDBEncode = jsonEncode(cart);
      await box.write(MY_CART_KEY, jsonDBEncode);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  bool isExists(
    CartModel cartItem,
    String restaurantId,
  ) =>
      cart.any((element) =>
          element.id == cartItem.id &&
          element.restaurantId == restaurantId &&
          element.userUid == AuthHelpers.authHelpers.getUserId());

  sumCart(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.price * e.quantity)
          .reduce((value, element) => value + element);

  getQuantity(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.quantity)
          .reduce((value, element) => value + element);

  getShippingFee(String restaurantId) =>
      sumCart(restaurantId) * 0.1; //10% of total value

  getSubTotal(String restaurantId) =>
      sumCart(restaurantId) + getShippingFee(restaurantId);

  clearCart(String restaurantId) {
    cart = getCart(restaurantId).clear();
    saveDatabase();
    notifyListeners();
  }

  saveDatabase() => box.write(MY_CART_KEY, jsonEncode(cart));

  // mergeCart(List<CartModel> cartItems, String restaurantId) {
  //   if (cart.length > 0) {
  //     cartItems.forEach((element) {
  //       if (isExists(element, restaurantId)) {
  //         print('exist');
  //         var foodNeedToUpdate = getCartNeedUpdate(element, restaurantId);
  //         if (foodNeedToUpdate != null) {
  //           print('exist1');
  //           foodNeedToUpdate.quantity += element.quantity;
  //           notifyListeners();
  //         } else {
  //           print('notexist');
  //           var newCart = element;
  //           newCart.userUid = AuthHelpers.authHelpers.getUserId();
  //           cart.add(newCart);
  //           notifyListeners();
  //         }
  //       }
  //     });
  //   }
  // }

  restController() {
    fNameController.clear();
    lNameController.clear();
    addressController.clear();
    commentController.clear();
  }

  getCartNeedUpdate(CartModel cartItem, String restaurantId) =>
      cart.firstWhere((element) =>
          element.id == cartItem.id &&
          element.restaurantId == restaurantId &&
          element.userUid == cartItem.userUid);

  writeOrderToFirebase(OrderModel orderModel) async {
    try {
      await FirebaseRealTimeHelpers.realTimeHelpers
          .writeOrderToFirebase(orderModel);
      restController();
      isSuccess = true;
      notifyListeners();
    } on Exception catch (e) {
      isSuccess = false;
      notifyListeners();
    }
  }

  int createOrderNumber(int original) {
    return original + new Random().nextInt(1000);
  }

  double calculateFinalPayment(double subTotal, double discount) {
    return subTotal - (subTotal * (discount / 100));
  }
}
