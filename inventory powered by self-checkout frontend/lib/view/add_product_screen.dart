import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sql_inventory_2_frontend/utils/url.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Dio dio = Dio();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  XFile? selectedImage;
  Uint8List webImage = Uint8List(10);

  Future<void> addProduct() async {
    try {
      String url = '${base_backend_url}products';
      if (kIsWeb) {
        // var f = await selectedImage!.readAsBytes();
        // webImage = f;
        FormData formData = FormData.fromMap({
          'name': nameController.text,
          'category': categoryController.text,
          'price': priceController.text,
          'barcode': barcodeController.text,
          'quantity': quantityController.text,
          'photo': MultipartFile.fromBytes(webImage, filename: "image.jpg"),
        });
        Response res = await dio.post(url, data: formData);
        if (res.statusCode == 200) {
          print(res);
          Navigator.pop(context);
          final productViewModel =
              Provider.of<ProductViewModel>(context, listen: false);
          productViewModel.productList.clear();
          productViewModel.fetchProducts();
        }
      } else {
        FormData formData = FormData.fromMap({
          'name': nameController.text,
          'category': categoryController.text,
          'price': priceController.text,
          'barcode': barcodeController.text,
          'quantity': quantityController.text,
          'photo': await MultipartFile.fromFile(selectedImage!.path,
              filename: selectedImage!.name),
        });
        Response res = await dio.post(url, data: formData);
        if (res.statusCode == 200) {
          print(res);
          Navigator.pop(context);
          final productViewModel =
              Provider.of<ProductViewModel>(context, listen: false);
          productViewModel.productList.clear();
          productViewModel.fetchProducts();
        }
      }
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error adding product: $error');
    }
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = XFile(image.path);
      selectedImage = imageTemp;
      var f = await selectedImage!.readAsBytes();
      webImage = f;
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
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
              const SizedBox(
                height: 10,
              ),
              selectedImage != null && !kIsWeb
                  ? Image.file(File(selectedImage!.path))
                  : Container(),
              selectedImage != null && kIsWeb
                  ? Image.memory(webImage)
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: addProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
