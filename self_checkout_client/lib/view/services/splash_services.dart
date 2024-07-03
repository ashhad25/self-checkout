import 'package:flutter/material.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';

class SplashServices {
  static Future<void> checkAuth(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, RoutesName.authOptionsView);
  }
}
