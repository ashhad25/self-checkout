class History {
  final String id;
  final String storeId;
  final String storeName;
  final String orderId;
  final String userId;
  final double totalPrice;
  final DateTime createdAt;

  History({
    required this.id,
    required this.storeId,
    required this.storeName,
    required this.orderId,
    required this.userId,
    required this.totalPrice,
    required this.createdAt,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['_id'],
      storeId: json['storeid'],
      storeName: json['storename'],
      orderId: json['orderid'],
      userId: json['userid'],
      totalPrice: double.parse(json['totalprice']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
