import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:self_checkout_client/view_model/place_order_view_model.dart';
import 'package:sizer/sizer.dart';

class ProductItem extends StatelessWidget {
  final String title, code, photoUrl, qty, price;
  final VoidCallback onPress;
  const ProductItem({
    super.key,
    required this.title,
    required this.code,
    required this.photoUrl,
    required this.qty,
    required this.price,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: 100.w,
          height: 22.h,
          decoration: BoxDecoration(
            color: AppColors.textIconColor,
            borderRadius: BorderRadius.circular(2.8.w),
            boxShadow: [
              BoxShadow(
                  color: AppColors.primaryTextColor.withOpacity(0.25),
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: const Offset(0, 0))
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
                child: Container(
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(2.8.w),
                    image: DecorationImage(
                        image: NetworkImage("${Constants.local_url}$photoUrl"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      code,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryTextColor,
                          ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Consumer<PlaceOrderViewModel>(
                        builder: (context, value, child) {
                      return Row(
                        children: [
                          InkWell(
                              onTap: () {
                                value.decreaseQuantity(code);
                              },
                              child: Icon(
                                Icons.remove,
                                size: 20,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            qty,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.primaryTextColor,
                                ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                value.increaseQuantity(code);
                              },
                              child: Icon(
                                Icons.add,
                                size: 20,
                              )),
                        ],
                      );
                    }),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Flexible(
                      child: Text(
                        price,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.primaryTextColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
