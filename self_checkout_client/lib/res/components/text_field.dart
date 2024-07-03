import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/utils/utils.dart';

class FieldText extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FocusNode currentNode;
  final FocusNode nextNode;
  final IconData icon;
  final bool isPassword;
  final double width, radius;
  final EdgeInsets padding;
  FieldText(
      {super.key,
      required this.title,
      required this.controller,
      this.isPassword = false,
      this.icon = Icons.abc,
      required this.currentNode,
      required this.nextNode,
      this.width = double.infinity,
      this.padding = const EdgeInsets.all(12.0),
      this.radius = 8.0});

  final ValueNotifier<bool> _passVisibility = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ValueListenableBuilder(
          valueListenable: _passVisibility,
          builder: (context, value, child) {
            return TextFormField(
              obscureText:
                  isPassword ? !_passVisibility.value : _passVisibility.value,
              controller: controller,
              focusNode: currentNode,
              onFieldSubmitted: (val) {
                Utils.changeFieldFocus(context, currentNode, nextNode);
              },
              decoration: InputDecoration(
                fillColor: AppColors.textIconColor,
                filled: true,
                hintText: title,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.textIconColor, width: 0),
                    borderRadius: BorderRadius.circular(radius)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.textIconColor, width: 0),
                    borderRadius: BorderRadius.circular(radius)),
                prefixIcon: icon == Icons.abc
                    ? Container(
                        width: 0,
                      )
                    : Icon(
                        icon,
                      ),
                prefixIconColor: AppColors.primaryColor,
                suffixIcon: isPassword
                    ? InkWell(
                        onTap: () {
                          _passVisibility.value = !_passVisibility.value;
                        },
                        child: Icon(_passVisibility.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility))
                    : Container(
                        width: 0,
                      ),
                suffixIconColor: AppColors.primaryColor,
              ),
              cursorColor: AppColors.primaryColor,
            );
          }),
    );
  }
}
