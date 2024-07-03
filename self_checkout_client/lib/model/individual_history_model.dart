class IndividualHistoryModel {
  String? orderid;
  String? userid;
  String? storeid;
  String? storename;
  String? totalprice;
  String? createdAt;
  String? id;
  String? barcode;
  String? name;
  String? category;
  String? photo;
  String? price;
  String? quantity;

  IndividualHistoryModel(
      {this.orderid,
      this.userid,
      this.storeid,
      this.storename,
      this.totalprice,
      this.createdAt,
      this.id,
      this.barcode,
      this.name,
      this.category,
      this.photo,
      this.price,
      this.quantity});

  IndividualHistoryModel.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    userid = json['userid'];
    storeid = json['storeid'];
    storename = json['storename'];
    totalprice = json['totalprice'];
    createdAt = json['createdAt'];
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
    data['orderid'] = this.orderid;
    data['userid'] = this.userid;
    data['storeid'] = this.storeid;
    data['storename'] = this.storename;
    data['totalprice'] = this.totalprice;
    data['createdAt'] = this.createdAt;
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
