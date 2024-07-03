import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_checkout_client/model/auth_model.dart';
import 'package:self_checkout_client/repository/auth_repository.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view_model/auth_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _isLoading = false;
  toggleLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool get loading => _isLoading;

  Future<void> login(dynamic data, BuildContext context) async {
    toggleLoading(true);
    dynamic response = _authRepo.loginApi(data).then(
      (value) {
        toggleLoading(false);
        AuthViewModel().saveUser(AuthModel.fromJson(value));
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.dashboardUserView,
          (route) => false,
        );
        Future.delayed(Duration.zero, () {
          Utils.displayFlushbar(
              context, 'Success', value['msg'], AppColors.primaryColor);
        });
        if (kDebugMode) {
          print(value);
          var chk = AuthViewModel().getUser().then((value) {
            print(value.token);
          });
        }
      },
    ).onError((error, stackTrace) {
      toggleLoading(false);
      Utils.displayFlushbar(context, 'Error', error.toString(), Colors.red);
      if (kDebugMode) {
        print(error);
      }
    });
    // print(response);
  }
}
