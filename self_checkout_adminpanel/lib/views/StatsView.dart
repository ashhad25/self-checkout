import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_adminpanel/controller/order_controller.dart';

class StatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderProvider()..fetchOrders(),
      child: Scaffold(
        body: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            if (orderProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text('Total Registered Stores'),
                            trailing: Text('${orderProvider.totalStores}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text('Total Orders'),
                            trailing: Text('${orderProvider.totalOrders}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text('Today\'s Orders'),
                            trailing: Text('${orderProvider.todayOrders}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => AddStoreScreen(),
                    // ));
                  },
                  child: Text('Add Store'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
