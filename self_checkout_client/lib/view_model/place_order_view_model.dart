import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/model/cart_model.dart';
import 'package:self_checkout_client/model/history_model.dart';
import 'package:self_checkout_client/model/product_model.dart';
import 'package:self_checkout_client/model/store_model.dart';
import 'package:self_checkout_client/repository/history_repo.dart';
import 'package:self_checkout_client/repository/order_repository.dart';
import 'package:self_checkout_client/repository/store_repository.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view_model/dashboard_user_view_model.dart';
import 'package:self_checkout_client/view_model/select_store_view_model.dart';
import 'package:sizer/sizer.dart';

class PlaceOrderViewModel extends ChangeNotifier {
  final _orderRepo = OrderRepository();
  final _historyRepo = HistoryRepository();

  double _total = 0;
  double get total => _total;

  emptyTotal() {
    _total = 0;
  }

  calculateTotal() {
    emptyTotal();
    cartItemsMap.forEach((key, value) {
      ProductModel item = productsMap[key]!;
      _total += double.parse(item.price.toString()) *
          double.parse(value.quantity!.toString());
    });
  }

  bool _isLoading = false;
  toggleLoading(bool val) {
    _isLoading = val;
    // notifyListeners();
  }

  bool get loading => _isLoading;

  final Map<String, ProductModel> _productsMap = {};
  Map<String, ProductModel> get productsMap => _productsMap;

  final _cart = CartModel();
  CartModel get cart => _cart;
  addFinalProductListToCart(List<Products> items) {
    _cart.products = items;
    notifyListeners();
  }

  assignUserIdToCartModel(String id) {
    _cart.userId = id;
  }

  Map<String, Products> cartItemsMap = Map<String, Products>();
  addItemToCart(BuildContext context, String barcode, dynamic productId,
      dynamic quantity) {
    if (!checkItemExist(context, barcode)) {
      cartItemsMap[barcode] =
          Products(productId: int.parse(productId), quantity: quantity);
      Navigator.pop(context);
    } else {
      print("else running");
      Utils.itemExistDialog(context, barcode);
    }
    notifyListeners();
    calculateTotal();
  }

  increaseQuantity(String barcode) {
    cartItemsMap[barcode]!.quantity = cartItemsMap[barcode]!.quantity! + 1;
    notifyListeners();
    calculateTotal();
  }

  decreaseQuantity(String barcode) {
    if (cartItemsMap[barcode]!.quantity! > 1) {
      cartItemsMap[barcode]!.quantity = cartItemsMap[barcode]!.quantity! - 1;
    } else {
      cartItemsMap.remove(barcode);
    }
    notifyListeners();
    calculateTotal();
  }

  bool checkItemExist(BuildContext context, String barcode) {
    if (cartItemsMap[barcode] != null) {
      if (kDebugMode) {
        print("item exist $barcode");
      }
      return true;
    } else {
      print("item not exist $barcode");
      return false;
    }
  }

  clearData() {
    cartItemsMap.clear();
    _productsMap.clear();
  }

  Future<void> getStoreProducts(BuildContext context, String url) async {
    if (_productsMap.isEmpty) {
      toggleLoading(true);
      _orderRepo.getStoreProducts(url, {}).then((value) {
        if (kDebugMode) {
          print(value);
        }
        if (value == null) {
          somethingWentWrong(context);
        }
        for (var product in value) {
          _productsMap[product!['barcode'].toString()] =
              ProductModel.fromJson(product);
        }
        toggleLoading(false);
        notifyListeners();
        if (kDebugMode) {
          print(_productsMap);
        }
      }, onError: (error) {
        if (kDebugMode) {
          print(error);
        }
        somethingWentWrong(context);
      });
    }
  }

  void somethingWentWrong(BuildContext context) {
    Navigator.pushReplacementNamed(context, RoutesName.selectStoreView);
    Navigator.pop(context);
    Utils.displayFlushbar(context, 'Error',
        'Something went wrong while fetching data', Colors.red);
  }

  Future<void> placeOrder(
      String url, dynamic data, BuildContext context) async {
    if (kDebugMode) {
      print("${url} ${data}");
    }
    if (data.isNotEmpty) {
      //needs to uncomment
      await _orderRepo.placeOrder(data, url).then((value) {
        if (kDebugMode) {
          print(value);
        }
        SelectStoreViewModel storeController =
            Provider.of<SelectStoreViewModel>(context, listen: false);
        DashboardUserViewModel userController =
            Provider.of<DashboardUserViewModel>(context, listen: false);
        StoreModel selectedStore = storeController.getSelectedStore;
        // dynamic userId = data["userId"].toString();
        // print('${selectedStore} $userId');
        // dynamic orderId = value['orderId'].toString();
        dynamic historyData = {
          "orderid": value['orderId'].toString(),
          "userid": userController.user.sId.toString(),
          "storeid": selectedStore.sId.toString(),
          "storename": selectedStore.storename.toString(),
          "totalprice": total.toString(),
          "items": []
        };

        print(cartItemsMap.length);
        dynamic prod = cartItemsMap.keys.toList();
        // print(prod[index]);
        HistoryModel tempdata = HistoryModel(
            items: [],
            orderid: historyData['orderid'],
            storeid: historyData['storeid'],
            storename: historyData['storename'],
            totalprice: historyData['totalprice'],
            userid: historyData['userid'],
            createdAt: '0000-00-00T00:00:00.000+00:00');

        for (var index = 0; index < cartItemsMap.length; index++) {
          Products cartProduct = cartItemsMap[prod[index]]!;
          ProductModel prdData = productsMap[prod[index].toString()]!;
          dynamic historyItem = {
            "id": cartProduct.productId.toString(),
            "barcode": prdData.barcode.toString(),
            "name": prdData.name.toString(),
            "category": prdData.category.toString(),
            "photo": prdData.photo.toString(),
            "price": prdData.price.toString(),
            "quantity": cartProduct.quantity.toString()
          };
          print(historyItem);
          historyData["items"].add(Items.fromJson(historyItem).toJson());
          tempdata.items!.add(Items.fromJson(historyItem));
        }
        print(historyData);
        print(tempdata.items);
        userController.addOrderToHistory(historyData);

        // print(tempdata.toJson());
        _historyRepo
            .addUserHistory(
                jsonEncode(historyData), Constants.stores_route_add_history)
            .then((historyValue) {
          if (kDebugMode) {
            print(historyValue);
          }
        });
        // notifyListeners();
        Navigator.pushReplacementNamed(context, RoutesName.checkoutView,
            arguments: value);
        Utils.displayFlushbar(
            context, "Successfull", value['msg'], AppColors.primaryColor);
      }, onError: (error) {
        if (kDebugMode) {
          print(error);
        }
      });
    }
  }
}
