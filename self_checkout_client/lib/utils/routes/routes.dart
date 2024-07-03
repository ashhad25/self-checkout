import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:self_checkout_client/model/history_model.dart';
import 'package:self_checkout_client/model/product_model.dart';
import 'package:self_checkout_client/model/store_model.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/view/auth_options_view.dart';
import 'package:self_checkout_client/view/checkout_view.dart';
import 'package:self_checkout_client/view/dashboard_user_view.dart';
import 'package:self_checkout_client/view/history_detail.dart';
import 'package:self_checkout_client/view/login_view.dart';
import 'package:self_checkout_client/view/place_order_view.dart';
import 'package:self_checkout_client/view/product_detail_view.dart';
import 'package:self_checkout_client/view/register_view.dart';
import 'package:self_checkout_client/view/scanner/ScannerView.dart';
import 'package:self_checkout_client/view/select_store_view.dart';
import 'package:self_checkout_client/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutesName.splashView:
        return PageTransition(
          child: const SplashView(),
          type: PageTransitionType.fade,
        );
      case RoutesName.authOptionsView:
        return PageTransition(
            child: const AuthOptionsView(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500));
      case RoutesName.loginView:
        return PageTransition(
            child: LoginView(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500));
      case RoutesName.registerView:
        return PageTransition(
            child: RegisterView(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 500));
      case RoutesName.dashboardUserView:
        return PageTransition(
            child: const DashboardUserView(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 500));
      case RoutesName.selectStoreView:
        return PageTransition(
            child: const SelectStoreView(),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 500));
      case RoutesName.placeOrderView:
        return PageTransition(
            child: PlaceOrderView(
              args: args as StoreModel,
            ),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 500));
      case RoutesName.productDetailView:
        return PageTransition(
            child: ProductDetailView(
              args: args as ProductModel,
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300));
      case RoutesName.checkoutView:
        return PageTransition(
            child: CheckoutView(
              args: args,
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300));
      case RoutesName.scannerView:
        return PageTransition(
            child: const ScannerView(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300));
      case RoutesName.historyDetail:
        return PageTransition(
            child: HistoryDetail(data: args as HistoryModel),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300));
      default:
        return PageTransition(
            child: const Scaffold(
              body: Center(
                child: Text('Undefined Route'),
              ),
            ),
            type: PageTransitionType.fade);
    }
  }
}
