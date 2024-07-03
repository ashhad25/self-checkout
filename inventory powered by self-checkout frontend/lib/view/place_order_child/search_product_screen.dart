import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_inventory_2_frontend/model/cart_model.dart';
import 'package:sql_inventory_2_frontend/model/product_model.dart';
import 'package:sql_inventory_2_frontend/view_model/place_order_view_model.dart';
import 'package:sql_inventory_2_frontend/view_model/product_view_model.dart';

class SearchProductScreen extends StatefulWidget {
  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productViewModelController =
        Provider.of<ProductViewModel>(context, listen: false);
    final placeOrderViewModel =
        Provider.of<PlaceOrderViewModel>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                onChanged: (value) {
                  placeOrderViewModel.setUserId(int.parse(value));
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter user id',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: TextField(
                controller: searchText,
                onChanged: (value) {
                  placeOrderViewModel.changeSearchValue(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter product id',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 8,
              child: Consumer<PlaceOrderViewModel>(
                  builder: (context, value, child) {
                return ListView.builder(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: productViewModelController.productList.length,
                  itemBuilder: (context, index) {
                    final data = productViewModelController.productList[index];
                    String search = value.getSearchFieldText;
                    if (search.isEmpty) {
                      return ListTile(
                        onTap: () => itemClick(
                            value, productViewModelController, index, data),
                        title: Text(data.name.toString()),
                        subtitle: Text("${data.price} RS"),
                        leading: Text(data.id.toString()),
                      );
                    } else if (data.id
                        .toString()
                        .toLowerCase()
                        .contains(search.toLowerCase())) {
                      return ListTile(
                        onTap: () => () => itemClick(
                            value, productViewModelController, index, data),
                        title: Text(data.name.toString()),
                        subtitle: Text("${data.price} RS"),
                        leading: Text(data.id.toString()),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  itemClick(
      PlaceOrderViewModel value,
      ProductViewModel productViewModelController,
      int index,
      ProductModel data) {
    {
      if (productViewModelController.productList[index].quantity! > 0) {
        Products prd = Products.fromJson({"productId": data.id, "quantity": 1});
        if (!value.getCartProduct!.contains(prd)) {
          value.addProductToCart(prd);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Item already exist in cart\nso we increased the quantity')));
        }
        print(value.getCartProduct!);
        productViewModelController.productList[index].quantity =
            productViewModelController.productList[index].quantity! - 1;
        value.copyCartList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product quantity is end')));
      }
      // value.calculateTotal(productViewModelController.productList);
    }
  }
}
