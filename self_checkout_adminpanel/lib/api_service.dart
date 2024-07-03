import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:self_checkout_adminpanel/models/history.dart';
import 'package:self_checkout_adminpanel/models/store_model.dart';

class ApiService {
  static const String getHistoryUrl =
      'http://localhost:8000/api/historyRoute/getAllHistory';
  static const String addStoreUrl =
      'http://localhost:8000/api/storeRoute/addStore';
  static const String getAllStoreUrl =
      'http://localhost:8000/api/storeRoute/getStores';

  Future<List<History>> fetchOrders() async {
    final response = await http.get(Uri.parse('$getHistoryUrl'));

    if (response.statusCode == 200) {
      log(response.body);
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => History.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<StoreModel>> fetchStores() async {
    final response = await http.get(Uri.parse('$getAllStoreUrl'));

    if (response.statusCode == 200) {
      log(response.body);
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => StoreModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  dynamic addStore(formData) async {
    final response = await http.post(Uri.parse('$addStoreUrl'), body: formData);

    if (response.statusCode == 200) {
      log(response.body);
      dynamic body = json.decode(response.body);
      log(body['msg']);
      return body;
    } else {
      throw Exception('Failed to add store');
    }
  }
}
