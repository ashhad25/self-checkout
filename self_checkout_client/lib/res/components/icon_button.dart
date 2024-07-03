import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final Color bgColor, iconColor;
  final EdgeInsets padding;
  final double circleRadius, iconSize;
  final VoidCallback onPress;
  ButtonIcon(
      {super.key,
      required this.icon,
      required this.onPress,
      this.padding = const EdgeInsets.all(0.0),
      this.circleRadius = 20,
      this.bgColor = Colors.transparent,
      this.iconColor = AppColors.primaryColor,
      this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onPress,
        child: CircleAvatar(
          radius: circleRadius,
          backgroundColor: bgColor,
          foregroundColor: iconColor,
          child: Icon(
            icon,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
