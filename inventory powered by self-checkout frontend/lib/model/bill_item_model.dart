class Billitems {
  int? productId;
  String? name;
  int? quantity;
  String? price;

  Billitems({this.productId, this.name, this.quantity, this.price});

  Billitems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}
