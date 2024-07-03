import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/model/cart_model.dart';
import 'package:self_checkout_client/model/product_model.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/bill_row_data.dart';
import 'package:self_checkout_client/res/components/bill_row_header.dart';
import 'package:self_checkout_client/res/components/row_data.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view_model/place_order_view_model.dart';
import 'package:sizer/sizer.dart';

class CheckoutView extends StatefulWidget {
  final args;
  const CheckoutView({super.key, required this.args});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    PlaceOrderViewModel placeOrderViewModel =
        Provider.of<PlaceOrderViewModel>(context, listen: false);
    print(widget.args);
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.lightPrimaryColor,
          appBar: Utils.backButtonAppbar(context, 'Checkout', () {
            placeOrderViewModel.clearData();
            Navigator.pop(context);
          }),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RowData(
                    name: 'Order ID', value: widget.args['orderId'].toString()),
                Divider(),
                BillRowHeader(
                  name: 'Product',
                  qty: 'Quantity',
                  price: 'Total',
                ),
                Divider(),
                Expanded(
                    child: ListView.builder(
                  itemCount: placeOrderViewModel.cartItemsMap.length,
                  itemBuilder: (context, index) {
                    dynamic prod =
                        placeOrderViewModel.cartItemsMap.keys.toList();
                    // print(prod[index]);

                    Products cartProduct =
                        placeOrderViewModel.cartItemsMap[prod[index]]!;
                    ProductModel prdData = placeOrderViewModel
                        .productsMap[prod[index].toString()]!;
                    // return Container();
                    dynamic data = {
                      "name": prdData.name,
                      "category": prdData.category,
                      "barcode": prdData.barcode,
                      "quantity": cartProduct.quantity,
                      "photo": "${prdData.photo}",
                      "price": prdData.price,
                    };
                    return BillRowData(
                        name: data['name'].toString(),
                        qty: data['quantity'].toString(),
                        price: data['price'].toString());
                  },
                )),
                Divider(),
                RowData(
                    name: 'Total Ammount',
                    value: 'RS ${placeOrderViewModel.total.toString()}'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'go to cash counter'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )),
    );
  }
}
