import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';

class ButtonRound extends StatelessWidget {
  final String title;
  final Color bgColor, textColor;
  final EdgeInsets padding;
  final double width, height;
  final VoidCallback onPress;
  final Alignment alignment;
  bool isLoading;
  final BorderRadiusGeometry borderRadius;
  ButtonRound(
      {super.key,
      required this.title,
      required this.onPress,
      this.padding = const EdgeInsets.all(12.0),
      this.width = double.infinity,
      this.height = 55,
      this.bgColor = AppColors.primaryColor,
      this.textColor = AppColors.textIconColor,
      this.alignment = Alignment.center,
      this.isLoading = false,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: InkWell(
          onTap: onPress,
          child: Container(
            width: width,
            height: height,
            decoration:
                BoxDecoration(color: bgColor, borderRadius: borderRadius),
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator(
                      color: textColor,
                    )
                  : Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: textColor),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
