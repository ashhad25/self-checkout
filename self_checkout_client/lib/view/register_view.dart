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
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/utils/validation.dart';
import 'package:self_checkout_client/view_model/register_view_model.dart';
import 'package:sizer/sizer.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final TextEditingController _usernameController =
      TextEditingController(text: 'ckkashi007');
  final TextEditingController _emailController =
      TextEditingController(text: 'ckkashi007@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '42372Kash43');

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightPrimaryColor,
        // appBar: PreferredSize(
        //     preferredSize: Size(100.w, 10.h),
        //     child: Container(
        //       // color: Colors.red,
        //       child: Row(
        //         children: [
        //           ButtonIcon(
        //             icon: Icons.arrow_back_ios_new_rounded,
        //             onPress: () {
        //               Navigator.pop(context);
        //             },
        //             padding:
        //                 EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        //           )
        //         ],
        //       ),
        //     )),
        appBar: Utils.backButtonAppbar(context, '', () {
          Navigator.pop(context);
        }),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                      title: 'Display Name',
                      padding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.h),
                      icon: Icons.person_rounded,
                      controller: _usernameController,
                      currentNode: _usernameFocus,
                      nextNode: _emailFocus,
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
                    Consumer<RegisterViewModel>(
                        builder: (context, value, child) {
                      return ButtonRound(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 2.h),
                        title: "Register",
                        onPress: () {
                          String username = _usernameController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          if (username.length > 3) {
                            if (Validation.isValidEmail(email)) {
                              if (password.length > 7) {
                                dynamic data = {
                                  "username": username,
                                  "email": email,
                                  "password": password,
                                };
                                value.register(jsonEncode(data), context);
                              } else {
                                Utils.displayToast('Enter valid password');
                              }
                            } else {
                              Utils.displayToast('Enter valid email');
                            }
                          } else {
                            Utils.displayToast(
                                'Username or displayname should be of minimum 3 charachter');
                          }
                        },
                        borderRadius: BorderRadius.circular(2.8.w),
                        isLoading: value.loading,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
