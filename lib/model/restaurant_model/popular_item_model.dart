class PopularItemModel {
  String? foodId;
  String? name;
  String? menuId;
  String? image;

  PopularItemModel({
    this.foodId,
    this.name,
    this.menuId,
    this.image,
  });

  PopularItemModel.fromJson(Map<String, dynamic> json) {
    foodId = json['food_id'] ?? '';
    name = json['name'] ?? '';
    menuId = json['menu_id'] ?? '';
    image = json['image'] ?? '';
  }

  toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['food_id'] = this.foodId;
    data['menu_id'] = this.menuId;
    data['image'] = this.image;

    return data;
  }
}
