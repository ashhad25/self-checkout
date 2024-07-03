import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:self_checkout_client/utils/routes/routes.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view/test.dart';
import 'package:self_checkout_client/view_model/auth_view_model.dart';
import 'package:self_checkout_client/view_model/dashboard_user_view_model.dart';
import 'package:self_checkout_client/view_model/login_view_model.dart';
import 'package:self_checkout_client/view_model/place_order_view_model.dart';
import 'package:self_checkout_client/view_model/register_view_model.dart';
import 'package:self_checkout_client/view_model/select_store_view_model.dart';
import './res/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardUserViewModel()),
        ChangeNotifierProvider(create: (_) => SelectStoreViewModel()),
        ChangeNotifierProvider(create: (_) => PlaceOrderViewModel()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: Constants.app_title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: AppColors.primaryColor,
              primaryColorLight: AppColors.lightPrimaryColor,
              primaryColorDark: AppColors.darkPrimaryColor,
              fontFamily: 'Ubuntu',
              textTheme: Utils.appTextTheme()),
          // home: const Test(),
          initialRoute: RoutesName.splashView,
          onGenerateRoute: Routes.generateRoute,
        );
      }),
    );
  }
}
