import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';

class ButtonBorder extends StatelessWidget {
  final String title;
  final Color borderColor, bgColor, textColor;
  final EdgeInsets padding;
  final double width, height, radius, borderWidth;
  final VoidCallback onPress;
  final Alignment alignment;
  final bool isLoading;
  ButtonBorder(
      {super.key,
      required this.title,
      required this.onPress,
      this.padding = const EdgeInsets.all(12.0),
      this.width = double.infinity,
      this.height = 55,
      this.bgColor = Colors.transparent,
      this.borderWidth = 2,
      this.borderColor = AppColors.primaryColor,
      this.textColor = AppColors.primaryColor,
      this.alignment = Alignment.center,
      this.radius = 30,
      this.isLoading = false});

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
            decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor, width: borderWidth),
                borderRadius: BorderRadius.circular(radius)),
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
                      )),
          ),
        ),
      ),
    );
  }
}
