import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_inventory_2_frontend/model/product_model.dart';
import 'package:sql_inventory_2_frontend/utils/url.dart';
import 'package:sql_inventory_2_frontend/view_model/place_order_view_model.dart';
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';

class CartProductScreen extends StatelessWidget {
  const CartProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModelController =
        Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
      body: Consumer<PlaceOrderViewModel?>(
        builder: (context, value, child) {
          final newCart = value!.copyCart;
          if (value.copyCart!.isEmpty) {
            return const Center(
              child: Text(
                'No items found in cart.',
                style: TextStyle(color: Colors.black),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: newCart!.length,
                    itemBuilder: (context, index) {
                      ProductModel? productDetail;
                      for (var product
                          in productViewModelController.productList) {
                        if (product.id == newCart[index].productId) {
                          productDetail = product;
                        }
                      }
                      return Card(
                        elevation: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                leading: Image.network(
                                  '${base_url}${productDetail!.photo}',
                                  width: 120,
                                  height: 120,
                                ),
                                title: Text(productDetail.name.toString()),
                                subtitle: Text(productDetail.price.toString()),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            value.incrementQty(index);
                                          },
                                          icon: const Icon(Icons.add)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        newCart[index].quantity.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            value.decrementQty(index);
                                          },
                                          icon: const Icon(Icons.remove)),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, bottom: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Total: ${value.calculateTotal(productViewModelController.productList)}',
                              style: const TextStyle(
                                  fontSize: 40, color: Colors.red),
                            ),
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  final productViewModel =
                                      Provider.of<ProductViewModel>(context,
                                          listen: false);
                                  productViewModel.placeOrder(
                                      value.getCart, context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                  child: Text('Checkout',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }
}
