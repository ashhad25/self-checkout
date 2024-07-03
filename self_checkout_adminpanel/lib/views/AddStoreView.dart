import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:self_checkout_adminpanel/api_service.dart';

class AddStoreView extends StatelessWidget {
  const AddStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Store'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AddStoreForm(),
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ExampleResponses(),
            ),
          ),
        ],
      ),
    );
  }
}

class AddStoreForm extends StatefulWidget {
  @override
  _AddStoreFormState createState() => _AddStoreFormState();
}

class _AddStoreFormState extends State<AddStoreForm> {
  final _formKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController();
  final _latlngController = TextEditingController();
  final _getApiController = TextEditingController();
  final _postApiController = TextEditingController();
  // final _addedByController = TextEditingController(text: '0');

  @override
  void dispose() {
    _storeNameController.dispose();
    _latlngController.dispose();
    _getApiController.dispose();
    _postApiController.dispose();
    // _addedByController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final formData = {
        "storename": _storeNameController.text,
        "latlng": _latlngController.text,
        "getapi": _getApiController.text,
        "postapi": _postApiController.text,
        "addedby": "0",
      };
      print("Form Data: $formData");
      try {
        dynamic addStoreResult = await ApiService().addStore(formData);
        log('result: $addStoreResult');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${addStoreResult['msg']}')));
        _storeNameController.text = "";
        _latlngController.text = "";
        _getApiController.text = "";
        _postApiController.text = "";
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
      // Here you can send the form data to your backend or perform any action you need
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _storeNameController,
            decoration: InputDecoration(labelText: 'Store Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter store name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _latlngController,
            decoration: InputDecoration(labelText: 'Latitude, Longitude'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter latitude and longitude';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _getApiController,
            decoration: InputDecoration(labelText: 'GET API URL'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter GET API URL';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _postApiController,
            decoration: InputDecoration(labelText: 'POST API URL'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter POST API URL';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Add Store'),
          ),
        ],
      ),
    );
  }
}

class ExampleResponses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: ExpansionTile(
              title: const Text('GET API Example Response',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                Image.network(
                    'https://raw.githubusercontent.com/ckkashi/self_checkout_adminpanel/master/get%20api%20res.png',
                    fit: BoxFit.cover),
              ],
            ),
          ),
          Card(
            child: ExpansionTile(
              title: const Text('POST API Example Response',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                Image.network(
                    'https://raw.githubusercontent.com/ckkashi/self_checkout_adminpanel/master/post%20api%20res.png',
                    fit: BoxFit.cover),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
