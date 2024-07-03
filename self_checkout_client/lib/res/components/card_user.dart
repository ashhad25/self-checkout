import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:sizer/sizer.dart';

class UserCard extends StatelessWidget {
  final String username;
  final String profileUrl;
  final String orderNo;
  const UserCard({
    super.key,
    required this.username,
    required this.profileUrl,
    required this.orderNo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.5.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 3.w),
        width: 100.w,
        // height: 27.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.8.w),
            boxShadow: [
              BoxShadow(
                  color: AppColors.primaryTextColor.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 4)
            ],
            color: AppColors.textIconColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  username.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 24.sp,
                      color: AppColors.primaryTextColor,
                      fontFamily: 'Lato'),
                ),
                // CircleAvatar(
                //   backgroundColor: AppColors.lightPrimaryColor,
                //   radius: 19.sp,
                //   backgroundImage: NetworkImage(profileUrl != ''
                //       ? profileUrl
                //       : 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Orders',
                      style:
                          Theme.of(context).textTheme.labelMedium!.copyWith(),
                    ),
                    Text(
                      orderNo,
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Orders',
            //           style: Theme.of(context).textTheme.titleSmall,
            //         ),
            //         Text(
            //           orderNo,
            //           style: Theme.of(context).textTheme.titleLarge,
            //         )
            //       ],
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
