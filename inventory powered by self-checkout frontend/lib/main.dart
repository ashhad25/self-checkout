import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_inventory_2_frontend/view/product_screen.dart';
import 'package:sql_inventory_2_frontend/view_model/generate_bill_view_model.dart';
import 'package:sql_inventory_2_frontend/view_model/place_order_view_model.dart';
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => PlaceOrderViewModel()),
        ChangeNotifierProvider(create: (context) => GenerateBillViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'XYZ Inventory',
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
        ),
        home: ProductScreen(),
      ),
    );
  }
}

//run on chrome line that ignore cors issue
// flutter run -d chrome --web-browser-flag "--disable-web-security"
