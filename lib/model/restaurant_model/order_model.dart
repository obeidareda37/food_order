import 'package:fastfood_app/model/restaurant_model/cart_model.dart';

class OrderModel {
  String? userId;
  String? restaurantId;
  String? userName;
  String? userPhone;
  String? shippingAddress;
  String? comment;
  String? orderNumber;
  double? totalPayment;
  double? finalPayment;
  double? shippingCost;
  double? discount;
  bool? isCod = false;
  int? orderStatus = 0;
  int? createdDate = 0;
  List<CartModel>? cartItemList = List.empty(growable: true);

  OrderModel({
    this.userId,
    this.restaurantId,
    this.userName,
    this.userPhone,
    this.shippingAddress,
    this.comment,
    this.orderNumber,
    this.totalPayment,
    this.finalPayment,
    this.shippingCost,
    this.discount,
    this.isCod,
    this.orderStatus,
    this.createdDate,
    this.cartItemList,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    restaurantId = json['restaurantId'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    shippingAddress = json['shippingAddress'];
    comment = json['comment'];
    orderNumber = json['orderNumber'];
    totalPayment = double.parse(json['totalPayment'].toString());
    finalPayment = double.parse(json['finalPayment'].toString());
    shippingCost = double.parse(json['shippingCost'].toString());
    discount = double.parse(json['discount'].toString());
    isCod = json['isCod'] as bool;
    orderStatus = int.parse(json['orderStatus'].toString());
    createdDate = int.parse(json['createdDate'].toString());
    if (json['cartItemList'] != null) {
      json['cartItemList'].forEach((v) {
        cartItemList!.add(CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['restaurantId'] = this.restaurantId;
    data['userPhone'] = this.userPhone;
    data['userName'] = this.userName;
    data['shippingAddress'] = this.shippingAddress;
    data['comment'] = this.comment;
    data['orderNumber'] = this.orderNumber;
    data['totalPayment'] = this.totalPayment;
    data['finalPayment'] = this.finalPayment;
    data['shippingCost'] = this.shippingCost;
    data['discount'] = this.discount;
    data['isCod'] = this.isCod;
    data['orderStatus'] = this.orderStatus;
    data['cartItemList'] = this.cartItemList!.map((e) => e.toJson()).toList();
    data['createdDate'] = this.createdDate;
    return data;
  }
}
