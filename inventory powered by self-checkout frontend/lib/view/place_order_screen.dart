import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_inventory_2_frontend/view/place_order_child/cart_product_screen.dart';
import 'package:sql_inventory_2_frontend/view/place_order_child/search_product_screen.dart';
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SearchProductScreen(),
          ),
          const Expanded(
            flex: 3,
            child: CartProductScreen(),
          )
        ],
      ),
    );
  }
}
