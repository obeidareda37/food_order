class SizeModel {
  late String name;
  late double price = 0;

  SizeModel({required this.name, required this.price});

  SizeModel.fromJson(Map<String, dynamic> json) {
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
