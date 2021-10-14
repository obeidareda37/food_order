class AddonModel {
  late String name;
  late double price = 0;

  AddonModel({required this.name, required this.price});

  AddonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = double.parse(json['price'].toString());
  }

  toJson() {
    final data = Map<String, dynamic>();
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
