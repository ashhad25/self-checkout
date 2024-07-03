import 'package:flutter/material.dart';
import 'package:sql_inventory_2_frontend/model/cart_model.dart';
import 'package:sql_inventory_2_frontend/model/product_model.dart';

class PlaceOrderViewModel extends ChangeNotifier {
  String searchFieldText = '';
  String get getSearchFieldText => searchFieldText;
  int total = 0;
  changeSearchValue(String val) {
    searchFieldText = val;
    notifyListeners();
  }

  late CartModel cart = CartModel(userId: 0, products: []);
  addProductToCart(Products prd) {
    cart.products!.add(prd);
    notifyListeners();
  }

  setUserId(int uid) {
    cart.userId = uid;
    notifyListeners();
  }

  List<Products>? get getCartProduct => cart.products;
  CartModel get getCart => cart;
  List<Products>? copyCart = [];
  copyCartList() {
    copyCart = getCartProduct;
  }

  incrementQty(int index) {
    copyCart![index].quantity = copyCart![index].quantity! + 1;
    notifyListeners();
  }

  decrementQty(int index) {
    if (copyCart![index].quantity! > 1) {
      copyCart![index].quantity = copyCart![index].quantity! - 1;
    } else {
      copyCart!.removeAt(index);
    }
    notifyListeners();
  }

  calculateTotal(List<ProductModel> product) {
    // print(product);
    double totall = 0;
    ProductModel? prodData;
    for (var element in product) {
      for (var cartItem in copyCart!) {
        if (cartItem.productId == element.id) {
          prodData = element;
          totall +=
              cartItem.quantity! * double.parse(prodData.price.toString());
        }
      }
    }
    return totall;
  }
}
