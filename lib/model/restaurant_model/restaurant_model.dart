class RestaurantModel {
  String? restaurantId;
  String? name;
  String? address;
  String? phone;
  String? paymentUrl;
  String? imageUrl;

  RestaurantModel({
    this.name,
    this.address,
    this.phone,
    this.paymentUrl,
    this.imageUrl,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    paymentUrl = json['paymentUrl'];
    imageUrl = json['imageUrl'];
  }

  toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['paymentUrl'] = this.paymentUrl;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
