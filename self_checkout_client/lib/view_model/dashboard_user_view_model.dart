import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_checkout_client/model/history_model.dart';
import 'package:self_checkout_client/model/individual_history_model.dart';
import 'package:self_checkout_client/model/user_model.dart';
import 'package:self_checkout_client/repository/auth_repository.dart';
import 'package:self_checkout_client/repository/history_repo.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:self_checkout_client/view_model/auth_view_model.dart';

class DashboardUserViewModel extends ChangeNotifier {
  final _authRepo = AuthRepository();
  final _historyRepo = HistoryRepository();
  bool _isLoading = true;
  toggleLoading(bool val) {
    _isLoading = val;
    print(_isLoading);
    // notifyListeners();
  }

  bool get loading => _isLoading;

  UserModel user = UserModel();

  Future<void> getUser() async {
    toggleLoading(true);
    AuthViewModel().getUser().then((value) {
      dynamic response = _authRepo
          .getUserApi({'auth-token': value.token.toString()}).then((val) async {
        user = UserModel.fromJson(val);
        await getUserHistory(user.sId.toString());
        notifyListeners();
        toggleLoading(false);
        if (kDebugMode) {
          print({val});
          print({user});
        }
      }).onError((error, stackTrace) {
        toggleLoading(false);
        if (kDebugMode) {
          print({error});
          // print({user});
        }
      });
    });
  }

  List<HistoryModel> historyList = [];
  List<IndividualHistoryModel> individualHistoryList = [];

  addOrderToHistory(dynamic data) {
    HistoryModel currentData = HistoryModel.fromJson(data);
    historyList.add(currentData);
    notifyListeners();
    print(individualHistoryList.length);
  }

  Future<void> getUserHistory(String userid) async {
    print(userid);
    historyList.clear();
    individualHistoryList.clear();
    await _historyRepo.getUserHistory(
        '${Constants.stores_route_get_history}$userid', {}).then((value) {
      for (var element in value['history']) {
        // print({"history": element});
        // historyList.add(HistoryModel.fromJson(element));
        HistoryModel currentData = HistoryModel.fromJson(element);
        historyList.add(currentData);
        for (var element in currentData.items!) {
          IndividualHistoryModel currentRecord = IndividualHistoryModel(
              orderid: currentData.orderid,
              storeid: currentData.storeid,
              storename: currentData.storename,
              totalprice: currentData.totalprice,
              userid: currentData.userid,
              createdAt: currentData.createdAt,
              barcode: element.barcode,
              category: element.category,
              id: element.id,
              name: element.name,
              photo: element.photo,
              price: element.price,
              quantity: element.quantity);
          individualHistoryList.add(currentRecord);
        }
      }
      print(historyList);
      print(individualHistoryList.length);
    });
  }

  productExistInHistory(IndividualHistoryModel prd,
      List<IndividualHistoryModel> recommendations) {
    bool exist = false;
    for (var element in recommendations) {
      if (element.barcode == prd.barcode) {
        exist = true;
        break;
      }
    }
    return exist;
  }

  recommendProducts(String category) {
    print(category);
    List<IndividualHistoryModel> recommendationProducts = [];
    for (var currentElement in individualHistoryList) {
      if (currentElement.category!.contains(category) &&
          !(productExistInHistory(currentElement, recommendationProducts))) {
        recommendationProducts.add(currentElement);
        log("${currentElement.name} ${currentElement.barcode}");
      }
    }
    print(recommendationProducts);
    return recommendationProducts;
  }
}
