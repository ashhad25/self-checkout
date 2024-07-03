// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/model/cart_model.dart';
import 'package:self_checkout_client/model/product_model.dart';
import 'package:self_checkout_client/model/store_model.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/item_product.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view_model/dashboard_user_view_model.dart';
import 'package:self_checkout_client/view_model/place_order_view_model.dart';
import 'package:self_checkout_client/view_model/select_store_view_model.dart';
import 'package:sizer/sizer.dart';

class PlaceOrderView extends StatefulWidget {
  StoreModel args;
  PlaceOrderView({super.key, required this.args});

  @override
  State<PlaceOrderView> createState() => _PlaceOrderViewState();
}

class _PlaceOrderViewState extends State<PlaceOrderView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PlaceOrderViewModel controller =
        Provider.of<PlaceOrderViewModel>(context, listen: false);
    SelectStoreViewModel storeController =
        Provider.of<SelectStoreViewModel>(context, listen: false);
    storeController.setSelectedStore(widget.args);
    controller.clearData();
    controller.getStoreProducts(
        context, '${Constants.local_url}${widget.args.getapi.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<DashboardUserViewModel>(context, listen: false);
    print('${widget.args.getapi} ${widget.args.postapi}');
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Utils.backDialog(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(200, 230, 201, 1),
          appBar: Utils.backButtonAppbar(context, 'Place Order', () {
            Utils.backDialog(context);
          }),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.scannerView);
              },
              child: Container(
                width: 18.w,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    // BoxShadow(
                    //     color: AppColors.primaryTextColor.withOpacity(0.4),
                    //     blurRadius: 3,
                    //     spreadRadius: 1,
                    //     offset: const Offset(1, 1))
                  ],
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: AppColors.textIconColor,
                  size: 24.sp,
                ),
              ),
            ),
          ),
          body: Consumer<PlaceOrderViewModel>(builder: (context, value, child) {
            return value.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : Container(
                    child: value.cartItemsMap.isEmpty
                        ? SizedBox(
                            child: Center(
                              child: Text(
                                'click on +  to\nadd item on cart',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Expanded(
                                flex: 12,
                                child: ListView.builder(
                                    itemCount: value.cartItemsMap.length,
                                    itemBuilder: (context, index) {
                                      dynamic prod =
                                          value.cartItemsMap.keys.toList();
                                      // print(prod[index]);

                                      Products cartProduct =
                                          value.cartItemsMap[prod[index]]!;
                                      ProductModel prdData = value
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
                                      return ProductItem(
                                        title: data['name'],
                                        code: data['barcode'],
                                        qty: '${data['quantity']}x',
                                        photoUrl: data['photo'],
                                        price: '${data['price']} RS',
                                        onPress: () {
                                          Navigator.pushNamed(context,
                                              RoutesName.productDetailView,
                                              arguments:
                                                  ProductModel.fromJson(data));
                                        },
                                      );
                                    }),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(22),
                                            topRight: Radius.circular(22))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 11,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  List<Products> cartData =
                                                      value.cartItemsMap.values
                                                          .toList();
                                                  value.assignUserIdToCartModel(
                                                      controller.user.sId
                                                          .toString());
                                                  value
                                                      .addFinalProductListToCart(
                                                          cartData);
                                                  dynamic data = jsonEncode(
                                                      value.cart.toJson());
                                                  print(data);
                                                  value.placeOrder(
                                                      '${Constants.local_url}${widget.args.postapi.toString()}',
                                                      data,
                                                      context);
                                                },
                                                child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Rs. ${value.total.toInt()}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineMedium!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .textIconColor),
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: AppColors
                                                                .textIconColor,
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 4,
                                            child: Center(child: Container())),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                  );
          }),
        ),
      ),
    );
  }
}
