import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/model/product_model.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/round_button.dart';
import 'package:self_checkout_client/res/components/row_data.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view_model/dashboard_user_view_model.dart';
import 'package:self_checkout_client/view_model/place_order_view_model.dart';
import 'package:sizer/sizer.dart';

class ProductDetailView extends StatefulWidget {
  ProductModel args;
  ProductDetailView({super.key, required this.args});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final historyModel =
    //     Provider.of<DashboardUserViewModel>(context, listen: false);
    // historyModel.recommendProducts(widget.args.category.toString());
    // if (mounted) {
    //   Timer(Duration(seconds: 2), () {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return Dialog(
    //           child: Container(
    //             child: Center(
    //               child: Text('data'),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final historyModel =
        Provider.of<DashboardUserViewModel>(context, listen: false);
    final recommendations =
        historyModel.recommendProducts(widget.args.category.toString());
    if (mounted && recommendations.length > 0) {
      Timer(const Duration(seconds: 2), () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.3))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Recommendations',
                        style: textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkPrimaryColor),
                      ),
                      Text(
                        'based on past data',
                        style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTextColor.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: recommendations.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 6.0),
                              child: Container(
                                width: double.infinity,
                                height: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 2,
                                          spreadRadius: 0)
                                    ]),
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          // color: Colors.red,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            child: Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    '${Constants.local_url}${recommendations[index].photo.toString()}')),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          // color: Colors.green,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Name: ${recommendations[index].name.toString()}',
                                                style: textTheme.bodySmall,
                                              ),
                                              Text(
                                                'Quantity: ${recommendations[index].quantity.toString()}x',
                                                style: textTheme.bodySmall,
                                              ),
                                              Text(
                                                'Store: ${recommendations[index].storename.toString()}',
                                                style: textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            );
          },
        );
      });
    }
    return SafeArea(
      child: Scaffold(
        appBar: Utils.backButtonAppbar(context, 'Product Detail', () {
          Navigator.pop(context);
        }),
        backgroundColor: AppColors.lightPrimaryColor,
        body: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: AppColors.textIconColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              topRight: Radius.circular(10.w),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 3.w),
                child: Container(
                  width: 100.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(10.w),
                    image: DecorationImage(
                        image: NetworkImage(
                            '${Constants.local_url}${widget.args.photo.toString()}'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.w, horizontal: 10.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RowData(
                            name: 'Name', value: widget.args.name.toString()),
                        RowData(
                            name: 'Code',
                            value: widget.args.barcode.toString()),
                        RowData(
                            name: 'Quantity',
                            value: '${widget.args.quantity.toString()}x'),
                        RowData(
                            name: 'Category',
                            value: '${widget.args.category.toString()}'),
                        RowData(
                            name: 'Price',
                            value: '${widget.args.price.toString()} RS'),
                      ],
                    ),
                  ),
                ),
              ),
              Consumer<PlaceOrderViewModel>(builder: (context, value, child) {
                return Expanded(
                    flex: 1,
                    child: SizedBox(
                      // color: Colors.red,
                      child: Center(
                        child: ButtonRound(
                          title: value.checkItemExist(
                                  context, widget.args.barcode!)
                              ? 'Item already exist'
                              : 'Add to cart',
                          onPress: () {
                            value.addItemToCart(
                                context,
                                widget.args.barcode.toString(),
                                widget.args.id.toString(),
                                1);
                            // Navigator.pop(context);
                            // Navigator.pushNamed(
                            //     context, RoutesName.checkoutView);
                          },
                          borderRadius: BorderRadius.circular(2.8.w),
                          bgColor: AppColors.primaryColor,
                        ),
                      ),
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
