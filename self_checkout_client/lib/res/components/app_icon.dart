import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/utils/constants.dart';
import 'package:sizer/sizer.dart';

class IconApp extends StatelessWidget {
  final double squareSize;
  IconApp({super.key, required this.squareSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: squareSize,
              height: squareSize,
              margin: EdgeInsets.only(bottom: 3.h),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(4.w)),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.textIconColor,
                size: 20.w,
              ),
            ),
            Text(
              Constants.app_title.replaceAll(' ', '\n'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}
