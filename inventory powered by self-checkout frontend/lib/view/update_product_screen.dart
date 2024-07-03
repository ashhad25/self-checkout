import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sql_inventory_2_frontend/model/product_model.dart';
import 'package:sql_inventory_2_frontend/utils/url.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';

class UpdateProductScreen extends StatefulWidget {
  ProductModel product;
  UpdateProductScreen({required this.product});
  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  Dio dio = Dio();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name.toString();
    categoryController.text = widget.product.category.toString();
    priceController.text = widget.product.price.toString();
    barcodeController.text = widget.product.barcode.toString();
    quantityController.text = widget.product.quantity.toString();
  }

  Future<void> updateProduct() async {
    try {
      String url =
          '${base_backend_url}products/${widget.product.id.toString()}';
      FormData formData = FormData.fromMap({
        'name': nameController.text,
        'category': categoryController.text,
        'price': priceController.text,
        'barcode': barcodeController.text,
        'quantity': quantityController.text,
      });
      // print(formData.fields);
      Response res = await dio.put(url, data: formData);
      if (res.statusCode == 200) {
        print(res);
        Navigator.pop(context);
        final productViewModel =
            Provider.of<ProductViewModel>(context, listen: false);
        productViewModel.productList.clear();
        productViewModel.fetchProducts();
      }

      // Product updated successfully, you can navigate to another screen or show a success message
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error updating product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: categoryController,
                decoration:
                    const InputDecoration(labelText: 'Product Category'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: barcodeController,
                decoration: const InputDecoration(labelText: 'Barcode'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // ElevatedButton(
              //   onPressed: pickImage,
              //   child: const Text('Pick Image'),
              // ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: updateProduct,
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
