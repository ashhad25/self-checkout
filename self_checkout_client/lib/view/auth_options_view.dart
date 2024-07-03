import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/app_icon.dart';
import 'package:self_checkout_client/res/components/border_button.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/view_model/auth_view_model.dart';
import 'package:sizer/sizer.dart';

class AuthOptionsView extends StatelessWidget {
  const AuthOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthViewModel().chkUser(context),
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
            // backgroundColor: AppColors.lightPrimaryColor,
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      // height: 175,
                      height: 22.5.h,
                      color: AppColors.lightPrimaryColor.withOpacity(0.5),
                      child: const Center(),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      // height: 150,
                      height: 19.h,
                      color: AppColors.lightPrimaryColor,
                      child: const Center(),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: IconApp(squareSize: 100),
                        )),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(2.5.w),
                        child: ClipPath(
                          clipper: RoundedDiagonalPathClipper(),
                          child: Container(
                            // height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.w)),
                              color: AppColors.lightPrimaryColor,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ButtonBorder(
                                      title: 'Login',
                                      onPress: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.loginView);
                                      },
                                      height: 8.h,
                                      bgColor: AppColors.primaryColor,
                                      textColor: AppColors.textIconColor,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.5.h, horizontal: 5.w),
                                    ),
                                    ButtonBorder(
                                      title: 'Register',
                                      onPress: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.registerView);
                                      },
                                      height: 8.h,
                                      // bgColor: AppColors.primaryColor,
                                      textColor: AppColors.primaryColor,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.5.h, horizontal: 5.w),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
