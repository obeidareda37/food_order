import 'package:fastfood_app/model/restaurant_model/addon_model.dart';
import 'package:fastfood_app/model/restaurant_model/size_model.dart';

class FoodModel {
  late String description;
  late String id;
  late String name;
  late String image;
  late double price;
  late List<SizeModel> size = List<SizeModel>.empty(growable: true);
  late List<AddonModel> addon = List<AddonModel>.empty(growable: true);

  FoodModel({
    required this.description,
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    required this.addon,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = double.parse(json['price'].toString());
    id = json['id'];
    image = json['image'];
    description = json['description'];
    if (json['addon'] != null) {
      addon = List<AddonModel>.empty(growable: true);
      json['addon'].forEach((v) {
        addon.add(AddonModel.fromJson(v));
      });
    }
    if (json['size'] != null) {
      size = List<SizeModel>.empty(growable: true);
      json['size'].forEach((v) {
        size.add(SizeModel.fromJson(v));
      });
    }
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
    return data;
  }
}
