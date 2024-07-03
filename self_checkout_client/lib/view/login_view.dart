import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/app_icon.dart';
import 'package:self_checkout_client/res/components/border_button.dart';
import 'package:self_checkout_client/res/components/icon_button.dart';
import 'package:self_checkout_client/res/components/round_button.dart';
import 'package:self_checkout_client/res/components/text_field.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/utils/validation.dart';
import 'package:self_checkout_client/view_model/login_view_model.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController _emailController =
      TextEditingController(text: 'ckkashi007@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '42372Kash43');
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // print('build');
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightPrimaryColor,
      appBar: Utils.backButtonAppbar(context, '', () {
        Navigator.pop(context);
      }),
      body: Stack(
        children: [
          SizedBox(
            width: 100.w,
            height: 100.h,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    IconApp(
                      squareSize: 100,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    FieldText(
                      title: 'Email',
                      padding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.h),
                      icon: Icons.email,
                      controller: _emailController,
                      currentNode: _emailFocus,
                      nextNode: _passwordFocus,
                    ),
                    FieldText(
                      title: 'Password',
                      isPassword: true,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.h),
                      icon: Icons.password,
                      controller: _passwordController,
                      currentNode: _passwordFocus,
                      nextNode: FocusNode(),
                    ),
                    Consumer<LoginViewModel>(builder: (context, vm, child) {
                      return ButtonRound(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 2.h),
                        title: "Login",
                        onPress: () {
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          if (Validation.isValidEmail(email)) {
                            if (password.length > 7) {
                              final data = {
                                "email": email,
                                "password": password
                              };
                              vm.login(jsonEncode(data), context);
                            } else {
                              Utils.displayToast('Enter valid password');
                            }
                          } else {
                            Utils.displayToast('Enter valid email');
                          }

                          // final data = {"email": email, "password": password};
                          // vm.login(data, context);
                        },
                        borderRadius: BorderRadius.circular(2.8.w),
                        isLoading: vm.loading,
                      );
                    }),
                    SizedBox(
                      height: 1.h,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Dont have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                                text: 'Register',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, RoutesName.registerView);
                                  }),
                          ]),
                    ),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
