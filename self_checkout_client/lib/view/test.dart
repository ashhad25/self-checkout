import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/border_button.dart';
import 'package:self_checkout_client/res/components/icon_button.dart';
import 'package:self_checkout_client/res/components/round_button.dart';
import 'package:self_checkout_client/res/components/text_field.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:sizer/sizer.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonRound(
              title: 'Show Toast',
              onPress: () {
                Utils.displayToast('This is toast');
              },
              width: 100.w,
              height: 7.5.h,
              borderRadius: BorderRadius.circular(2.w)),
          ButtonIcon(
            icon: Icons.arrow_back,
            onPress: () {},
          ),
          FieldText(
              title: 'Email',
              icon: Icons.email,
              controller: TextEditingController(),
              currentNode: FocusNode(),
              nextNode: FocusNode()),
          FieldText(
              title: 'Password',
              icon: Icons.password,
              isPassword: true,
              controller: TextEditingController(),
              currentNode: FocusNode(),
              nextNode: FocusNode()),
          ButtonBorder(
            title: 'Show Flushbar',
            onPress: () {
              Utils.displayFlushbar(context, 'Checking', 'This is flushbar',
                  AppColors.primaryColor);
            },
            width: 100.w,
            height: 7.5.h,
          )
        ],
      ),
    ));
  }
}
