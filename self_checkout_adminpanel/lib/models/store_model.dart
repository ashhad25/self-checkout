class StoreModel {
  String? sId;
  String? storename;
  String? latlng;
  String? getapi;
  String? postapi;
  String? addedby;
  String? createdAt;
  String? updatedAt;

  StoreModel(
      {this.sId,
      this.storename,
      this.latlng,
      this.getapi,
      this.postapi,
      this.addedby,
      this.createdAt,
      this.updatedAt});

  StoreModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    storename = json['storename'];
    latlng = json['latlng'];
    getapi = json['getapi'];
    postapi = json['postapi'];
    addedby = json['addedby'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['storename'] = this.storename;
    data['latlng'] = this.latlng;
    data['getapi'] = this.getapi;
    data['postapi'] = this.postapi;
    data['addedby'] = this.addedby;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
