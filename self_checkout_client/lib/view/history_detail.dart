import 'package:flutter/material.dart';
import 'package:self_checkout_client/model/history_model.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/bill_row_data.dart';
import 'package:self_checkout_client/res/components/bill_row_header.dart';
import 'package:self_checkout_client/res/components/row_data.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:self_checkout_client/utils/utils.dart';

class HistoryDetail extends StatelessWidget {
  final HistoryModel data;
  const HistoryDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightPrimaryColor,
        appBar: Utils.backButtonAppbar(context, 'History detail', () {
          Navigator.pop(context);
        }),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RowData(name: 'Order ID', value: data.orderid.toString()),
              Divider(),
              BillRowHeader(
                name: 'Product',
                qty: 'Quantity',
                price: 'Total',
              ),
              Divider(),
              Expanded(
                  child: ListView.builder(
                itemCount: data.items!.length,
                itemBuilder: (context, index) {
                  // print(prod[index]);
                  // return Container();
                  dynamic itemData = {
                    "name": data.items![index].name,
                    "category": data.items![index].category,
                    "barcode": data.items![index].barcode,
                    "quantity": data.items![index].quantity,
                    "photo":
                        "${Constants.local_url}${data.items![index].photo}",
                    "price": data.items![index].price,
                  };
                  return BillRowData(
                      name: itemData['name'].toString(),
                      qty: itemData['quantity'].toString(),
                      price: itemData['price'].toString());
                },
              )),
              Divider(),
              RowData(
                  name: 'Total Ammount',
                  value: 'RS ${data.totalprice.toString()}'),
              SizedBox(
                height: 15,
              ),
              // Text(
              //   'go to cash counter'.toUpperCase(),
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
              //       color: AppColors.primaryTextColor,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
