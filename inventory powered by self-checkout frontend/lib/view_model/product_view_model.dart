// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_inventory_2_frontend/model/bill_item_model.dart';
import 'package:sql_inventory_2_frontend/model/cart_model.dart';
import 'package:sql_inventory_2_frontend/model/product_model.dart';
import 'package:sql_inventory_2_frontend/utils/url.dart';
import 'package:sql_inventory_2_frontend/view/generate_bill_screen.dart';
import 'package:sql_inventory_2_frontend/view_model/place_order_view_model.dart';

class ProductViewModel extends ChangeNotifier {
  Dio dio = Dio();

  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  List<Map<String, dynamic>> orderItems = [];

  Future<void> placeOrder(CartModel data, BuildContext context) async {
    CartModel cart = CartModel(userId: 0, products: []);
    try {
      String url = backend_order_endpoint;
      Response res = await dio.post(url, data: json.encode(data));
      print(res);
      if (res.statusCode == 200) {
        final controller =
            Provider.of<PlaceOrderViewModel>(context, listen: false);
        controller.copyCart = [];
        controller.cart.products = [];
        controller.cart.userId = 0;
        notifyListeners();
        Response billResponse =
            await dio.get(backend_billing_endpoint(res.data['orderId']));
        if (billResponse.statusCode == 200) {
          // print(billResponse.data);
          List<List<dynamic>> dataTable = [];
          for (var el in billResponse.data['items']) {
            Billitems item = Billitems.fromJson(el);
            double itemTotal =
                item.quantity! * double.parse(item.price.toString());
            List temp = [
              item.name,
              item.quantity,
              "RS ${double.parse(item.price.toString())}",
              itemTotal
            ];
            dataTable.add(temp);
          }
          // Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => GenerateBillScreen(
                        orderId: billResponse.data['orderId'].toString(),
                        dataList: dataTable.toList(),
                        total: billResponse.data['totalAmount'].toString(),
                      ))));
        }

        // Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res.data['msg'])));
      }
      // Order placed successfully, you can navigate to another screen or show a success message
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error placing order: $error');
    }
  }

  void addProductToOrder(int productId, int quantity) {
    orderItems.add({
      'productId': productId,
      'quantity': quantity,
    });
    notifyListeners();
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      String url = backend_product_endpoint;
      final response = await dio.get(url);
      print(response);
      for (var element in response.data) {
        _productList.add(ProductModel.fromJson(element));
      }
      notifyListeners();
      return productList;
    } catch (error) {
      print('Error fetching products: $error');
      return productList;
    }
  }
}
