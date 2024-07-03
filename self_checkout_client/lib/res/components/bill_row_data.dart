import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:sizer/sizer.dart';

class BillRowData extends StatelessWidget {
  final String name;
  final String qty;
  final String price;
  const BillRowData(
      {super.key, required this.name, required this.qty, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightPrimaryColor,
          borderRadius: BorderRadius.circular(2.8.w),
          boxShadow: const [
            // BoxShadow(
            //     color: AppColors.darkPrimaryColor.withOpacity(0.8),
            //     blurRadius: 0,
            //     spreadRadius: 0,
            //     offset: Offset(5, 0)),
            // BoxShadow(
            //     color: AppColors.primaryTextColor.withOpacity(1.0),
            //     blurRadius: 0,
            //     spreadRadius: 0,
            //     offset: Offset(-5, 0)),
            // BoxShadow(
            //     color: AppColors.primaryTextColor.withOpacity(0.5),
            //     blurRadius: 3,
            //     spreadRadius: 0,
            //     offset: Offset(0, 0)),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${name}',
                  style: Theme.of(context).textTheme.titleLarge,
                  textScaleFactor: 0.7,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
              ),
              Flexible(
                child: Center(
                  child: Text(
                    '${qty.toString()}x',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.darkPrimaryColor,
                        ),
                    textScaleFactor: 0.7,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  '${double.parse(price) * double.parse(qty)}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.darkPrimaryColor,
                      ),
                  textScaleFactor: 0.7,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
