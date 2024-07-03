class HistoryModel {
  String? orderid;
  String? userid;
  String? storeid;
  String? storename;
  String? totalprice;
  String? createdAt;
  List<Items>? items;

  HistoryModel(
      {this.orderid,
      this.userid,
      this.storeid,
      this.storename,
      this.totalprice,
      this.createdAt,
      this.items});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    userid = json['userid'];
    storeid = json['storeid'];
    storename = json['storename'];
    totalprice = json['totalprice'];
    createdAt = json['createdAt'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['userid'] = this.userid;
    data['storeid'] = this.storeid;
    data['storename'] = this.storename;
    data['totalprice'] = this.totalprice;
    data['createdAt'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? barcode;
  String? name;
  String? category;
  String? photo;
  String? price;
  String? quantity;

  Items(
      {this.id,
      this.barcode,
      this.name,
      this.category,
      this.photo,
      this.price,
      this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    name = json['name'];
    category = json['category'];
    photo = json['photo'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barcode'] = this.barcode;
    data['name'] = this.name;
    data['category'] = this.category;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
