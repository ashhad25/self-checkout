import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/card_history.dart';
import 'package:self_checkout_client/res/components/card_user.dart';
import 'package:self_checkout_client/res/components/icon_button.dart';
import 'package:self_checkout_client/res/components/round_button.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view_model/auth_view_model.dart';
import 'package:self_checkout_client/view_model/dashboard_user_view_model.dart';
import 'package:sizer/sizer.dart';
import '../model/user_model.dart';

class DashboardUserView extends StatefulWidget {
  const DashboardUserView({super.key});

  @override
  State<DashboardUserView> createState() => _DashboardUserViewState();
}

class _DashboardUserViewState extends State<DashboardUserView> {
  @override
  void initState() {
    super.initState();
    DashboardUserViewModel controller =
        Provider.of<DashboardUserViewModel>(context, listen: false);
    controller.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardUserViewModel>(builder: (context, value, child) {
      return SafeArea(
        // child: value.user.username == null
        child: value.loading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await AuthViewModel().remove();
                    value.user = UserModel();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.authOptionsView,
                      (route) => false,
                    );
                  },
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Icons.logout_rounded,
                    color: AppColors.textIconColor,
                  ),
                ),
                backgroundColor: AppColors.lightPrimaryColor,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UserCard(
                        username: value.user.username.toString(),
                        profileUrl: '',
                        orderNo: (value.historyList.length).toString()),
                    ButtonRound(
                        title: 'Select Store',
                        onPress: () {
                          Navigator.pushNamed(
                              context, RoutesName.selectStoreView);
                        },
                        borderRadius: BorderRadius.circular(2.8.w)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.h, horizontal: 3.5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Orders History',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.darkPrimaryColor),
                          ),
                          // ButtonIcon(
                          //   icon: Icons.arrow_forward_ios_rounded,
                          //   onPress: () {},
                          //   iconSize: 18.sp,
                          //   iconColor: AppColors.primaryColor,
                          // )
                        ],
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      child: value.historyList.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'No orders yet'.toUpperCase(),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: value.historyList.length,
                              itemBuilder: (context, index) {
                                print(
                                    value.historyList[index].createdAt == null);
                                final DateFormat formatter =
                                    DateFormat('dd-MM-yyyy');
                                DateTime? date;
                                String? orderDate;
                                if (value.historyList[index].createdAt !=
                                    null) {
                                  date = DateTime.parse(value
                                      .historyList[index].createdAt
                                      .toString());
                                  orderDate = formatter.format(date);
                                } else {
                                  orderDate = 'Recent';
                                }
                                print(orderDate);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.historyDetail,
                                        arguments: value.historyList[index]);
                                  },
                                  child: HistoryCard(
                                      date: '${orderDate}',
                                      price: value.historyList[index].totalprice
                                          .toString()),
                                );
                              }),
                    ))
                  ],
                ),
              ),
      );
    });
  }
}
