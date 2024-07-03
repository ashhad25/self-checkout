import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:sizer/sizer.dart';

class HistoryCard extends StatelessWidget {
  final String date;
  final String price;
  const HistoryCard({super.key, required this.date, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.5.w),
      child: Container(
        width: 100.w,
        height: 10.h,
        decoration: BoxDecoration(
          color: AppColors.textIconColor,
          borderRadius: BorderRadius.circular(2.8.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text('$price Rs',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}
