import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sql_inventory_2_frontend/model/product_model.dart';
import 'package:sql_inventory_2_frontend/utils/url.dart';
import 'package:sql_inventory_2_frontend/view/add_product_screen.dart';
// import 'package:sql_inventory_2_frontend/view/generate_bill_screen.dart';
import 'package:sql_inventory_2_frontend/view/place_order_screen.dart';
import 'package:sql_inventory_2_frontend/view/update_product_screen.dart';
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    return FutureBuilder(
        future: productViewModel.fetchProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Found some error'),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Product Inventory'),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductScreen())),
                      icon: const Icon(Icons.add)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlaceOrderScreen())),
                      icon: const Icon(Icons.shopping_cart_rounded)),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Consumer<ProductViewModel>(
                    builder: (context, value, child) {
                  // value.fetchProducts();
                  return SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Barcode')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Photo')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: value.productList.map((product) {
                        return DataRow(
                            onLongPress: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProductScreen(product: product))),
                            cells: [
                              DataCell(Text(product.id.toString())),
                              DataCell(Text(product.name.toString())),
                              DataCell(Text(product.category.toString())),
                              DataCell(Text('${product.price.toString()} RS')),
                              DataCell(Text(product.barcode.toString())),
                              DataCell(Text(product.quantity.toString())),
                              DataCell(
                                product.photo != null
                                    ? Image.network(
                                        '${base_url}${product.photo}',
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Text('Loading Error'),
                                      )
                                    : const Text('No Photo'),
                              ),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        final Response res = await dio.delete(
                                            '${base_backend_url}products/${product.id}');
                                        if (res.statusCode == 200) {
                                          value.productList.clear();
                                          value.fetchProducts();
                                        }
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              )),
                            ]);
                      }).toList(),
                    ),
                  );
                }),
              ),
            );
          }
        });
  }
}
