import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:self_checkout_client/res/components/icon_button.dart';
import 'package:self_checkout_client/view_model/place_order_view_model.dart';
import 'package:sizer/sizer.dart';

class Utils {
  static changeFieldFocus(
      BuildContext context, FocusNode currentNode, nextNode) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  static backDialog(BuildContext context) {
    PlaceOrderViewModel controller =
        Provider.of<PlaceOrderViewModel>(context, listen: false);
    TextTheme textTheme = Theme.of(context).textTheme;
    Dialog current = Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.8.w)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Are you sure?',
              style: textTheme.headlineSmall!
                  .copyWith(color: Colors.red, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "if you go back then your cart items will be removed.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        controller.cartItemsMap.clear();
                        controller.emptyTotal();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Yes')),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primaryColor),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No')),
                ),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (context) => current);
  }

  static itemExistDialog(BuildContext context, dynamic barcode) {
    print(barcode + "chk");
    PlaceOrderViewModel controller =
        Provider.of<PlaceOrderViewModel>(context, listen: false);
    TextTheme textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.8.w),
                topRight: Radius.circular(2.8.w))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Item already exist',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 30.sp),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        controller.decreaseQuantity(barcode);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('-1')),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primaryColor),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        controller.increaseQuantity(barcode);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('+1')),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  static PreferredSize backButtonAppbar(
      BuildContext context, String title, dynamic onPress) {
    return PreferredSize(
        preferredSize: Size(100.w, 10.h),
        child: SizedBox(
          // color: Colors.red,
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 3.h,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppColors.darkPrimaryColor),
                      ),
                    ),
                    ButtonIcon(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onPress: onPress,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  static TextTheme appTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
          fontSize: 99.sp, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      displayMedium: TextStyle(
          fontSize: 62.sp, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      displaySmall: TextStyle(fontSize: 49.sp, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(
          fontSize: 42.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineMedium: TextStyle(
          fontSize: 35.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineSmall: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
      titleLarge: TextStyle(
          fontSize: 21.sp, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      titleSmall: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      labelLarge: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      bodySmall: TextStyle(
          fontSize: 12.sp, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelSmall: TextStyle(
          fontSize: 10.sp, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    );
  }

  static displayToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.lightPrimaryColor,
        textColor: AppColors.primaryTextColor);
  }

  static displayFlushbar(
      BuildContext context, String title, String message, Color bgColor) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          title: title,
          message: message,
          titleColor: AppColors.textIconColor,
          messageColor: AppColors.textIconColor,
          backgroundColor: bgColor,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(8.0),
          forwardAnimationCurve: Curves.bounceIn,
          reverseAnimationCurve: Curves.bounceOut,
          isDismissible: true,
          margin: const EdgeInsets.all(8.0),
        )..show(context));
  }
}
