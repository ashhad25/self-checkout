import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_checkout_client/model/auth_model.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  Future<bool> saveUser(AuthModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<AuthModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');

    return AuthModel(token: token.toString());
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }

  Future chkUser(BuildContext context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    if (token != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.dashboardUserView,
        (route) => false,
      );
    }
  }
}
