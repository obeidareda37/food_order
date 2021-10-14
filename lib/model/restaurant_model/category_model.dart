import 'package:fastfood_app/model/restaurant_model/food_model.dart';

class CategoryModel {
  late String key;
  late String name;
  late String image;
  late List<FoodModel> foods = List<FoodModel>.empty(growable: true);

  CategoryModel({
    required this.name,
    required this.image,
    required this.foods,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    if (json['foods'] != null) {
      foods = List<FoodModel>.empty(growable: true);
      json['foods'].forEach((v) {
        foods.add(FoodModel.fromJson(v));
      });
    }
  }

  toJson() {
    final data = Map<String, dynamic>();
    data['name'] = name;
    data['image'] = image;
    data['size'] = foods.map((e) => e.toJson()).toList();
    return data;
  }
}
