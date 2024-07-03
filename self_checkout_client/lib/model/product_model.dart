class ProductModel {
  int? id;
  String? name;
  String? category;
  String? price;
  String? barcode;
  int? quantity;
  String? photo;

  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.barcode,
      this.quantity,
      this.photo,
      this.category});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    barcode = json['barcode'];
    quantity = json['quantity'];
    photo = json['photo'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['barcode'] = this.barcode;
    data['quantity'] = this.quantity;
    data['photo'] = this.photo;
    data['category'] = this.category;
    return data;
  }
}
