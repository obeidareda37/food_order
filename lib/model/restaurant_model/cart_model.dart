import 'package:fastfood_app/model/restaurant_model/food_model.dart';

class CartModel extends FoodModel {
  int quantity = 0;
  String restaurantId;
  String userUid;

  CartModel({
    required this.quantity,
    required this.restaurantId,
    required this.userUid,
    description,
    id,
    name,
    image,
    size,
    price,
    addon,
  }) : super(
            id: id,
            name: name,
            image: image,
            description: description,
            price: price,
            addon: addon,
            size: size);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final food = FoodModel.fromJson(json);
    final quantity = json['quantity'];
    final restaurantId = json['restaurantId'];
    final userUid = json['userUid'];
    return CartModel(
        id: food.id,
        image: food.image,
        price: food.price,
        description: food.description,
        addon: food.addon,
        size: food.size,
        quantity: quantity,
        name: food.name,
        restaurantId: restaurantId,
        userUid: userUid);
  }

  toJson() {
    final data = Map<String, dynamic>();
    data['name'] = name;
    data['price'] = price;
    data['id'] = id;
    data['description'] = description;
    data['image'] = image;
    data['size'] = size.map((e) => e.toJson()).toList();
    data['addon'] = addon.map((e) => e.toJson()).toList();
    data['quantity'] = quantity;
    data['restaurantId'] = restaurantId;
    data['userUid'] = userUid;
    return data;
  }
}
