import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:sizer/sizer.dart';

class RowData extends StatelessWidget {
  final String name;
  final String value;
  const RowData({
    super.key,
    required this.name,
    required this.value,
  });

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
              Text(
                '${name}:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Flexible(
                child: Text(
                  value,
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
